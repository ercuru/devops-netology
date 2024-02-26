# Домашнее задание к занятию «Организация сети»

---
<details><summary> Подготовка к выполнению задания </summary>

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашнее задание по теме «Облачные провайдеры и синтаксис Terraform». Заранее выберите регион (в случае AWS) и зону.
</details>



<details><summary> Правила приёма работы </summary>

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.
</details>


<details><summary> Resource Terraform для Yandex Cloud </summary>

- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet).
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table).
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance).
</details>




---
### Задание. Yandex Cloud 

>1. Создать пустую VPC. Выбрать зону.
>2. Публичная подсеть.
>
> - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
> - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
> - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.
>3. Приватная подсеть.
> - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
> - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
> - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

Создали [terraform манифесты](terraform).

Image для NAT заменен на актуальный с [Yandex Cloud Market](https://cloud.yandex.ru/ru/marketplace?tab=software&categories=network)

- Создали инфраструктуру согласно задания
<p align="center">
  <img  src=".//scr/1.jpg">
</p>
<p align="center">
  <img  src=".//scr/2.jpg">
</p>

- Проверяем вход на инстанс в public подсети и проверяем доступность интернета
<p align="center">
  <img  src=".//scr/3.jpg">
</p>

- Проверяем вход на инстанс в private подсети c инстанса в public подсети и проверяем доступность интернета
 <p align="center">
  <img  src=".//scr/4.jpg">
</p>

- Созданная сеть VPC
 <p align="center">
  <img  src=".//scr/network.jpg">
</p>

- Созданная таблица маршрутизации
 <p align="center">
  <img  src=".//scr/rt.jpg">
</p>

- Созданные подсети
 <p align="center">
  <img  src=".//scr/subnets.jpg">
</p>



