# Домашнее задание к занятию «Базовые объекты K8S»

## Задание 1. Создать Pod с именем hello-world

>1. Создать манифест (yaml-конфигурацию) Pod.
 
[Манифест Pod](pod.yaml)

>2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
```shell
$ kubectl apply -f pod.yaml
pod/hello-world created
```

<p align="center">
  <img  src=".//scr/12_2_Get_Pod.jpg">
</p>

>3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере).
```shell
$ kubectl port-forward pod/hello-world 8080:8080  --address='0.0.0.0'
Forwarding from 0.0.0.0:8080 -> 8080
```
<p align="center">
  <img  src=".//scr/12_2_Curl-pod.jpg">
</p>

------

## Задание 2. Создать Service и подключить его к Pod

>1. Создать Pod с именем netology-web.
>2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
>3. Создать Service с именем netology-svc и подключить к netology-web.

[Манифест Service-Pod](netology-web.yaml)

```shell
$ kubectl apply -f netology-web.yaml
pod/netology-web created
service/netology-svc created
```

<p align="center">
  <img  src=".//scr/12_2_Get_service_pod.jpg">
</p>

>4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

```shell
$ kubectl port-forward service/netology-svc 8081:8081  --address='0.0.0.0'
Forwarding from 0.0.0.0:8081 -> 8080
```
<p align="center">
  <img  src=".//scr/12_2_Curl-service.jpg">
</p>