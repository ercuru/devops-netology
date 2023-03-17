# Домашнее задание к занятию 4. «Оркестрация группой Docker-контейнеров на примере Docker Compose»

---

## Задача 1

> Создайте собственный образ любой операционной системы (например ubuntu-20.04) с помощью Packer ([инструкция](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-quickstart)).
>
> Чтобы получить зачёт, вам нужно предоставить скриншот страницы с созданным образом из личного кабинета YandexCloud.

### Решение 1

![ready image](/screens/1.jpg)

## Задача 2
>
> **2.1.** Создайте вашу первую виртуальную машину в YandexCloud с помощью web-интерфейса YandexCloud.        
> 
> **2.2.*** **(Необязательное задание)**      
> Создайте вашу первую виртуальную машину в YandexCloud с помощью Terraform (вместо использования веб-интерфейса YandexCloud).
> Используйте Terraform-код в директории ([src/terraform](https://github.com/netology-group/virt-homeworks/tree/virt-11/05-virt-04-docker-compose/src/terraform)).
> 
> Чтобы получить зачёт, вам нужно предоставить вывод команды terraform apply и страницы свойств, созданной ВМ из личного кабинета YandexCloud.

### Решение 2

1) ВМ созданная из веб интерфейса
![ready image](/screens/2.jpg)
2) ВМ созданная с помощью Terraform
```
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.node01 will be created
  + resource "yandex_compute_instance" "node01" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node01.netology.cloud"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMLcc0YPKNdNg0yd/FUiXGdQHxSe4nn0q78PzjLE9dE4 andrey@stp-vatest01
            EOT
        }
      + name                      = "node01"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v2"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8289cji0h6v14lblq9"
              + name        = "root-node01"
              + size        = 50
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 8
          + memory        = 8
        }
    }

  # yandex_vpc_network.default1 will be created
  + resource "yandex_vpc_network" "default1" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net1"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.default1 will be created
  + resource "yandex_vpc_subnet" "default1" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.101.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_node01_yandex_cloud = (known after apply)
  + internal_ip_address_node01_yandex_cloud = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_vpc_network.default1: Creating...
yandex_vpc_network.default1: Creation complete after 1s [id=enp1kq4mjre4l4nm9ncv]
yandex_vpc_subnet.default1: Creating...
yandex_vpc_subnet.default1: Creation complete after 1s [id=e9b7ts4fq6clp77kovrb]
yandex_compute_instance.node01: Creating...
yandex_compute_instance.node01: Still creating... [10s elapsed]
yandex_compute_instance.node01: Still creating... [20s elapsed]
yandex_compute_instance.node01: Still creating... [30s elapsed]
yandex_compute_instance.node01: Still creating... [40s elapsed]
yandex_compute_instance.node01: Still creating... [50s elapsed]
yandex_compute_instance.node01: Creation complete after 59s [id=fhm0gseg5k8dpe5q0lpj]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_node01_yandex_cloud = "158.160.63.116"
internal_ip_address_node01_yandex_cloud = "192.168.101.7"

```
Наша машина в облаке:
![ready image](/screens/3.jpg)

## Задача 3
>
> С помощью Ansible и Docker Compose разверните на виртуальной машине из предыдущего задания систему мониторинга на основе Prometheus/Grafana.
> Используйте Ansible-код в директории ([src/ansible](https://github.com/netology-group/virt-homeworks/tree/virt-11/05-virt-04-docker-compose/src/ansible)).
> 
> Чтобы получить зачёт, вам нужно предоставить вывод команды "docker ps" , все контейнеры, описанные в [docker-compose](https://github.com/netology-group/virt-homeworks/blob/virt-11/05-virt-04-docker-compose/src/ansible/stack/docker-compose.yaml),  должны быть в статусе "Up".

### Решение 3

1) Редактируем **inventory**, внеся внешний IP нашей ВМ и **provision.yml**, внеся корректное имя своего ключа
2) Запускаем playbook, подключаемся к ВМ и выводим статус контейнеров

```
$ ansible-playbook provision.yml

PLAY [nodes] ***********************************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************
Enter passphrase for key '/home/andrey/.ssh/id_ed25519':
ok: [node01.netology.cloud]

TASK [Create directory for ssh-keys] ***********************************************************************************************************************
ok: [node01.netology.cloud]
    ....
[root@node01 ~]# docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED          STATUS                    PORTS
                                             NAMES
8014f3fb14f1   prom/alertmanager:v0.20.0          "/bin/alertmanager -…"   21 minutes ago   Up 21 minutes             9093/tcp
                                             alertmanager
0f29f7fff641   gcr.io/cadvisor/cadvisor:v0.47.0   "/usr/bin/cadvisor -…"   21 minutes ago   Up 21 minutes (healthy)   8080/tcp
                                             cadvisor
e8079c45aca0   grafana/grafana:7.4.2              "/run.sh"                21 minutes ago   Up 21 minutes             3000/tcp
                                             grafana
a6d06d092bf3   prom/pushgateway:v1.2.0            "/bin/pushgateway"       21 minutes ago   Up 21 minutes             9091/tcp
                                             pushgateway
d218670b88cd   prom/prometheus:v2.17.1            "/bin/prometheus --c…"   21 minutes ago   Up 21 minutes             9090/tcp
                                             prometheus
89fa557bf077   prom/node-exporter:v0.18.1         "/bin/node_exporter …"   21 minutes ago   Up 21 minutes             9100/tcp
                                             nodeexporter
51cbe32aee59   stefanprodan/caddy                 "/sbin/tini -- caddy…"   21 minutes ago   Up 21 minutes             0.0.0.0:3000->3000/tcp, 0.0.0.0:9090-9091->9090-9091/tcp, 0.0.0.0:9093->9093/tcp   caddy

```

## Задача 4
>
> 1. Откройте веб-браузер, зайдите на страницу http://<внешний_ip_адрес_вашей_ВМ>:3000.
> 2. Используйте для авторизации логин и пароль из [.env-file](https://github.com/netology-group/virt-homeworks/blob/virt-11/05-virt-04-docker-compose/src/ansible/stack/.env).
> 3. Изучите доступный интерфейс, найдите в интерфейсе автоматически созданные docker-compose-панели с графиками([dashboards](https://grafana.com/docs/grafana/latest/dashboards/use-dashboards/)).
> 4. Подождите 5-10 минут, чтобы система мониторинга успела накопить данные.
> 
> Чтобы получить зачёт, предоставьте: 
> 
>- скриншот работающего веб-интерфейса Grafana с текущими метриками

### Решение 4
Метрики с нашей ВМ

![ready image](/screens/4.jpg)
