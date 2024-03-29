# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2»

## Задание 1. Создать Deployment приложений backend и frontend

>1. Создать Deployment приложения _frontend_ из образа nginx с количеством реплик 3 шт.
>2. Создать Deployment приложения _backend_ из образа multitool. 
>3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера. 
>4. Продемонстрировать, что приложения видят друг друга с помощью Service.
>5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

Создал манифесты:
- [Манифест frontend](frontend.yaml)
- [Манифест backend](backend.yaml)
- [Манифест service](12_05_Svc.yaml)

Запускаем и проверяем работу:

<p align="center">
  <img  src=".//scr/12-5-deploy.jpg"><img  src=".//scr/12-5-front2back.jpg"><img  src=".//scr/12-5-back2front.jpg">
</p>


------

## Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

>1. Включить Ingress-controller в MicroK8S.
>2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_.
>3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
>4. Предоставить манифесты и скриншоты или вывод команды п.2.

- Включаем ingress-контроллер:

<p align="center">
  <img  src=".//scr/12-5-2_ingressEnable.jpg">
</p>

- Сделали [Манифест Ingress](ingress.yaml)
- Применяем - проверяем - пробуем подключиться

<p align="center">
  <img  src=".//scr/12-5-ingress_apply.jpg"><img  src=".//scr/12-5-ingress_connection.jpg">
</p>