    Title: PostgreSQL Internals: TRUNCATE
    Date: 2019-03-20T00:00:00
    Tags: postgres, internals

You can use TRUNCATE in postgres to delete all of the rows in a table. The main advantage of it compared to using DELETE is performance. For example, using DELETE to delete all rows in a table with 1 million rows takes about 2.3 seconds, but truncating the same table would take about 10ms.

But how does postgres implement TRUNCATE that it is so fast?

<!-- more -->

## What happens when you DELETE?

Each transaction in postgres has a unique transaction id. Postgres for each row keeps the identifiers of earliest transaction (xmin) and the latest transaction (xmax) that can see the row. This helps postgres with concurrency control, but what is relevant to our topic is that when you do a DELETE, postgres iterates over all rows in the table and marks their xmax as the identifier of the current transaction. The row is still physically there, but it won’t be visible to future transactions.

Later, in a process called vacuuming, postgres physically deletes the rows from the disk. To learn more about MVCC and vacuuming in postgres, checkout [this blogpost](https://www.percona.com/blog/2018/08/06/basic-understanding-bloat-vacuum-postgresql-mvcc/).

## Where does postgres store table data?

You can get the location of the physical file for a relation using [pg_relation_filepath(relname)](https://www.postgresql.org/docs/11/functions-admin.html#FUNCTIONS-ADMIN-DBLOCATION). For example,

```sql
postgres=# SELECT pg_relation_filepath('a');
 pg_relation_filepath
----------------------
 base/12368/16384
(1 row)
```

In the output above, 12368 is the database oid, which you can also get from the catalog table [pg_database](https://www.postgresql.org/docs/11/catalog-pg-database.html). 16384 is the relation’s file node number. Every postgres table has an entry in the catalog table [pg_class](https://www.postgresql.org/docs/11/catalog-pg-class.html). pg_class has a column named relfilenode, which is the name of the physical file used to store the table data. You can also use pg_relation_filenode(relname) to get this value.

So postgres stores the table data in $PGDATA/base/DATABASE_OID/RELFILENODE.

(There are some more details on the postgres file layout which are not very relevant to our discussion here. See “[Database File Layout](https://www.postgresql.org/docs/11/storage-file-layout.html)” for details).

## What happens when you TRUNCATE?

As we saw, the physical file used for storing table data is determined by its file node number. The way TRUNCATE works is to assign a new file node number to the relation, and schedule the previous physical file for deletion on transaction commit!

As you can see, using DELETE to delete all table data requires a full table scan and setting xmax of all of the rows. But TRUNCATE is as simple as updating a row in pg_class and unlinking a physical file, which is a much faster operation.

This can be verified by checking the result of pg_relation_filenode(relname) before and after doing TRUNCATE:

```sql

postgres=# select pg_relation_filenode('a');
 pg_relation_filenode
----------------------
                16384
(1 row)

postgres=# TRUNCATE a;
TRUNCATE TABLE

postgres=# select pg_relation_filenode('a');
 pg_relation_filenode
----------------------
                16387
(1 row)

```

## In the Code

Entry point for TRUNCATE is [ExecuteTruncate()](https://github.com/postgres/postgres/blob/REL_11_STABLE/src/backend/commands/tablecmds.c#L1312) in src/backend/commands/tablecmds.c. This function opens each relation to be truncated using an AccessExclusiveLock, does some checks, and then calls [ExecuteTruncateGuts()](https://github.com/postgres/postgres/blob/REL_11_STABLE/src/backend/commands/tablecmds.c#L1417). 


We’ll look at what the checks are and why postgres is acquiring an AccessExclusiveLock in future parts. For now, let’s continue with ExecuteTruncateGuts(). The part in ExecuteTruncateGuts() that we are most interested is [where it creates the new relation file node](https://github.com/postgres/postgres/blob/REL_11_STABLE/src/backend/commands/tablecmds.c#L1609):

```c

/*
 * Need the full transaction-safe pushups.
 *
 * Create a new empty storage file for the relation, and assign it
 * as the relfilenode value. The old storage file is scheduled for
 * deletion at commit.
 */
RelationSetNewRelfilenode(rel, rel->rd_rel->relpersistence,
                            RecentXmin, minmulti);

``` 

[RelationSetNewRelfilenode()](https://github.com/postgres/postgres/blob/REL_11_STABLE/src/backend/utils/cache/relcache.c#L3311) allocates a new relation file node, schedules the relation for deletion at commit, and updates the pg_class row with the new file node (Well, unless it is a mapped relation, but let’s overlook that for now).

The deletion of storage at commit is done by calling [RelationDropStorage()](https://github.com/postgres/postgres/blob/REL_11_STABLE/src/backend/catalog/storage.c#L139). Postgres keeps a linked list of relation file nodes to be deleted at transaction finish (i.e. in a commit or an abort) in the [pendingDeletes](https://github.com/postgres/postgres/blob/REL_11_STABLE/src/backend/catalog/storage.c#L63) link list:


```c

typedef struct PendingRelDelete
{
	RelFileNode relnode;          /* relation that may need to be deleted */
	BackendId backend;            /* InvalidBackendId if not a temp rel */
	bool atCommit;                /* T=delete at commit; F=delete at abort */
	int nestLevel;                /* xact nesting level of request */
	struct PendingRelDelete *next;/* linked-list link */
} PendingRelDelete;

static PendingRelDelete *pendingDeletes = NULL; /* head of linked list */

```


RelationDropStorage() just adds an entry to this linked list. Later, when transaction is aborted or committed, [smgrDoPendingDeletes()](https://github.com/postgres/postgres/blob/REL_11_STABLE/src/backend/catalog/storage.c#L293) is called which goes over pendingDeletes and applies the changes.

