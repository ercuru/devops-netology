# Домашнее задание к занятию 2. «Облачные провайдеры и синтаксис Terraform»

> Зачастую разбираться в новых инструментах гораздо интереснее, если понимаешь, как они работают изнутри. 
> Поэтому в рамках первого *необязательного* задания предлагаем завести свою учётную запись в AWS (Amazon Web Services) или Yandex.Cloud.
> Идеально будет познакомиться с обоими облаками, потому что они отличаются. 

## Задача 1 (вариант с Yandex.Cloud). Регистрация в Яндекс Облаке и знакомство с основами (не обязательно, но крайне желательно)
> 
> 1. Подробная инструкция на русском языке лежит [здесь](https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart).
> 2. Обратите внимание на период бесплатного использования после регистрации аккаунта. 
> 3. Используйте раздел «Подготовьте облако к работе» для регистрации аккаунта. Далее раздел «Настройте провайдер» для подготовки
> базового Terraform-конфига.
> 4. Воспользуйтесь [инструкцией](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs) на сайте Terraform, чтобы 
> не указывать авторизационный токен в коде, а Terraform-провайдер брал его из переменных окружений.

### Решение 1
- согласно инструкции Yandex вносим изменения в .terraformrc
```
$ cat .terraformrc
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```
- создаем переменные окружения
```commandline
export TF_VAR_yc_token=$(yc config get token)
export TF_VAR_yc_cloud_id=$(yc config get cloud-id)
```

## Задача 2. Создание AWS ec2 или yandex _compute _instance через Terraform
> 
> 1. В каталоге `Terraform` вашего основного репозитория, который был создан в начале курсе, создайте файл `main.tf` и `versions.tf`.
> 2. Для [Yandex.Cloud](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs). Подробную инструкцию можно найти 
>   [здесь](https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart).
> 3. Внимание. В git-репозиторий нельзя пушить ваши личные ключи доступа к аккаунту. Поэтому в предыдущем задании мы указывали
> их в виде переменных окружения. 
> 4. В файле `main.tf` воспользуйтесь блоком `data "aws_ami` для поиска ami-образа последнего Ubuntu.  
> 5. В файле `main.tf` создайте ресурс 
>  - [yandex _compute _image](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_image).
> 7. Если вы выполнили первый пункт, то добейтесь того, что бы команда `terraform plan` выполнялась без ошибок. 
> 
> В качестве результата задания предоставьте:
> 
> 1. Ответ на вопрос, при помощи какого инструмента из разобранных на прошлом занятии можно создать свой образ ami.
> 1. Ссылку на репозиторий с исходной конфигурацией Terraform.  

### Решение 2

1) Ответ на вопрос: при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami?
- Packer - https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-quickstart

2) Ссылку на репозиторий с исходной конфигурацией Terraform
- 
- приведем вывод команд terraform init, plan, apply и проверим ping 
```commandline
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of yandex-cloud/yandex from the dependency lock file
- Using previously-installed yandex-cloud/yandex v0.89.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.test will be created
  + resource "yandex_compute_instance" "test" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "node01.netology.cloud"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHkFDfdBQQJ8WDnxHK3kFNOvmbTVStNhtHKlJez8F4cM andrey@stp-vatest01
            EOT
        }
      + name                      = "testnode"
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
  + external_ip_address_test_vm = (known after apply)
  + internal_ip_address_test_vm = (known after apply)

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.test will be created
  + resource "yandex_compute_instance" "test" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "node01.netology.cloud"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHkFDfdBQQJ8WDnxHK3kFNOvmbTVStNhtHKlJez8F4cM andrey@stp-vatest01
            EOT
        }
      + name                      = "testnode"
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
  + external_ip_address_test_vm = (known after apply)
  + internal_ip_address_test_vm = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_vpc_network.default1: Creating...
yandex_vpc_network.default1: Creation complete after 1s [id=enp6arenpi36jdh6utnl]
yandex_vpc_subnet.default1: Creating...
yandex_vpc_subnet.default1: Creation complete after 1s [id=e9bn94lmpkb4k10thalc]
yandex_compute_instance.test: Creating...
yandex_compute_instance.test: Still creating... [10s elapsed]
yandex_compute_instance.test: Still creating... [20s elapsed]
yandex_compute_instance.test: Still creating... [30s elapsed]
yandex_compute_instance.test: Still creating... [40s elapsed]
yandex_compute_instance.test: Still creating... [50s elapsed]
yandex_compute_instance.test: Still creating... [1m0s elapsed]
yandex_compute_instance.test: Creation complete after 1m3s [id=fhm395fsvjve0833qmm0]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_test_vm = "51.250.84.201"
internal_ip_address_test_vm = "192.168.101.9"

$ ping 51.250.84.201
PING 51.250.84.201 (51.250.84.201) 56(84) bytes of data.
64 bytes from 51.250.84.201: icmp_seq=1 ttl=52 time=16.4 ms
64 bytes from 51.250.84.201: icmp_seq=2 ttl=52 time=15.8 ms
64 bytes from 51.250.84.201: icmp_seq=3 ttl=52 time=15.7 ms
64 bytes from 51.250.84.201: icmp_seq=4 ttl=52 time=15.9 ms
64 bytes from 51.250.84.201: icmp_seq=5 ttl=52 time=15.6 ms
64 bytes from 51.250.84.201: icmp_seq=6 ttl=52 time=15.7 ms
64 bytes from 51.250.84.201: icmp_seq=7 ttl=52 time=15.5 ms
64 bytes from 51.250.84.201: icmp_seq=8 ttl=52 time=15.8 ms
^C
--- 51.250.84.201 ping statistics ---
8 packets transmitted, 8 received, 0% packet loss, time 7012ms
rtt min/avg/max/mdev = 15.527/15.781/16.364/0.244 ms

```