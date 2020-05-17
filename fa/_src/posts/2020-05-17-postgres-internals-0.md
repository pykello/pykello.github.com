    Title: پستگرس چگونه کار می‌کند؟ جلسه صفر
    Date: 2020-05-17T00:00:00
    Tags: پستگرس


در این سری از ویدئوها به بررسی اینکه پستگرس (Postgres یا PostgreSQL) چگونه کار می‌کند می‌پردازیم. برخی از سوالاتی که سعی می‌کنیم به آن‌ها پاسخ دهیم:

۱. پستگرس چگونه داده‌ها را ذخیره می‌کند؟
۲. پستگرس چگونه همروندی را مدیریت می‌کند؟
۳. پستگرس چگونه خطا را مدیریت می‌کند؟
۴. پستگرس چگونه query ها را اجرا می‌کند؟

این سری ویدئوها به آموزش استفاده از پستگرس نمی‌پردازند، و فرض می‌کند که شما تا حدی با مفهوم پایگاه داده و نرم‌افزار پستگرس و زبان SQL آشنا هستید.

<!-- more -->

## ویدئو

(لینک ویدئو)

## یادداشت‌ها

### کامپایل و نصب پستگرس

**نصب پیش نیازها**

برای لیست نرم‌افزارهایی که پیش‌نیاز کامپایل پستگرس هستند به این لینک مراجعه کنید: https://www.postgresql.org/docs/12/install-requirements.html

برای نصب پیش‌نیازها در اوبونتو:

```
sudo apt-get install build-essential libreadline-dev zlib1g-dev
sudo apt-get install flex bison libssl-dev
```

برای نصب پیش‌نیازها در ردهت:

```
sudo yum install -y bison-devel readline-devel zlib-devel openssl-devel wget
sudo yum groupinstall -y 'Development Tools'
```

**دریافت سورس‌کد و کامپایل**

ابتدا مسیری را برای نصب پستگرس در نظر بگیرید:

```
export PGPATH=$HOME/pg/12
```

سپس سورس‌کد را از مخزن پستگرس در گیت‌هاب دریافت کرده و به شاخه نسخه ۱۲ بروید:

```
git clone git@github.com:postgres/postgres.git
cd postgres
git checkout REL_12_STABLE
```

و بالاخره کامپایل و نصب:

```
./configure --prefix=$PGPATH --enable-cassert --enable-debug --enable-depend --with-openssl
make -j 8
make install
```

سپس فایل‌های باینری پستگرس را به مسیر اضافه کنید:

```
echo PATH=$PGPATH:\$PATH >> ~/.bashrc
export PATH=$PGPATH:$PATH
```

برای امتحان اینکه نصب پستگرس با موفقیت انجام شده است، دستور زیر را اجرا کنید:

```
pg_config --version
```

خروجی دستور بالا باید چیزی مثل `PostgreSQL 12.1` باشد.



