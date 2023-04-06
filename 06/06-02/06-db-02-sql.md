# Домашнее задание к занятию "6.2. SQL"

## Задача 1
> 
> Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
> в который будут складываться данные БД и бэкапы.
> 
> Приведите получившуюся команду или docker-compose манифест.

### Решение 1

- dockerfile

```
version: '3'

volumes:
  vol1: {}
  vol2: {}

services:

  postgres:
    image: postgres:12
    container_name: pg
    ports:
      - "0.0.0.0:5532:5432"
    volumes:
      - vol1:/home/andrey/practise/netology/6_2/data1
      - vol2:/home/andrey/practise/netology/6_2/data2
    environment:
      POSTGRES_PASSWORD: "postgres"
    restart: always
```
- $ docker pull postgres:12
- $ docker images
```
REPOSITORY   TAG       IMAGE ID       CREATED      SIZE
postgres     12        43dec67e8efe   9 days ago   373MB
```
- $ docker-compose up -d

## Задача 2
>
> В БД из задачи 1: 
> - создайте пользователя test-admin-user и БД test_db
> - в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
> - предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
> - создайте пользователя test-simple-user  
> - предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
> 
> Таблица orders:
> - id (serial primary key)
> - наименование (string)
> - цена (integer)
> 
> Таблица clients:
> - id (serial primary key)
> - фамилия (string)
> - страна проживания (string, index)
> - заказ (foreign key orders)
> 
> Приведите:
> - итоговый список БД после выполнения пунктов выше,
> - описание таблиц (describe)
> - SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
> - список пользователей с правами над таблицами test_db

### Решение 2

- $ docker exec -it pg bash
- psql -U postgres
- CREATE DATABASE test_db;
- psql -d test_db -U postgres
- CREATE TABLE orders (id INT PRIMARY KEY, name text, price INT);
```
test_db=# CREATE TABLE orders (id INT PRIMARY KEY, name text, price INT);
CREATE TABLE
test_db=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)
```
- CREATE TABLE clients (id INT PRIMARY KEY, surname char(30), country char(30), zakaz INT, FOREIGN KEY (zakaz) REFERENCES orders (id));
```commandline
test_db=# CREATE TABLE clients (id INT PRIMARY KEY, surname char(30), country char(30), zakaz INT, FOREIGN KEY (zakaz) REFERENCES orders (id));
CREATE TABLE
test_db=# \dt
          List of relations
 Schema |  Name   | Type  |  Owner
--------+---------+-------+----------
 public | clients | table | postgres
 public | orders  | table | postgres
(2 rows)

test_db=# CREATE INDEX ON clients(country);
CREATE INDEX
test_db=# \dt
          List of relations
 Schema |  Name   | Type  |  Owner
--------+---------+-------+----------
 public | clients | table | postgres
 public | orders  | table | postgres
(2 rows)
```

- CREATE ROLE "test-admin-user" SUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
- CREATE ROLE "test-simple-user" NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
```commandline
test_db=# \du
                                       List of roles
    Role name     |                         Attributes                         | Member of
------------------+------------------------------------------------------------+-----------
 postgres         | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test-admin-user  | Superuser, No inheritance                                  | {}
 test-simple-user | No inheritance                                             | {}

```
- предоставляем права
```
GRANT SELECT ON TABLE public.clients TO "test-simple-user";
GRANT INSERT ON TABLE public.clients TO "test-simple-user";
GRANT UPDATE ON TABLE public.clients TO "test-simple-user";
GRANT DELETE ON TABLE public.clients TO "test-simple-user";
GRANT SELECT ON TABLE public.orders TO "test-simple-user";
GRANT INSERT ON TABLE public.orders TO "test-simple-user";
GRANT UPDATE ON TABLE public.orders TO "test-simple-user";
GRANT DELETE ON TABLE public.orders TO "test-simple-user";
```
```commandline
test_db=# \z
                                     Access privileges
 Schema |  Name   | Type  |        Access privileges         | Column
privileges | Policies
--------+---------+-------+----------------------------------+-------------------+----------
 public | clients | table | postgres=arwdDxt/postgres       +|
           |
        |         |       | "test-simple-user"=arwd/postgres |
           |
 public | orders  | table | postgres=arwdDxt/postgres       +|
           |
        |         |       | "test-simple-user"=arwd/postgres |
           |
(2 rows)

```

## Задача 3
> 
> Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:
>
> Таблица orders
>
> |Наименование|цена|
> |------------|----|
> |Шоколад| 10 |
> |Принтер| 3000 |
> |Книга| 500 |
> |Монитор| 7000|
> |Гитара| 4000|
> 
> Таблица clients
> 
> |ФИО|Страна проживания|
> |------------|----|
> |Иванов Иван Иванович| USA |
> |Петров Петр Петрович| Canada |
> |Иоганн Себастьян Бах| Japan |
> |Ронни Джеймс Дио| Russia|
> |Ritchie Blackmore| Russia|
> 
> Используя SQL синтаксис:
> - вычислите количество записей для каждой таблицы 
> - приведите в ответе:
>      - запросы 
>     - результаты их выполнения.

### Решение 3

- insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
```commandline
test_db=# select * from orders;
 id |  name   | price
----+---------+-------
  1 | Шоколад |    10
  2 | Принтер |  3000
  3 | Книга   |   500
  4 | Монитор |  7000
  5 | Гитара  |  4000
(5 rows)
```

- insert into clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
```commandline
test_db=# select * from clients;
 id |            surname             |            country
| zakaz
----+--------------------------------+--------------------------------+-------
  1 | Иванов Иван Иванович           | USA
|
  2 | Петров Петр Петрович           | Canada
|
  3 | Иоганн Себастьян Бах           | Japan
|
  4 | Ронни Джеймс Дио               | Russia
|
  5 | Ritchie Blackmore              | Russia
|
(5 rows)
```

- считаем кол-во элементов в каждой таблице
```commandline
test_db=# select count(*) from clients;
 count
-------
     5
(1 row)

test_db=# select count(*) from orders;
 count
-------
     5
(1 row)
```

## Задача 4
> 
> Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.
> 
> Используя foreign keys свяжите записи из таблиц, согласно таблице:
> 
> |ФИО|Заказ|
> |------------|----|
> |Иванов Иван Иванович| Книга |
> |Петров Петр Петрович| Монитор |
> |Иоганн Себастьян Бах| Гитара |
> 
> Приведите SQL-запросы для выполнения данных операций.
> 
> Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
>  
> Подсказк - используйте директиву `UPDATE`.

### Решение 4

- вносим обновления
```commandline
test_db=# update  clients set zakaz = 3 where id = 1;
UPDATE 1
test_db=# update  clients set zakaz = 4 where id = 2;
UPDATE 1
test_db=# update  clients set zakaz = 5 where id = 3;
UPDATE 1
```
- отобразим информацию по двум таблицам
```commandline
test_db=# select c.surname, o.name from clients c, orders o where c.zakaz = o.id;
            surname             |  name
--------------------------------+---------
 Иванов Иван Иванович           | Книга
 Петров Петр Петрович           | Монитор
 Иоганн Себастьян Бах           | Гитара
(3 rows)
```

## Задача 5
>
> Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
> (используя директиву EXPLAIN).
> 
> Приведите получившийся результат и объясните что значат полученные значения.

### Решение 5

```commandline
test_db=# explain select c.surname, o.name from clients c, orders o where c.zakaz = o.id;
                               QUERY PLAN
-------------------------------------------------------------------------
 Hash Join  (cost=37.00..50.53 rows=280 width=156)
   Hash Cond: (c.zakaz = o.id)
   ->  Seq Scan on clients c  (cost=0.00..12.80 rows=280 width=128)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=36)
         ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=36)
(5 rows)
```
- Hash Join - используется для объединения двух наборов записей
- cost - это некоторое число, которое позволяет оценить затратность запроса;
- rows - приблизительное количество возвращаемых строк возвращаемых запросом;
- width - средний объем строки в байтах;
- Hash Cond - условие;
- Seq Scan - проводит последовательное, блок за блоком, чтение данных таблицы;

## Задача 6
>
> Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
>
> Остановите контейнер с PostgreSQL (но не удаляйте volumes).
>
> Поднимите новый пустой контейнер с PostgreSQL.
> 
> Восстановите БД test_db в новом контейнере.
> 
> Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

### Решение 6

- создание бэкапа
```commandline
pg_dumpall -h localhost -U postgres > /home/andrey/practise/netology/6_2/data1/test_db2.sql
```
- останавливаем контейнер и запускаем новый
```commandline
$ docker stop pg
$ docker volume ls
DRIVER    VOLUME NAME
local     6_2_vol1
local     6_2_vol2
local     22dd693ce42b70ee223f1fa5d7f094030b2d80a5a9cfd3d8f3020e9c81fec802
$ docker run --name pg2 -e POSTGRES_PASSWORD=postgres -d -p 5632:5432 -v 6_2_vol1:/home/andrey/practise/netology/6_2/data1 -v 6_2_vol2:/home/andrey/practise/netology/6_2/data2 postgres:12
```
- подключаемся к контейнеру и запускаем восстановление базы
```commandline
$ docker exec -it pg2 bash
cd /home/andrey/practise/netology/6_2/data1
psql -U postgres -f test_db.sql
```
```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)
```
