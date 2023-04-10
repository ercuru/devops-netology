# Домашнее задание к занятию 5. «Elasticsearch»

## Задача 1
> 
> В этом задании вы потренируетесь в:
> 
> - установке Elasticsearch,
> - первоначальном конфигурировании Elasticsearch,
> - запуске Elasticsearch в Docker.
> 
> Используя Docker-образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
> [документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):
> 
> - составьте Dockerfile-манифест для Elasticsearch,
> - соберите Docker-образ и сделайте `push` в ваш docker.io-репозиторий,
> - запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины.
> 
> Требования к `elasticsearch.yml`:
> 
> - данные `path` должны сохраняться в `/var/lib`,
> - имя ноды должно быть `netology_test`.
> 
> В ответе приведите:
> 
> - текст Dockerfile-манифеста,
> - ссылку на образ в репозитории dockerhub,
> - ответ `Elasticsearch` на запрос пути `/` в json-виде.
> 
> Подсказки:
> 
> - возможно, вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum,
> - при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml,
> - при некоторых проблемах вам поможет Docker-директива ulimit,
> - Elasticsearch в логах обычно описывает проблему и пути её решения.
> 
> Далее мы будем работать с этим экземпляром Elasticsearch.
> 

### Решение 1
- Загружаем centos 7 и elasticsearch для сборки образа
```commandline
- docker pull centos:7
> $ ls
> config  dockerfile  elasticsearch-8.7.0  elasticsearch-8.7.0-linux-x86_64.tar.gz  elasticsearch-8.7.0-linux-x86_64.tar.gz.sha512
```
- готовим dockerfile
```commandline
FROM centos:7

EXPOSE 9200 9300

USER 0

COPY elasticsearch-8.7.0 /var/lib/elasticsearch

RUN export ES_HOME="/var/lib/elasticsearch" && \
    useradd -m -u 1000 elasticsearch && \
    chown elasticsearch:elasticsearch -R ${ES_HOME}

COPY --chown=elasticsearch:elasticsearch config/* /var/lib/elasticsearch/config/
    
RUN mkdir /var/lib/elasticsearch/snapshots && \
    chown elasticsearch:elasticsearch /var/lib/elasticsearch/snapshots

RUN mkdir /var/lib/logs && \
    chown elasticsearch:elasticsearch /var/lib/logs && \
    mkdir /var/lib/data && \
    chown elasticsearch:elasticsearch /var/lib/data

USER 1000

ENV ES_HOME="/var/lib/elasticsearch" \
    ES_PATH_CONF="/var/lib/elasticsearch/config"

WORKDIR /var/lib/elasticsearch

CMD ["sh", "-c", "${ES_HOME}/bin/elasticsearch"]
```
- Готовим elasticsearch.yml в папке config (она в образ копируется, как elasticsearch)
```commandline
# Use a descriptive name for your cluster:
#
cluster.name: netology_test
discovery.type: single-node
# Path to directory where to store the data (separate multiple locations by comma):
#
path.data: /var/lib/data
#
# Path to log files:
#
path.logs: /var/lib/logs
#Settings REPOSITORY PATH
#
path.repo: /var/lib/elasticsearch/snapshots
# Set the bind address to a specific IP (IPv4 or IPv6):
#
network.host: 0.0.0.0
# Pass an initial list of hosts to perform discovery when this node is started:
# The default list of hosts is ["127.0.0.1", "[::1]"]
#
discovery.seed_hosts: ["127.0.0.1", "[::1]"]

xpack.security.enabled: false
xpack.security.transport.ssl.enabled: false
xpack.security.http.ssl.enabled: false
```
- собираем образ
```commandline
docker build -t ercuru/elasticsearchcustom:v01 .
```
- запустим его и проверим получение ответа
```commandline
docker run --rm -d --name elastic -p 9200:9200 -p 9300:9300 ercuru/elasticsearchcustom:v01
andrey@stp-vatest01:~/practise/netology/6_5$ curl -X GET 'localhost:9200/'
{
  "name" : "cd93c0cfa8fb",
  "cluster_name" : "netology_test",
  "cluster_uuid" : "-H-RZUi5RcGKd4x54aW28A",
  "version" : {
    "number" : "8.7.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "09520b59b6bc1057340b55750186466ea715e30e",
    "build_date" : "2023-03-27T16:31:09.816451435Z",
    "build_snapshot" : false,
    "lucene_version" : "9.5.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```
- загружаем собранный образ на docker
> https://hub.docker.com/r/ercuru/elasticsearchcustom/tags
```commandline
$ docker login -u "ercuru" -p "*******" docker.io
$ docker push ercuru/elasticsearchcustom:v01
```


## Задача 2
> 
> В этом задании вы научитесь:
> 
> - создавать и удалять индексы,
> - изучать состояние кластера,
> - обосновывать причину деградации доступности данных.
> 
> Ознакомьтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
> и добавьте в `Elasticsearch` 3 индекса в соответствии с таблицей:
> 
> | Имя | Количество реплик | Количество шард |
> |-----|-------------------|-----------------|
> | ind-1| 0 | 1 |
> | ind-2 | 1 | 2 |
> | ind-3 | 2 | 4 |
> 
> Получите список индексов и их статусов, используя API, и **приведите в ответе** на задание.
> 
> Получите состояние кластера `Elasticsearch`, используя API.
> 
> Как вы думаете, почему часть индексов и кластер находятся в состоянии yellow?
> 
> Удалите все индексы.
> 
> **Важно**
> 
> При проектировании кластера Elasticsearch нужно корректно рассчитывать количество реплик и шард,
> иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

### Решение 2

- cоздание индексов
```
$ curl -X PUT localhost:9200/ind-1 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
$ curl -X PUT localhost:9200/ind-2 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 2,  "number_of_replicas": 1 }}'
$ curl -X PUT localhost:9200/ind-3 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 4,  "number_of_replicas": 2 }}'
```
- cписок индексов
```
$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 rnNAXvPCRN627XQEiZxzFw   1   0          0            0       225b           225b
yellow open   ind-3 ssDRp3_tRn6tOrdB9CWA-A   4   2          0            0       900b           900b
yellow open   ind-2 MxV9M8PoSBuJbAqmMpMEIw   2   1          0            0       450b           450b
```
- статус индексов
```
$ curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}

$ curl -X GET 'http://localhost:9200/_cluster/health/ind-2?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 50.0
}

$ curl -X GET 'http://localhost:9200/_cluster/health/ind-3?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 33.33333333333333
}
```
- cтатус кластера

```
$ curl -XGET localhost:9200/_cluster/health/?pretty=true
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 7,
  "active_shards" : 7,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}
```

- удаление индексов

```
$ curl -X DELETE 'http://localhost:9200/ind-1?pretty'
{
  "acknowledged" : true
}

$ curl -X DELETE 'http://localhost:9200/ind-2?pretty'
{
  "acknowledged" : true
}

$ curl -X DELETE 'http://localhost:9200/ind-3?pretty'
{
  "acknowledged" : true
}

$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size
```
Индексы в статусе yellow по той причине, что у них указано число реплик, а у нас нет никаких других серверов для репликации

## Задача 3
> 
> В этом задании вы научитесь:
> 
> - создавать бэкапы данных,
> - восстанавливать индексы из бэкапов.
> 
> Создайте директорию `{путь до корневой директории с Elasticsearch в образе}/snapshots`.
> 
> Используя API, [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
> эту директорию как `snapshot repository` c именем `netology_backup`.
> 
> **Приведите в ответе** запрос API и результат вызова API для создания репозитория.
> 
> Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.
> 
> [Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
> состояния кластера `Elasticsearch`.
> 
> **Приведите в ответе** список файлов в директории со `snapshot`.
> 
> Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.
> 
> [Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
> кластера `Elasticsearch` из `snapshot`, созданного ранее. 
> 
> **Приведите в ответе** запрос к API восстановления и итоговый список индексов.
> 
> Подсказки:
> 
> - возможно, вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `Elasticsearch`.
> 

### Решение 3
- регистрируем папку для бэкапов

```
$ curl -XPOST localhost:9200/_snapshot/netology_backup?pretty -H 'Content-Type: application/json' -d'{"type": "fs", "settings": { "location":"/var/lib/elasticsearch/snapshots" }}'
{
  "acknowledged" : true
}

$ curl -X GET http://localhost:9200/_snapshot/netology_backup?pretty
{
  "netology_backup" : {
    "type" : "fs",
    "settings" : {
      "location" : "/var/lib/elasticsearch/snapshots"
    }
  }
}
```
- создаем test
```
$ curl -X PUT localhost:9200/test -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1, "number_of_replicas": 0 }}'

$ curl -X GET http://localhost:9200/test?pretty
{
  "test" : {
    "aliases" : { },
    "mappings" : { },
    "settings" : {
      "index" : {
        "routing" : {
          "allocation" : {
            "include" : {
              "_tier_preference" : "data_content"
            }
          }
        },
        "number_of_shards" : "1",
        "provided_name" : "test",
        "creation_date" : "1681116179238",
        "number_of_replicas" : "0",
        "uuid" : "ldx70SWyTBewVLCNkKFIAA",
        "version" : {
          "created" : "8070099"
        }
      }
    }
  }
}

$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test  ldx70SWyTBewVLCNkKFIAA   1   0          0            0       225b           225b

```
- делаем snapshot и выводим список файлов
```
$ curl -X PUT localhost:9200/_snapshot/netology_backup/elasticsearch?wait_for_completion=true
{"snapshot":{"snapshot":"elasticsearch","uuid":"1fVqMApxSMq6t2inBC5LZA","repository":"netology_backup","version_id":8070099,"version":"8.7.0","indices":["test"],"data_streams":[],"include_global_state":true,"state":"SUCCESS","start_time":"2023-04-10T08:48:54.526Z","start_time_in_millis":1681116534526,"end_time":"2023-04-10T08:48:54.726Z","end_time_in_millis":1681116534726,"duration_in_millis":200,"failures":[],"shards":{"total":1,"failed":0,"successful":1},"feature_states":[]}}

$ docker exec elastic ls -la /var/lib/elasticsearch/snapshots/
total 48
drwxr-xr-x 1 elasticsearch elasticsearch  4096 Apr 10 08:48 .
drwxr-xr-x 1 elasticsearch elasticsearch  4096 Apr  9 17:51 ..
-rw-r--r-- 1 elasticsearch elasticsearch   589 Apr 10 08:48 index-0
-rw-r--r-- 1 elasticsearch elasticsearch     8 Apr 10 08:48 index.latest
drwxr-xr-x 3 elasticsearch elasticsearch  4096 Apr 10 08:48 indices
-rw-r--r-- 1 elasticsearch elasticsearch 18756 Apr 10 08:48 meta-1fVqMApxSMq6t2inBC5LZA.dat
-rw-r--r-- 1 elasticsearch elasticsearch   310 Apr 10 08:48 snap-1fVqMApxSMq6t2inBC5LZA.dat
```
- удалим test и создаем test-2
```
$ curl -X DELETE 'http://localhost:9200/test?pretty'
{
  "acknowledged" : true
}
$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size
$ curl -X PUT localhost:9200/test-2?pretty -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test-2"
}
$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 0QW93XSIR9qv_DOU8jNxJw   1   0          0            0       225b           225b

```

- восстанавливаем
```
$ curl -X POST localhost:9200/_snapshot/netology_backup/elasticsearch/_restore?pretty
{
  "accepted" : true
}
$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 0QW93XSIR9qv_DOU8jNxJw   1   0          0            0       225b           225b
green  open   test   M2syB3yXRlOHuzn-s4Vx9g   1   0          0            0       225b           225b
```