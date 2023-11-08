# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 1»

## Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod внутри кластера

>1. Создать Deployment приложения, состоящего из двух контейнеров (nginx и multitool), с количеством реплик 3 шт.
>2. Создать Service, который обеспечит доступ внутри кластера до контейнеров приложения из п.1 по порту 9001 — nginx 80, по 9002 — multitool 8080.

Создаем [Манифест Deplyment](12_04_deployment.yaml) вместе с Service

>3. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложения из п.1 по разным портам в разные контейнеры.

Создаем [Манифест для Pod](12_04_Pod.yaml)

Применяем манифесты и проверяем доступ из отдельного Pod:

<p align="center">
  <img  src=".//scr/12-04-deploy1.jpg">
</p>


<details><summary>вывод curl</summary>

```shell
andrey@stp-vatest01:~$ kubectl exec multitool-pod -- curl 10.1.126.80:80
kubectl exec multitool-pod -- curl 10.1.126.80:8080
kubectl exec multitool-pod -- curl 10.1.126.81:80
kubectl exec multitool-pod -- curl 10.1.126.81:8080
kubectl exec multitool-pod -- curl 10.1.126.82:80
kubectl exec multitool-pod -- curl 10.1.126.82:8080
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
100   615  100   615    0     0   749k      0 --:--:-- --:--:-- --:--:--  600k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0WBITT Network MultiTool (with NGINX) - nginx-deployment-65fd476649-rd8xp - 10.1.126.80 - HTTP: 8080 , HTTPS: 8443 . (Formerly praqma/network-multitool)
100   152  100   152    0     0  24092      0 --:--:-- --:--:-- --:--:-- 25333
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   615  100   615  <!DOCTYPE html>0      0 --:--:-- --:--:-- --:--:--     0
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
  0     0   475k      0 --:--:-- --:--:-- --:--:--  600k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   152  100   152    0     0   109k      0 --:--:-- --:--:-- --:--:--  148k
WBITT Network MultiTool (with NGINX) - nginx-deployment-65fd476649-9lx4v - 10.1.126.81 - HTTP: 8080 , HTTPS: 8443 . (Formerly praqma/network-multitool)
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   615  100   615    0     0  1074k      0 --:--:-- --:--:-- --:--:--  600k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0WBITT Network MultiTool (with NGINX) - nginx-deployment-65fd476649-smcl4 - 10.1.126.82 - HTTP: 8080 , HTTPS: 8443 . (Formerly praqma/network-multitool)
100   152  100   152    0     0  62525      0 --:--:-- --:--:-- --:--:-- 76000
```

</details>

>4. Продемонстрировать доступ с помощью `curl` по доменному имени сервиса.
>5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

- [Манифест Deplyment](12_04_deployment.yaml)
- [Манифест для Pod](12_04_Pod.yaml)

<p align="center">
  <img  src=".//scr/12-04-Curl_svc.jpg">
</p>


------

## Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера

>1. Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx, используя тип NodePort.
>2. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
>3. Предоставить манифест и Service в решении, а также скриншоты или вывод команды п.2.

[Манифест для NodePort service](12_04_svcNodePort.yaml)

Запускаем и проверяем доступ с локальной машины в сети:
<p align="center">
  <img  src=".//scr/12_04_svcNodePort_apply.jpg"><img  src=".//scr/12_4_2-nginx.jpg"><img  src=".//scr/12_4_2-multitool.jpg">
</p>
