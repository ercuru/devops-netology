
# Домашнее задание к занятию 3. «Введение. Экосистема. Архитектура. Жизненный цикл Docker-контейнера»


---

## Задача 1

> Сценарий выполнения задачи:
> 
> - создайте свой репозиторий на https://hub.docker.com;
> - выберите любой образ, который содержит веб-сервер Nginx;
> - создайте свой fork образа;
> - реализуйте функциональность:
> запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
> ```
> <html>
> <head>
> Hey, Netology
> </head>
> <body>
> <h1>I’m DevOps Engineer!</h1>
> </body>
> </html>
> ```
> 
> Опубликуйте созданный fork в своём репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

### Решение 1

Образ в репозитории - https://hub.docker.com/r/ercuru/netol_05-03

Ход выполнения:
* Устанавливаем и проверяем версию docker
```
$ docker version
Client: Docker Engine - Community
 Cloud integration: v1.0.31
 Version:           20.10.23
 API version:       1.41
 Go version:        go1.18.10
 Git commit:        7155243
 Built:             Thu Jan 19 17:34:13 2023
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Desktop
 Engine:
  Version:          20.10.23
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.18.10
  Git commit:       6051f14
  Built:            Thu Jan 19 17:32:04 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.18
  GitCommit:        2456e983eb9e37e47538f59ea18f2043c9a73640
 runc:
  Version:          1.1.4
  GitCommit:        v1.1.4-0-g5fd4c4d
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```
* Ищем образ nginx

```$ docker search nginx```
* скачиваем

```$ docker pull ubuntu/nginx ```
```
$ docker images
REPOSITORY     TAG       IMAGE ID       CREATED      SIZE
ubuntu/nginx   latest    3f85c31b6b8c   2 days ago   141MB
```
* запустим для проверки

``` $ docker run -d -p 8181:80 ubuntu/nginx:latest ```  
```
$ lynx localhost:8181
                                                                                                       Welcome to nginx!                                                   Welcome to nginx!

   If you see this page, the nginx web server is successfully installed and working. Further configuration is
   required.

   For online documentation and support please refer to nginx.org.
   Commercial support is available at nginx.com.

   Thank you for using nginx.
```
* создаем dockerfile
```
# base image
FROM ubuntu/nginx
# install basic apps
RUN apt-get clean && apt-get update

#copy index file for nginx
COPY index.nginx-debian.html /var/www/html/
```
* создаем index.nginx-debian.html
``` 
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html> 
```
* собираем наш образ и запустим его для проверки

``` $ docker build -t netol_05-virt-03:v0.1 ```

``` $ docker run -d -p 8191:80 netol_05-03 ```
```
$ lynx localhost:8191

   Hey, Netology

                                                  I’m DevOps Engineer!

```
* сохраним образ в репозитории docker

``` 
$ docker tag netol_05-03:v0.1 ercuru/netol_05-03:v0.1
$ docker pull ercuru/netol_05-03:v0.1 
```



## Задача 2

> Посмотрите на сценарий ниже и ответьте на вопрос:
> «Подходит ли в этом сценарии использование Docker-контейнеров или лучше подойдёт виртуальная машина, физическая машина? Может быть, возможны разные варианты?»
> 
>Детально опишите и обоснуйте свой выбор.

--

### Решение 2

Сценарий:

- высоконагруженное монолитное Java веб-приложение;

Подошла бы виртуальная машина, т.к. монолитное приложение не подразумевает разбиения на части, а высокая нагрузка подразумевает требовательность к ресурсам и высокую скорость доступа к ним

- Nodejs веб-приложение;

Скорее использовал бы контейнер для простоты развертывания

- мобильное приложение c версиями для Android и iOS;

Сценарий docker-контейнеров был бы уместен для тестирования, для работы приложений использовал бы виртуальную машину 

- шина данных на базе Apache Kafka;

Как рабочее решение подходит (судя по большому количеству описаний в поисковике =) )

- Elasticsearch-кластер для реализации логирования продуктивного веб-приложения — три ноды elasticsearch, два logstash и две ноды kibana;

Исходя из описания использование Docker-контейнеров подойдет

- мониторинг-стек на базе Prometheus и Grafana;

Хотел так реализовать в контейнерах мониторинг в рабочей сети - удобство, быстрое развертывание, масштабируемость

- MongoDB как основное хранилище данных для Java-приложения;

Есть готовые образы - соответственно почему нет?

- Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry.

В целях экономии - но по возможности бы выделил виртуальную машину

## Задача 3

> - Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.
> - Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.
> - Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.
> - Добавьте ещё один файл в папку ```/data``` на хостовой машине.
> - Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

### Решение 3

- ищем образы для создания контейнеров и запускаем их с подключением папки

``` $ docker search centos ```

``` $ docker run -v /home/andrey/5-3/data:/data --name centosk -d -t centos:latest ```

``` $ docker search debian ```

``` $ docker run -v /home/andrey/5-3/data:/data --name debiank -d -t debian:latest ```

- подключаемся к первому контейнеру и создаем файл

```
$ docker exec -it centosk /bin/bash
[root@0765a996c70a /]# echo "text for example" > /data/centosk.txt
[root@0765a996c70a /]# cd /data/
[root@0765a996c70a data]# ls
centosk.txt
[root@0765a996c70a data]# cat centosk.txt
text for example
[root@0765a996c70a data]# exit
```

- создаем файл на хосте и подключаемся ко второму контейнеру

```
$ echo "text for example at the host" > ./data/host.txt
$ docker exec -it debiank bash
root@01994ade26d4:/# ls /data
centosk.txt  host.txt
root@01994ade26d4:/# cat /data/centosk.txt && cat /data/host.txt
text for example
text for example at the host
```
