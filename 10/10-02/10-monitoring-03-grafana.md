# Домашнее задание к занятию 14 «Средство визуализации Grafana»

## Обязательные задания

### Задание 1

>1. Используя директорию [help](./help) внутри этого домашнего задания, запустите связку prometheus-grafana.

Скопировал содержимое папки help и запускам контейнеры 
```shell
$ docker-compose up
[+] Running 26/26
 ⠿ grafana Pulled                                                                                                                                      7.9s
   ⠿ 801bfaa63ef2 Pull complete                                                                                                                        1.4s
   ⠿ eb98ae7893eb Pull complete                                                                                                                        1.5s
   ⠿ 06dfedb30805 Pull complete                                                                                                                        1.9s
   ⠿ b5d5ccd6768e Pull complete                                                                                                                        2.3s
   ⠿ 6bb6cb68d42c Pull complete                                                                                                                        5.4s
   ⠿ 4f4fb700ef54 Pull complete                                                                                                                        5.5s
   ⠿ bdc4c340130b Pull complete                                                                                                                        5.6s
   ⠿ f1b64e277fed Pull complete                                                                                                                        5.7s
 ⠿ prometheus Pulled                                                                                                                                   9.6s
   ⠿ ea97eb0eb3ec Pull complete                                                                                                                        3.4s
   ⠿ ec0e9aba71a6 Pull complete                                                                                                                        3.9s
   ⠿ 1baa1560dccd Pull complete                                                                                                                        6.1s
   ⠿ 98aa0434d705 Pull complete                                                                                                                        6.7s
   ⠿ 8dd5b14946f6 Pull complete                                                                                                                        6.8s
   ⠿ b3fc80730ff8 Pull complete                                                                                                                        6.8s
   ⠿ 578d5328855d Pull complete                                                                                                                        6.9s
   ⠿ e63d5ff37b28 Pull complete                                                                                                                        7.0s
   ⠿ aa74b1acc48d Pull complete                                                                                                                        7.0s
   ⠿ d7f9032c18f5 Pull complete                                                                                                                        7.1s
   ⠿ 0dec308978d6 Pull complete                                                                                                                        7.3s
   ⠿ 618f8864f2c8 Pull complete                                                                                                                        7.4s
 ⠿ nodeexporter Pulled                                                                                                                                 3.5s
   ⠿ 86fa074c6765 Pull complete                                                                                                                        0.8s
   ⠿ ed1cd1c6cd7a Pull complete                                                                                                                        1.0s
   ⠿ ff1bb132ce7b Pull complete                                                                                                                        1.3s
[+] Running 5/3
 ⠿ Network help_monitor-net    Created                                                                                                                 0.1s
 ⠿ Volume "help_grafana_data"  Created                                                                                                                 0.0s
 ⠿ Container nodeexporter      Created                                                                                                                 0.2s
 ⠿ Container prometheus        Created                                                                                                                 0.0s
 ⠿ Container grafana           Created                                                                                                                 0.0s
Attaching to grafana, nodeexporter, prometheus
nodeexporter  | level=info ts=2023-07-26T16:39:32.816Z caller=node_exporter.go:177 msg="Starting node_exporter" version="(version=1.0.1, branch=HEAD, revision=3715be6ae899f2a9b9dbfd9c39f3e09a7bd4559f)"
nodeexporter  | level=info ts=2023-07-26T16:39:32.816Z caller=node_exporter.go:178 msg="Build context" build_context="(go=go1.14.4, user=root@1f76dbbcfa55, date=20200616-12:44:12)"
nodeexporter  | level=info ts=2023-07-26T16:39:32.817Z caller=node_exporter.go:105 msg="Enabled collectors"
nodeexporter  | level=info ts=2023-07-26T16:39:32.817Z caller=node_exporter.go:112 collector=arp
...
$ docker-compose ps
NAME                IMAGE                       COMMAND                  SERVICE             CREATED             STATUS              PORTS
grafana             grafana/grafana:7.4.0       "/run.sh"                grafana             4 minutes ago       Up 15 seconds       0.0.0.0:3000->3000/tcp, :::3000->3000/tcp
nodeexporter        prom/node-exporter:v1.0.1   "/bin/node_exporter …"   nodeexporter        4 minutes ago       Up 15 seconds       9100/tcp
prometheus          prom/prometheus:v2.24.1     "/bin/prometheus --c…"   prometheus          4 minutes ago       Up 15 seconds       9090/tcp
```
>2. Зайдите в веб-интерфейс grafana, используя авторизационные данные, указанные в манифесте docker-compose.

Заходим в web-интерфейс
<p align="center">
  <img  src=".//scr/1.jpg">
</p>

>2. Подключите поднятый вами prometheus, как источник данных.
>3. Решение домашнего задания — скриншот веб-интерфейса grafana со списком подключенных Datasource.

Подключаем
<p align="center">
  <img  src=".//scr/2.jpg">
</p>


## Задание 2

>Изучите самостоятельно ресурсы:
>
>1. [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085).
>1. [Understanding Machine CPU usage](https://www.robustperception.io/understanding-machine-cpu-usage).
>1. [Introduction to PromQL, the Prometheus query language](https://grafana.com/blog/2020/02/04/introduction-to-promql-the-prometheus-query-language/).
>
>Создайте Dashboard и в ней создайте Panels:
>
>- утилизация CPU для nodeexporter (в процентах, 100-idle);
>- CPULA 1/5/15;
>- количество свободной оперативной памяти;
>- количество места на файловой системе.
>
>Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

- Утилизация CPU для nodeexporter (в процентах, 100-idle)
```shell
100 * (1 - avg by(instance)(irate(node_cpu_seconds_total{job="nodeexporter",mode="idle"}[5m])))
```
- CPULA 1/5/15
```shell
node_load1{job="nodeexporter"}
node_load5{job="nodeexporter"}
node_load15{job="nodeexporter"}
```
- количество свободной оперативной памяти
```shell
node_memory_MemFree_bytes{job="nodeexporter"} / (1024 * 1024)
```
- Количество места на файловой системе
```shell
node_filesystem_free_bytes{job="nodeexporter",mountpoint="/"} / (1024 * 1024 * 1024)
```
<p align="center">
  <img  src=".//scr/3.jpg">
</p>

## Задание 3

>1. Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг».
>1. В качестве решения задания приведите скриншот вашей итоговой Dashboard.

Создаем alerts

<p align="center">
  <img  src=".//scr/4.jpg"><img  src=".//scr/5.jpg"><img  src=".//scr/6.jpg"><img  src=".//scr/7.jpg">
</p>

## Задание 4

>1. Сохраните ваш Dashboard. Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.
>1. В качестве решения задания приведите листинг этого файла.

Листинг json подготовленной dashboard [grafana_dashboard_nodeexporter.json](https://github.com/ercuru/devops-netology/blob/main/10/10-02/grafana_dashboard_nodeexporter.json)
```json
{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": "-- Grafana --",
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "gnetId": null,
  "graphTooltip": 0,
  "id": 1,
  "links": [],
  "panels": [
    {
      "alert": {
        "alertRuleTags": {},
        "conditions": [
          {
            "evaluator": {
              "params": [
                3248
              ],
              "type": "gt"
            },
            "operator": {
              "type": "and"
            },
            "query": {
              "params": [
                "A",
                "5m",
                "now"
              ]
            },
            "reducer": {
              "params": [],
              "type": "last"
            },
            "type": "query"
          }
        ],
        "executionErrorState": "alerting",
        "for": "5m",
        "frequency": "1m",
        "handler": 1,
        "name": "RAM alert",
        "noDataState": "no_data",
        "notifications": []
      },
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": null,
      "description": "Количество свободной оперативной памяти",
      "fieldConfig": {
        "defaults": {
          "custom": {}
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 0
      },
      "hiddenSeries": false,
      "id": 6,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.4.0",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "node_memory_MemFree_bytes{job=\"nodeexporter\"} / (1024 * 1024)",
          "interval": "",
          "legendFormat": "",
          "refId": "A"
        }
      ],
      "thresholds": [
        {
          "colorMode": "critical",
          "fill": true,
          "line": true,
          "op": "gt",
          "value": 3248,
          "visible": true
        }
      ],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "RAM",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "alert": {
        "alertRuleTags": {},
        "conditions": [
          {
            "evaluator": {
              "params": [
                0.8
              ],
              "type": "gt"
            },
            "operator": {
              "type": "and"
            },
            "query": {
              "params": [
                "load1",
                "5m",
                "now"
              ]
            },
            "reducer": {
              "params": [],
              "type": "avg"
            },
            "type": "query"
          }
        ],
        "executionErrorState": "alerting",
        "for": "5m",
        "frequency": "1m",
        "handler": 1,
        "name": "CPU Load Average alert",
        "noDataState": "no_data",
        "notifications": []
      },
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": null,
      "description": "",
      "fieldConfig": {
        "defaults": {
          "custom": {}
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 0
      },
      "hiddenSeries": false,
      "id": 4,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.4.0",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "node_load1{job=\"nodeexporter\"}",
          "interval": "",
          "legendFormat": "",
          "refId": "load1"
        },
        {
          "expr": "node_load5{job=\"nodeexporter\"}",
          "hide": false,
          "interval": "",
          "legendFormat": "",
          "refId": "load5"
        },
        {
          "expr": "node_load15{job=\"nodeexporter\"}",
          "hide": false,
          "interval": "",
          "legendFormat": "",
          "refId": "load15"
        }
      ],
      "thresholds": [
        {
          "colorMode": "critical",
          "fill": true,
          "line": true,
          "op": "gt",
          "value": 0.8,
          "visible": true
        }
      ],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "CPU Load Average",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "$$hashKey": "object:706",
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": "1",
          "min": null,
          "show": true
        },
        {
          "$$hashKey": "object:707",
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "alert": {
        "alertRuleTags": {},
        "conditions": [
          {
            "evaluator": {
              "params": [
                2
              ],
              "type": "gt"
            },
            "operator": {
              "type": "and"
            },
            "query": {
              "params": [
                "A",
                "5m",
                "now"
              ]
            },
            "reducer": {
              "params": [],
              "type": "avg"
            },
            "type": "query"
          }
        ],
        "executionErrorState": "alerting",
        "for": "5m",
        "frequency": "1m",
        "handler": 1,
        "name": "CPU Usage alert",
        "noDataState": "no_data",
        "notifications": []
      },
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": null,
      "description": "Утилизация CPU для nodeexporter (в процентах, 100-idle)",
      "fieldConfig": {
        "defaults": {
          "color": {},
          "custom": {},
          "thresholds": {
            "mode": "absolute",
            "steps": []
          }
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 9,
        "w": 12,
        "x": 0,
        "y": 8
      },
      "hiddenSeries": false,
      "id": 2,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.4.0",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "100 * (1 - avg by(instance)(irate(node_cpu_seconds_total{job=\"nodeexporter\",mode=\"idle\"}[5m])))",
          "interval": "",
          "legendFormat": "",
          "refId": "A"
        }
      ],
      "thresholds": [
        {
          "colorMode": "critical",
          "fill": true,
          "line": true,
          "op": "gt",
          "value": 2,
          "visible": true
        }
      ],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "CPU Usage",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "$$hashKey": "object:647",
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "$$hashKey": "object:648",
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "alert": {
        "alertRuleTags": {},
        "conditions": [
          {
            "evaluator": {
              "params": [
                20
              ],
              "type": "lt"
            },
            "operator": {
              "type": "and"
            },
            "query": {
              "params": [
                "A",
                "5m",
                "now"
              ]
            },
            "reducer": {
              "params": [],
              "type": "last"
            },
            "type": "query"
          }
        ],
        "executionErrorState": "alerting",
        "for": "5m",
        "frequency": "1m",
        "handler": 1,
        "name": "Free Space alert",
        "noDataState": "no_data",
        "notifications": []
      },
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": null,
      "description": "Количество места на файловой системе",
      "fieldConfig": {
        "defaults": {
          "custom": {}
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 8
      },
      "hiddenSeries": false,
      "id": 8,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.4.0",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "node_filesystem_free_bytes{job=\"nodeexporter\",mountpoint=\"/\"} / (1024 * 1024 * 1024)",
          "interval": "",
          "legendFormat": "",
          "refId": "A"
        }
      ],
      "thresholds": [
        {
          "colorMode": "critical",
          "fill": true,
          "line": true,
          "op": "lt",
          "value": 20,
          "visible": true
        }
      ],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Free Space",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "$$hashKey": "object:579",
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": "15",
          "show": true
        },
        {
          "$$hashKey": "object:580",
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    }
  ],
  "refresh": false,
  "schemaVersion": 27,
  "style": "dark",
  "tags": [],
  "templating": {
    "list": []
  },
  "time": {
    "from": "2023-07-26T16:38:57.493Z",
    "to": "2023-07-26T17:24:47.181Z"
  },
  "timepicker": {},
  "timezone": "",
  "title": "Nodeexporter Metrics",
  "uid": "yDN1Fc3Vk",
  "version": 1
}
```