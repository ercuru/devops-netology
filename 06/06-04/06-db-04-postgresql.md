# Домашнее задание к занятию 4. «PostgreSQL»

## Задача 1
> 
> Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
> 
> Подключитесь к БД PostgreSQL, используя `psql`.
> 
> Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.
> 
> **Найдите и приведите** управляющие команды для:
> 
> - вывода списка БД,
> - подключения к БД,
> - вывода списка таблиц,
> - вывода описания содержимого таблиц,
> - выхода из psql.

### Решение 1

- соберем и запустим контейнер

```
docker pull postgres:13
docker volume create pg_data
docker volume create pg_etc
docker run --rm --name psg -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v pg_data:/var/lib/postgresql -v pg_etc:/etc postgres:13

```
- подключимся и выведем справку

```
docker exec -it psg bash
psql -U postgres
postgres=# \?
General
  \copyright             show PostgreSQL usage and distribution terms
  \crosstabview [COLUMNS] execute query and display results in crosstab
  \errverbose            show most recent error message at maximum verbosity
  \g [(OPTIONS)] [FILE]  execute query (and send results to file or |pipe);
                         \g with no arguments is equivalent to a semicolon
  \gdesc                 describe result of query, without executing it
  \gexec                 execute query, then execute each value in its result
  \gset [PREFIX]         execute query and store results in psql variables
  \gx [(OPTIONS)] [FILE] as \g, but forces expanded output mode
  \q                     quit psql
  \watch [SEC]           execute query every SEC seconds

Help
  \? [commands]          show help on backslash commands
  \? options             show help on psql command-line options
  \? variables           show help on special variables
  \h [NAME]              help on syntax of SQL commands, * for all commands

Query Buffer
  \e [FILE] [LINE]       edit the query buffer (or file) with external editor
  \ef [FUNCNAME [LINE]]  edit function definition with external editor
  \ev [VIEWNAME [LINE]]  edit view definition with external editor
  \p                     show the contents of the query buffer
  \r                     reset (clear) the query buffer
  \s [FILE]              display history or save it to file
  \w FILE                write query buffer to file

Input/Output
  \copy ...              perform SQL COPY with data stream to the client host
  \echo [-n] [STRING]    write string to standard output (-n for no newline)
--More--
```
- список нужных команд 

``` 
> вывод списка БД

\l[+]   [PATTERN]      list databases

> подключения к БД

  \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "postgres")

> вывода списка таблиц

\dt[S+] [PATTERN]      list tables

> вывода описания содержимого таблиц

\d[S+]  NAME           describe table, view, sequence, or index

> выхода из psql

\q                     quit psql
```


## Задача 2
> 
> Используя `psql`, создайте БД `test_database`.
> 
> Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).
> 
> Восстановите бэкап БД в `test_database`.
> 
> Перейдите в управляющую консоль `psql` внутри контейнера.
> 
> Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.
> 
> Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
> с наибольшим средним значением размера элементов в байтах.
> 
> **Приведите в ответе** команду, которую вы использовали для вычисления, и полученный результат.

### Решение 2

- скачаем бэкап

```
wget https://raw.githubusercontent.com/netology-code/virt-homeworks/virt-11/06-db-04-postgresql/test_data/test_dump.sql
sudo cp test_dump.sql /var/lib/docker/volumes/pg_etc/_data/ 
```
- создаем таблицу и восстанавливаем бэкап

```
psql -U postgres
CREATE DATABASE test_database;
```
```
psql -f /etc/test_dump.sql test_database -U postgres
```

- подключаемся и выведем ANALYSE

```
psql -U postgres
\c test_database

test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```
- выведем размеры
```
test_database=# SELECT avg_width, attname FROM pg_stats WHERE tablename='orders';
 avg_width | attname
-----------+---------
         4 | id
        16 | title
         4 | price
(3 rows)
```
## Задача 3
> 
> Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
> поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили
> провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.
> 
> Предложите SQL-транзакцию для проведения этой операции.
> 
> Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?
> 

### Решение 3 

- для этого можно сделать так:

```
test_database=# CREATE TABLE orders_over_499 (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_over_499 SELECT * FROM orders WHERE price > 499;
INSERT 0 3
test_database=# CREATE TABLE orders_below_499 (CHECK (price <= 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_below_499 SELECT * FROM orders WHERE price <= 499;
INSERT 0 5

test_database=# \dt+
                                   List of relations
 Schema |       Name       | Type  |  Owner   | Persistence |    Size    | Description
--------+------------------+-------+----------+-------------+------------+-------------
 public | orders           | table | postgres | permanent   | 8192 bytes |
 public | orders_below_499 | table | postgres | permanent   | 8192 bytes |
 public | orders_over_499  | table | postgres | permanent   | 8192 bytes |
(3 rows)

test_database=# SELECT * FROM orders_below_499;
 id |        title         | price
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)

test_database=# SELECT * FROM orders_over_499;
 id |       title        | price
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)
```

Изначально заложить разбиение базы возможно с использованием секционирования (Partitioning) и добавления RULE для добавления значений в нужные части

## Задача 4
> 
> Используя утилиту `pg_dump`, создайте бекап БД `test_database`.
> 
>  Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

### Решение 4
- создаем бэкап

```
pg_dump -U postgres -d test_database > /etc/test_database_dump.sql
```

- для добавления критерия уникальности используется UNIQUE

```
test_database=# CREATE TABLE public.uorders (
    id integer,
    title character varying(80) UNIQUE,
    price integer
);
```

