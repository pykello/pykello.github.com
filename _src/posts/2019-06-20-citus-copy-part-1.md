    Title: Citus Notes: COPY
    Date: 2019-06-20T00:00:00
    Tags: postgres, citus, internals

(These are some notes I took while studying Citus code, so it is probably more detail oriented
than higher picture oriented).

Citus overrides the utility hook with [`multi_ProcessUtility`](https://github.com/citusdata/citus/blob/6741ffd716593f09b22a01dab70f64d7c62922cd/src/backend/distributed/commands/utility_hook.c#L97). This function calls
[`ProcessCopyStmt()`](https://github.com/citusdata/citus/blob/6741ffd716593f09b22a01dab70f64d7c62922cd/src/backend/distributed/commands/multi_copy.c#L2556) for COPY statements,
which calls [`CitusCopyFrom()`](https://github.com/citusdata/citus/blob/6741ffd716593f09b22a01dab70f64d7c62922cd/src/backend/distributed/commands/multi_copy.c#L181),
which calls [`CopyToExistingShards()`](https://github.com/citusdata/citus/blob/6741ffd716593f09b22a01dab70f64d7c62922cd/src/backend/distributed/commands/multi_copy.c#L317).

`CopyToExistingShards()` uses the
[`postgres/src/include/commands/copy.h`](https://github.com/postgres/postgres/blob/master/src/include/commands/copy.h) API to read tuples:

 * `BeginCopyFrom()`
 * `NextCopyFrom()`
 * `EndCopyFrom()`

and it uses the `CitusCopyDestReceiver` API to write tuples.
`CitusCopyDestReceiver` is a specialization of postgres’ DataReceiver,
which contains the following methods:

 * `rStartup`/`rShutdown`: per-executor-run initialization and shutdown
 * `rDestroy`: destroy the object itself.
 * `receiveSlot`: called for each tuple to be output.

<!-- more -->

## CitusCopyDestReceiver

### Why?
You might wonder why would we need to comply with the `DestReceiver` API? Looking at the implementation of `CopyToExistingShards()`, we really didn’t need to comply with any API and we could just call some sort of startup/receive/shutdown functions without creating a `DestReceiver`?

The reason is that Citus also handles “`INSERT INTO distributed_table SELECT ...`” as a COPY command.
We need a way to get tuples in the “`SELECT …`” part of the statement. `DestReceiver` is postgres’
generic tuple target. Look closely at
[`ExecutePlanIntoDestReciever()`](https://github.com/citusdata/citus/blob/96d9847aa4628de2b4a20c6d3b8e219140393b1d/src/backend/distributed/executor/multi_executor.c#L449).
Here Citus asks postgres to run the given planned query, and send each of the tuples to the given 
`DestReciever`. `CitusCopyDestReceiver` receives those tuples and sends them to the worker nodes.


### CitusCopyDestReceiverStartup (implements DestReceiver->rStartup)
Does the necessary checks (e.g. has shards already been created?), acquires necessary locks, and does some initialization (e.g. loads column output functions, etc.)


### CitusCopyDestReceiverReceive (implements DestReceiver->receiveSlot)

1. Extracts the partition column value of the tuple
2. Based on value of partition column, finds the shard the tuple need to be sent to.
3. If this is the first tuple for that shard,
    * Opens connections to all placements of that shards,
    * Starts the COPY statement at the connection. 

4. Sends the COPY data over all connections for placements of that shard.
    * Serialize data
    * SendCopyDataToAll() calls SendCopyDataToPlacement() for each placement,
      which calls PutRemoteCopyData() for the placement connection, which actually
      uses the libpq API to put the COPY data on the connection, and if the data on
      the line is more than 8MB, it flushes the data for that connection.


### CitusCopyDestReceiverShutdown (implements DestReceiver->rShutdown)

For each of the connections we opened, sends the necessary footers, ends the copy command, and checks the result of COPY command for errors.
