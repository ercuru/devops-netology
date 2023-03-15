
# Домашнее задание к занятию "2. Применение принципов IaaC в работе с виртуальными машинами"


---

## Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
> - улучшенная надежность и воспроизводимость: автоматизация процессов интеграции, тестирования и развертывания помогает обеспечить согласованность и надежность в установке инфраструктуры, снижая риски ошибок 
> - увеличение скорости развертывания изменений: за счёт упрощения внесения изменений и развертывания в инфраструктуру
> - улучшение коммуникации и взаимодействия: централизованный и автоматизированный подход для управления изменениями в инфраструктуре позволяет улучшить коммуникацию и взаимодействие в команде
> - масштабируемость и эффективность: автоматизация помогает в кратчайшие сроки не только вносить изменения в существующую инфраструктуру, но и быстро масштабировать ее 
- Какой из принципов IaaC является основополагающим?
> - Идемпотентность - свойство объекта или операции при повторном применении операции к объекту давать тот же результат, что и при первом.

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
> - имеет низкий порог входа
> - широкое распространение
> - отсутствие агентов для развертывания
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
> - на мой взгляд оба метода равноправны и их применение зависит в первую очередь от инфраструктуры, в которой вы собираетесь ее применять.  
## Задача 3

> Установить на личный компьютер:
> 
> - [VirtualBox](https://www.virtualbox.org/)
> - [Vagrant](https://github.com/netology-code/devops-materials)
> - [Terraform](https://github.com/netology-code/devops-materials/blob/master/README.md)
> - Ansible
> 
> *Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*

### Решение 3         
- Vagrant
```
$ vagrant --version
Vagrant 2.2.19
```
- VirtualBox
```
$ virtualbox --help
Oracle VM VirtualBox VM Selector v6.1.42
```
- Terraform
```
$ terraform --version
Terraform v1.4.0
on linux_amd64
```
- Ansible
```
$ ansible --version
ansible 2.10.8
```

## Задача 4 

> Воспроизвести практическую часть лекции самостоятельно.
> 
> - Создать виртуальную машину.
> - Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
> ```
> docker ps
> ```
> Vagrantfile из лекции  и код ansible находятся в [папке](https://github.com/netology-code/virt-homeworks/tree/virt-11/05-virt-02-iaac/src).
> 
> Примечание! Если Vagrant выдает вам ошибку:
> ```
> URL: ["https://vagrantcloud.com/bento/ubuntu-20.04"]     
> Error: The requested URL returned error: 404:
> ```
> 
> Выполните следующие действия:
> 1. Скачайте с [сайта](https://app.vagrantup.com/bento/boxes/ubuntu-20.04) файл-образ "bento/ubuntu-20.04"
> 2. Добавьте его в список образов Vagrant: "vagrant box add bento/ubuntu-20.04 <путь к файлу>"

### Решение 4

- Редактируем Ansible Playbook для корректной отработки шагов, описанных в изначальном файле и в соответствии с имеющимися на хосте гипервизоре настройками

```
---

  - hosts: nodes
    become: yes
    become_user: root
    remote_user: vagrant

    tasks:
      - name: Create directory for ssh-keys
        file: state=directory mode=0700 dest=/root/.ssh/

      - name: Adding ed25519-key in /root/.ssh/authorized_keys
        copy: src=~/.ssh/id_ed25519.pub dest=/root/.ssh/authorized_keys owner=root mode=0600
        ignore_errors: yes

      - name: Checking DNS
        command: host -t A google.com

      - name: Installing tools
        apt: >
          package={{ item }}
          state=present
          update_cache=yes
        with_items:
          - git
          - curl
          - ca-certificates
          - gnupg
          - lsb-release

      - name: Create directory with 0755 permissions
        file:
          path: /etc/apt/keyrings
          state: directory
          mode: '0755'

      - name: Copy file from local to remote
        copy:
          src: ~/practise/netology/5_2/gpg
          dest: /root/gpg
          owner: root
          mode: '0755'

      - name: Decrypt gpg file and save to /etc/apt/keyrings/docker.gpg
        shell: gpg --dearmor -o /etc/apt/keyrings/docker.gpg /root/gpg

      - name: Set permissions for /etc/apt/keyrings/docker.gpg
        file:
          path: /etc/apt/keyrings/docker.gpg
          mode: '0644'

      - name: Add Docker repository to sources.list.d
        shell: echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu focal stable' | tee /etc/apt/sources.list.d/docker.list > /dev/null

      - name: Set permissions for /etc/apt/sources.list.d/docker.list
        file:
          path: /etc/apt/sources.list.d/docker.list
          mode: '0755'

      - name: Install Docker
        apt:
          update_cache: yes
          name:
            - docker-ce
            - docker-ce-cli
            - containerd.io
            - docker-buildx-plugin
            - docker-compose-plugin
          state: present  

      - name: Add the current user to docker group
        user: name=vagrant append=yes groups=docker

```
- Создаем ВМ с предварительно зарегистрированного файла-образа скаченного с https://app.vagrantup.com
```
$ vagrant box add bento/ubuntu-20.04 ./virtualbox.box
$ vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
        ...
PLAY RECAP *********************************************************************
server1.netology           : ok=12   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
- Проверяем docker на созданной ВМ
```
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$ docker version
Client: Docker Engine - Community
 Version:           23.0.1
 API version:       1.42
 Go version:        go1.19.5
 Git commit:        a5ee5b1
 Built:             Thu Feb  9 19:46:56 2023
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          23.0.1
  API version:      1.42 (minimum version 1.12)
  Go version:       go1.19.5
  Git commit:       bc3805a
  Built:            Thu Feb  9 19:46:56 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.18
  GitCommit:        2456e983eb9e37e47538f59ea18f2043c9a73640
 runc:
  Version:          1.1.4
  GitCommit:        v1.1.4-0-g5fd4c4d
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

```