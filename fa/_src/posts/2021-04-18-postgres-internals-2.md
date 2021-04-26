    Title: پستگرس چگونه کار می‌کند؟ جلسه دو - جدول‌های سیستمی
    Date: 2021-04-18T00:00:00
    Tags: پستگرس

لینک ویدئو: [youtu.be/hHkubRh-LXw](https://youtu.be/hHkubRh-LXw)

در [جلسه یک](/fa/2021/04/پستگرس-چگونه-کار-می-کند-جلسه-یک-زندگی-یک-کوئری.html) گفتیم که پستگرس پس از parse کردن کوئری، در مرحله آنالیز
ارجاعات به جداول، ستون‌ها، ... را بررسی می‌کند.

مثلا در کوئری زیر:

```
SELECT a, b FROM t WHERE a > 0;
```

باید ارجاعات زیر بررسی شوند:

۱. آیا جدولی به نام t وجود دارد؟ در صورت وجود، فراداده‌ی مربوط به t (مثل مسیر فایل داده) چیست؟
۲. آیا جدول t ستون‌هایی به نام a و b دارد؟ در صورت وجود، این ستون‌ها چندمین ستون‌ها در این جدول هستند؟
۳. نوع داده‌های ستون‌های a و b چیست؟
۴. فرض کنید نوع ستون a عدد صحیح است. آیا عمل `a > 0` برای اعداد صحیح تعیین شده است؟ اگر بلی، برای انجام این عمل باید از چه تابعی باید استفاده شود؟

در این بخش به این می‌پردازیم که پستگرس چگونه به سوال‌های بالا پاسخ می‌دهد.

<!-- more -->

### پیش‌نیازها

برای دنبال کردن این بخش نیازی ندارید [جلسه یک](/fa/2021/04/پستگرس-چگونه-کار-می-کند-جلسه-یک-زندگی-یک-کوئری.html) را خوانده باشید.

ولی نیاز دارید که پستگرس را کامپایل و نصب کرده باشید. گام‌های لازم برای این امر را در 
[این مقاله](/fa/2020/05/پستگرس-چگونه-کار-می-کند-جلسه-صفر.html) آورده‌ام.

## فراداده‌ی جدول: pg_class

فراداده‌ی مربوط به جدول‌ها در جدول سیستمی pg_class قرار دارد. مثلا برای اینکه فراداده جدول به نام t را ببینیم، می‌توانیم از کوئری زیر استفاده کنیم. بخش‌هایی از خروجی را در زیر می‌بینید:

```
postgres=# SELECT * FROM pg_class WHERE relname='t';
-[ RECORD 1 ]-------+------
oid                 | 16394
relname             | t
...
relfilenode         | 16394
...
relkind             | r
relnatts            | 2
...
```

در خروجی بالا:

* مقدار relname نام جدول است.
* مقدار oid شماره داخلی جدول است. در آینده خواهیم دید که این شماره در جدول‌های سیستمی دیگر (مثلا جدول مربوط به ستون‌ها) برای اشاره به جدول استفاده می‌شود.
* مقدار relkind نشان می‌دهد که این رکورد در pg_class در واقع مربوط به یک جدول است. جدول سیستمی pg_class می‌تواند شامل فراداده ایندکس، view، ... نیز باشد که برای آن موارد مقدار relkind متفاوت خواهد بود.
* مقدار relnatts تعداد ستون‌های جدول را نشان می‌دهد.

#### relfilenode

در خروجی بالا مقدار relfilenode نام فایلی است که در دیسک برای ذخیره اطلاعات جدول t استفاده شده است. مسیر کامل فایل از فرمول زیر به دست می‌آید:

```
$PGDATA/base/$database_id/$relfilenode
```

که `$PGDATA` مسیر دایرکتوری کلاستر پستگرس است. اسم این دایرکتوری را موقع اجرای initdb انتخاب کردید. اگر مسیر این دایرکتوری را فراموش کرده‌اید، از دستور زیر می‌توانید استفاده کنید:

```
postgres=# show data_directory;
-[ RECORD 1 ]--+----------------
data_directory | /home/hadi/data
```

`$database_id` شماره داخلی دیتابیس است. اسم دیتابیسی که ما استفاده می‌کنیم postgres است. برای یافتن شماره آن می‌توانید از جدول pg_class استفاده کنید:

```
postgres=# select oid from pg_database where datname='postgres';
  oid
-------
 12675
(1 row)
```

پس برای جدول بالا مسیر فایل مربوط به جدول t، خواهد بود: `/home/hadi/data/base/12675/16394`.

برای آسانی، می‌توانید از دستور زیر نیز برای یافتن مسیر فایل استفاده کنید:

```
postgres=# SELECT pg_relation_filepath('t');
 pg_relation_filepath
----------------------
 base/12675/16394
(1 row)
```

#### آیا relfilenode همیشه با شماره جدول یکسان است؟

در خروجی بالا دیدیم که هم شماره جدول (oid) و هم relfilenode یکسان و برابر با 16394 بودند. مقدار اولیه این دو یکسان است. مقدار شماره جدول هیچ‌گاه تغییر نمی‌کند، ولی برخی دستورات
هستند که ممکن است relfilenode را تغییر دهند. مثلا دستور TRUNCATE که تمام سطرهای یک جدول را حذف می‌کند:

```
postgres=# truncate t;
TRUNCATE TABLE
postgres=# select oid, relfilenode from pg_class where relname='t';
  oid  | relfilenode
-------+-------------
 16394 |       24586
(1 row)
```

پیاده‌سازی داخلی TRUNCATE ابتدا یک فایل خالی با نام relfilenode جدید ایجاد می‌کند، سپس مقدار relfilenode را در pg_class تغییر می‌دهد، و سپس فایل قدیمی را پاک می‌کند.

#### منابع بیشتر

* [اطلاعات کامل درباره pg_class](https://www.postgresql.org/docs/current/catalog-pg-class.html)
* [کد تغییر relfilenode](https://github.com/postgres/postgres/blob/091e22b2e673e3e8480abd68fbb827c5d6979615/src/backend/utils/cache/relcache.c#L3576)

## فراداده ستون‌ها: pg_attribute

اینکه جدول چه ستون‌هایی دارد و نوع آن ستون‌ها چیست را می‌توانیم با استفاده از جدول سیستمی pg_attribute
به دست بیاوریم.

به ازای هر ستون جدول در pg_attribute یک سطر وجود دارد. علاوه بر این هر جدولی یک سری ستون‌های
سیستمی مانند cmax, xmax, cmin, xmin, ... دارد که به ازای آن‌ها نیز یک سر در pg_attribute وجود دارد.

به این ستون‌های سیستمی در جلسات آینده خواهیم پرداخت.

برای اینکه تنها اطلاعات مربوط به ستون‌های غیر سیستمی جدول را ببنیم، شرط `attnum > 0` را به کوئری زیر اضافه می‌کنیم:

```
postgres=# select * from pg_attribute where attrelid = 16394 and attnum > 0;
```

در کوئری بالا فرض شده است که شماره جدول t برابر با 16394 است. مقدار آن را در بالا از pg_class
به دست آوردیم.

خروجی کوئری بالا خواهد بود:

```
-[ RECORD 1 ]--+------
attrelid       | 16394
attname        | a
atttypid       | 23
...
attnum         | 1
...
attisdropped   | f
...
-[ RECORD 2 ]--+------
attrelid       | 16394
attname        | b
atttypid       | 23
...
attnum         | 2
...
attisdropped   | f
...
```

از جمله اطلاعاتی که در خروجی بالا می‌بینیم:

1. شماره ترتیبی هر ستون (attnum)
2. اسم ستون (attname)
3. اینکه آیا ستون حذف شده است یا نه (attisdropped)

#### حذف کردن یک ستون

مثلا فرض کنید که دو دستور زیر را اجرا کنیم تا یک ستون حذف شود و یک ستون اضافه شود:

```
ALTER TABLE t DROP COLUMN b;
ALTER TABLE t ADD COLUMN c text;
```

اطلاعات ستون‌ها به صورت زیر تغییر خواهد کرد:

```
postgres=# select attname, attnum, attisdropped from pg_attribute where attrelid = 16394 and attnum > 0;
-[ RECORD 1 ]+-----------------------------
attname      | a
attnum       | 1
attisdropped | f
-[ RECORD 2 ]+-----------------------------
attname      | ........pg.dropped.2........
attnum       | 2
attisdropped | t
-[ RECORD 3 ]+-----------------------------
attname      | c
attnum       | 3
attisdropped | f
```

همانطور که مشاهده می‌کنید فیلد attisdropped ستون دوم به مقدار true تغییر کرد و اسم آن نیز تغییر کرد.

به اینکه چرا این ستون کلا حذف نشد در جلسات آینده خواهیم پرداخت.

#### منابع بیشتر

* [اطلاعات کامل درباره pg_attribute](https://www.postgresql.org/docs/current/catalog-pg-attribute.html)


## فراداده نوع‌ها: pg_type

اکنون که با استفاده از pg_attribute شماره نوع ستون‌ها را بدست آوردیم، می‌توانید با استفاده از 
جدول سیستمی pg_type به جزییات نوع‌ها نگاه کنیم.

مثلا در مثال قبلی نوع ستون a شماره 23 داشت. برای مشاهده اطلاعات این نوع از کوئری زیر استفاده می‌کنیم:

```
postgres=# SELECT * FROM pg_type WHERE oid=23;
-[ RECORD 1 ]--+---------
oid            | 23
typname        | int4
...
typlen         | 4
...
typinput       | int4in
typoutput      | int4out
...
```

که اطلاعاتی مانند اسم نوع (typname)، طول یک مقدار از این نوع (typlen)، تابع تبدیل رشته به این نوع
(int4in)، و تابع تبدیل این نوع به رشته (int4out) را به ما میدهد.

#### منابع بیشتر

* [اطلاعات کامل درباره pg_type](https://www.postgresql.org/docs/current/catalog-pg-type.html)

## فراداده عملگرها و توابع: pg_operator و pg_proc

برای اینکه بفهمیم مقایسه `a > 0` در مثالی که در بالا زدیم چگونه باید اجرا کنیم، مراحل زیر را
انجام می‌دهیم:

1. با استفاده از pg_operator عملگری که نمادش `>` است و دو عدد صحیح را مقایسه می‌کند را پیدا می‌کنیم
2. از رکورد pg_operator اسم تابعی که این عمل به دست می‌آوریم.
3. در pg_proc تابعی که در مرحله ۲ یافتیم را پیدا می‌کنیم. رکورد مرتبط در pg_proc اطلاعات کافی برای اجرای تابع را دارد.

مثلا نوع عدد صحیح ۴ بایتی در مثال قبلی دارای شماره 23 بود. برای یافتن عمل مقایسه دو عدد صحیح:

```
postgres=# select * from pg_operator where oprname='<' and oprleft=23 and oprright=23;
-[ RECORD 1 ]+----------------
oid          | 97
oprname      | <
...
oprleft      | 23
oprright     | 23
oprresult    | 16
...
oprcode      | int4lt
...
```

از خروجی بالا میفهمیم که خروجی این عملگر دارای نوع 16 یا همون بولین است و اسم تابعی که این
عملگر را اجرا می‌کند int4lt است.

برای یافتن اطلاعات مربوط به int4lt:

```
postgres=# select * from pg_proc where proname='int4lt';
-[ RECORD 1 ]---+-------
oid             | 66
proname         | int4lt
...
prolang         | 12
...
proargtypes     | 23 23
...
prosrc          | int4lt
...
```

در خروجی بالا ذکر شده است که زبان این تابع 12 است. برای یافتن اطلاعات مربوط به زبان 12:

```
postgres=# select * from pg_language where oid=12;
-[ RECORD 1 ]-+---------
oid           | 12
lanname       | internal
...
```

از کنار گذاشتن دو خروجی اخیر میفهمیم که int4lt  یک تابع داخلی در سورس کد پستگرس است.

این تابع داخلی در [postgres/src/backend/utils/adt/int.c](https://github.com/postgres/postgres/blob/c30f54ad732ca5c8762bb68bbe0f51de9137dd72/src/backend/utils/adt/int.c#L393)
میتوانید بیابید.

#### منابع بیشتر

* [اطلاعات کامل درباره pg_operator](https://www.postgresql.org/docs/current/catalog-pg-operator.html)
* [اطلاعات کامل درباره pg_proc](https://www.postgresql.org/docs/current/catalog-pg-proc.html)

## مثال

با چیزهایی که در این جلسه یادگرفتیم، می‌خواهیم یک تابع بنویسیم که اسم جدول را به صورت یک
رشته متنی بگیرد و دستور CREATE TABLE آن را به صورت رشته متنی خروجی دهد.

در ویدئو به طور کامل این را توضیح دادیم. نتیجه نهایی عبارت بود از:

```sql
CREATE FUNCTION table_name_to_create_table(table_name text) RETURNS text
AS $$
  SELECT 'CREATE TABLE ' || relname || '(' ||
         string_agg(attname || ' ' || typname, ', ') || ')'
  FROM pg_type, pg_class, pg_attribute
  WHERE relname=table_name and
        pg_class.oid=pg_attribute.attrelid and
        attnum > 0 and not attisdropped and
        pg_type.oid=atttypid
  group by relname;
$$ LANGUAGE sql;
```

برای جزئیات به ویدئو مراجعه کنید.

## تکلیف کار در خانه 😉

ثال را تغییر دهید تا با استفاده از فیلد attnotnull جدول pg_attribute برای هر ستون NOT NULL یا NULL
درست را اضافه کند.

مثلا اگر جدول به صورت زیر ایجاد شده باشد،

```
CREATE TABLE t(a int NOT NULL, b int);
```

خروجی تابعی که در بخش مثال نوشتیم مشخصه NOT NULL ستون اول را ذکر نخواهد کرد. تغییری دهید تا این مشکل
برطرف شود.

اگر مشکلی در دنبال کردن این مقاله یا ویدئو داشتید، اگر پیشنهاد یا انتقادی داشتید، یا اگر سوالی داشتید، میتوانید از روش‌های زیر با من تماس بگیرید:

1. پیام مستقیم در تویتر به اکانت pykello_fa
2. ایمیل به hadi [at] moshayedi [dot] net.

ممنون که وقت گذاشتید و امیدوارم استفاده کرده باشید.