# Домашнее задание к занятию 15 «Система сбора логов Elastic Stack»

## Задание 1

>Вам необходимо поднять в докере и связать между собой:
>
>- elasticsearch (hot и warm ноды);
>- logstash;
>- kibana;
>- filebeat.
>
>Logstash следует сконфигурировать для приёма по tcp json-сообщений.
>
>Filebeat следует сконфигурировать для отправки логов docker вашей системы в logstash.
>
>В директории [help](./help) находится манифест docker-compose и конфигурации filebeat/logstash для быстрого выполнения этого задания.
>
>Результатом выполнения задания должны быть:
>
>- скриншот `docker ps` через 5 минут после старта всех контейнеров (их должно быть 5);
>- скриншот интерфейса kibana;

### Ответ 1

Загрузили конфигурацию help и запустили контейнеры

<p align="center">
  <img  src=".//scr/1.jpg">
</p>

## Задание 2

>Перейдите в меню [создания index-patterns  в kibana](http://localhost:5601/app/management/kibana/indexPatterns/create) и создайте несколько index-patterns из имеющихся.
>
>Перейдите в меню просмотра логов в kibana (Discover) и самостоятельно изучите, как отображаются логи и как производить поиск по логам.
>
>В манифесте директории help также приведенно dummy-приложение, которое генерирует рандомные события в stdout-контейнера.
>Эти логи должны порождать индекс logstash-* в elasticsearch. Если этого индекса нет — воспользуйтесь советами и источниками из раздела «Дополнительные ссылки» этого задания.

### Ответ 2
<p align="center">
  <img  src=".//scr/2.jpg"><img  src=".//scr/3.jpg"><img  src=".//scr/4.jpg"><img  src=".//scr/5.jpg">
</p>


<details>
  <summary>Дополнительные ссылки</summary>
  
  - [поднимаем elk в docker](https://www.elastic.co/guide/en/elastic-stack-get-started/current/get-started-docker.html);
- [поднимаем elk в docker с filebeat и docker-логами](https://www.sarulabs.com/post/5/2019-08-12/sending-docker-logs-to-elasticsearch-and-kibana-with-filebeat.html);
- [конфигурируем logstash](https://www.elastic.co/guide/en/logstash/current/configuration.html);
- [плагины filter для logstash](https://www.elastic.co/guide/en/logstash/current/filter-plugins.html);
- [конфигурируем filebeat](https://www.elastic.co/guide/en/beats/libbeat/5.3/config-file-format.html);
- [привязываем индексы из elastic в kibana](https://www.elastic.co/guide/en/kibana/current/index-patterns.html);
- [как просматривать логи в kibana](https://www.elastic.co/guide/en/kibana/current/discover.html);
- [решение ошибки increase vm.max_map_count elasticsearch](https://stackoverflow.com/questions/42889241/how-to-increase-vm-max-map-count).

</details>


