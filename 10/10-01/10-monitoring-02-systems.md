# Домашнее задание к занятию 13 «Введение в мониторинг»

## Задания

>1. Вас пригласили настроить мониторинг на проект. На онбординге вам рассказали, что проект представляет из себя платформу для вычислений с выдачей текстовых отчётов, которые сохраняются на диск. 
>Взаимодействие с платформой осуществляется по протоколу http. Также вам отметили, что вычисления загружают ЦПУ. Какой минимальный набор метрик вы выведите в мониторинг и почему?

### Ответ 1:
- Место на диске - чтобы понимать сколько осталось, по графику можно пытаться прогнозировать
- iowait - насколько быстро получаем информацию от дисков
- IOPS - для понимания как работают диски
- LA - оценка нагрузки ЦПУ
- Мониторинг http запросов - сколько запросов, с какими кодами отвечает, как по скорости
- NetTraffic - хотя бы смотреть, на забит ли наш канал
---
>2. Менеджер продукта, посмотрев на ваши метрики, сказал, что ему непонятно, что такое RAM/inodes/CPUla. Также он сказал, что хочет понимать, насколько мы выполняем свои обязанности перед клиентами и какое качество обслуживания. Что вы можете ему предложить?

### Ответ 2:

- Предложу использовать подход SLA|SLO|SLI - для оценки поддержки клиента
---
>3. Вашей DevOps-команде в этом году не выделили финансирование на построение системы сбора логов. Разработчики, в свою очередь, хотят видеть все ошибки, которые выдают их приложения. Какое решение вы можете предпринять в этой ситуации, чтобы разработчики получали ошибки приложения?

### Ответ 3:

В данной ситуации возможно воспользоваться бесплатными/условно-бесплатными решениями: Sentry, ELK, Graylog и т.п. 
___
>3. Вы, как опытный SRE, сделали мониторинг, куда вывели отображения выполнения SLA = 99% по http-кодам ответов. 
Этот параметр вычисляется по формуле: summ_2xx_requests/summ_all_requests. Он не поднимается выше 70%, но при этом в вашей системе нет кодов ответа 5xx и 4xx. Где у вас ошибка?

### Ответ 4:

Не учли ответы 1xx,2xx и 3хх .
Формула должны выглядеть так: (summ_1xx_requests + summ_2xx_requests + summ_3xx_requests)/summ_all_requests

---
>5. Опишите основные плюсы и минусы pull и push систем мониторинга.

### Ответ 5:

#### Push

Плюсы:
  - упрощение репликации данных в разные системы мониторинга или их резервные копии
  - более гибкая настройка отправки пакетов данных с метриками
  - UDP — это менее затратный способ передачи данных, из-за чего может возрасти производительность сбора метрик

Минусы:
  - риск потери данных мониторинга, т.к. протокол UDP не гарантирует доставку данных
  - нет шифрования соединения
  - сложность контроля отправки - сервер не контролирует параметры отправки

#### Pull

Плюсы:
- легче контролировать подлинность данных
- можно настроить единый proxy server до всех агентов с TLS
- упрощённая отладка получения данных с агентов

Минусы:
- более ресурсоёмкий, т.к. данные забираются по HTTP/S в основном
- 

---
> 6. Какие из ниже перечисленных систем относятся к push модели, а какие к pull? А может есть гибридные?

### Ответ 6:

- Prometheus - pull (push с pushgateway) 
- TICK - push
- Zabbix - push (pull с Zabbix Proxy)
- VictoriaMetrics - push/pull, в зависимости от источника
- Nagios - push и pull

---
>7. Склонируйте себе [репозиторий](https://github.com/influxdata/sandbox/tree/master) и запустите TICK-стэк, используя технологии docker и docker-compose.
>
>В виде решения на это упражнение приведите скриншот веб-интерфейса ПО chronograf (`http://localhost:8888`). 
>
>P.S.: если при запуске некоторые контейнеры будут падать с ошибкой - проставьте им режим `Z`, например `./data:/var/lib:Z`

### Ответ 7:
- клонируем
```shell
$ git clone https://github.com/influxdata/sandbox.git
Cloning into 'sandbox'...
remote: Enumerating objects: 1718, done.
remote: Counting objects: 100% (32/32), done.
remote: Compressing objects: 100% (22/22), done.
remote: Total 1718 (delta 13), reused 25 (delta 10), pack-reused 1686
Receiving objects: 100% (1718/1718), 7.17 MiB | 15.32 MiB/s, done.
Resolving deltas: 100% (946/946), done.
```
- запускаем и проверяем, что с контейнерами
```shell
$ ./sandbox up
Using latest, stable releases
Spinning up Docker Images...
If this is your first time starting sandbox this might take a minute...
[+] Building 18.2s (33/33) FINISHED
 => [influxdb internal] load build definition from Dockerfile                                                      0.1s
 => => transferring dockerfile: 83B
... 
$ docker-compose ps
NAME                      IMAGE                   COMMAND                  SERVICE             CREATED             STATUS              PORTS
sandbox-chronograf-1      chrono_config           "/entrypoint.sh chro…"   chronograf          2 minutes ago       Up 2 minutes        0.0.0.0:8888->8888/tcp, :::8888->8888/tcp
sandbox-documentation-1   sandbox-documentation   "/documentation/docu…"   documentation       2 minutes ago       Up 2 minutes        0.0.0.0:3010->3000/tcp, :::3010->3000/tcp
sandbox-influxdb-1        influxdb                "/entrypoint.sh infl…"   influxdb            2 minutes ago       Up 2 minutes        0.0.0.0:8082->8082/tcp, :::8082->8082/tcp, 0.0.0.0:8086->8086/tcp, :::8086->8086/tcp, 0.0.0.0:8089->8089/udp, :::8089->8089/udp
sandbox-kapacitor-1       kapacitor               "/entrypoint.sh kapa…"   kapacitor           2 minutes ago       Up 2 minutes        0.0.0.0:9092->9092/tcp, :::9092->9092/tcp
sandbox-telegraf-1        telegraf                "/entrypoint.sh tele…"   telegraf            2 minutes ago       Up 2 minutes        8092/udp, 8125/udp, 8094/tcp
```
- смотрим в браузере
<p align="center">
  <img  src=".//scr/1.jpg">
</p>

---
>8. Перейдите в веб-интерфейс Chronograf (http://localhost:8888) и откройте вкладку Data explorer.
>        
>    - Нажмите на кнопку Add a query
>    - Изучите вывод интерфейса и выберите БД telegraf.autogen
>    - В `measurments` выберите cpu->host->telegraf-getting-started, а в `fields` выберите usage_system. Внизу появится график утилизации cpu.
>    - Вверху вы можете увидеть запрос, аналогичный SQL-синтаксису. Поэкспериментируйте с запросом, попробуйте изменить группировку и интервал наблюдений.
>
>Для выполнения задания приведите скриншот с отображением метрик утилизации cpu из веб-интерфейса.

### Ответ 8:

выполнил действия и поменял интервал отображения на последние 15 мин и вывод значений с интервалом 5 мин
<p align="center">
  <img  src=".//scr/2.jpg">
</p>

---
>9. Изучите список [telegraf inputs](https://github.com/influxdata/telegraf/tree/master/plugins/inputs). 
>Добавьте в конфигурацию telegraf следующий плагин - [docker](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker):
>```
>[[inputs.docker]]
>  endpoint = "unix:///var/run/docker.sock"
>```
>
>Дополнительно вам может потребоваться донастройка контейнера telegraf в `docker-compose.yml` дополнительного volume и 
>режима privileged:
>```
>  telegraf:
>    image: telegraf:1.4.0
>    privileged: true
>    volumes:
>      - ./etc/telegraf.conf:/etc/telegraf/telegraf.conf:Z
>      - /var/run/docker.sock:/var/run/docker.sock:Z
>    links:
>      - influxdb
>    ports:
>      - "8092:8092/udp"
>      - "8094:8094"
>      - "8125:8125/udp"
>```
>
>После настройке перезапустите telegraf, обновите веб интерфейс и приведите скриншотом список `measurments` в веб-интерфейсе базы telegraf.autogen . Там должны появиться метрики, связанные с docker.

### Ответ 9:

Проверяем конфигурацию и обнаруживаем что все уже сделано за нас - смотрим web-интерфейс - и правда

<p align="center">
  <img  src=".//scr/3.jpg">
</p>

---