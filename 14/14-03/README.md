# Домашнее задание к занятию «Как работает сеть в K8s»

### Цель задания

Настроить сетевую политику доступа к подам.

-----

<details><summary> Инструменты и дополнительные материалы, которые пригодятся для выполнения задания</summary>

1. [Документация Calico](https://www.tigera.io/project-calico/).
2. [Network Policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
3. [About Network Policy](https://docs.projectcalico.org/about/about-network-policy).
</details>

<details><summary> Чеклист готовности к домашнему заданию</summary>

Кластер K8s с установленным сетевым плагином Calico.
</details>

<details><summary> Правила приёма работы </summary>

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.
</details>

-----

### Задание. Создать сетевую политику или несколько политик для обеспечения доступа

>1. Создать deployment'ы приложений frontend, backend и cache и соответсвующие сервисы.
>2. В качестве образа использовать network-multitool.

- [frontend](frontend.yaml) манифест
- [backend](backend.yaml) манифест
- [cache](cache.yaml) манифест


>3. Разместить поды в namespace App.

- pods
<p align="center">
  <img  src=".//scr/1.jpg">
</p>

- services
<p align="center">
  <img  src=".//scr/2.jpg">
</p>

>4. Создать политики, чтобы обеспечить доступ frontend -> backend -> cache. Другие виды подключений должны быть запрещены.

- [net_policy](net_policy.yaml) манифест

<p align="center">
  <img  src=".//scr/3.jpg">
</p>

>5. Продемонстрировать, что трафик разрешён и запрещён.

- from frontend
<p align="center">
  <img  src=".//scr/4.jpg">
</p>

- from backend
<p align="center">
  <img  src=".//scr/5.jpg">
</p>

- from cache
<p align="center">
  <img  src=".//scr/6.jpg">
</p>