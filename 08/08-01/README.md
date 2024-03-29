# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
```commandline
$ ansible --version
ansible [core 2.14.4]
  config file = None
  configured module search path = ['/home/andrey/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/andrey/.local/lib/python3.10/site-packages/ansible
  ansible collection location = /home/andrey/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/andrey/.local/bin/ansible
  python version = 3.10.6 (main, Mar 10 2023, 10:55:28) [GCC 11.3.0] (/usr/bin/python3)
  jinja version = 3.0.3
  libyaml = True
```

2. Создайте свой публичный репозиторий на GitHub с произвольным именем.

Использую репозиторий, что создан для обучения в netology с отдельной директорией под задание

3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
```commandline
$ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Print OS] ********************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
```commandline
$ cat group_vars/all/examp.yml
---
  some_fact: "all default fact"
```
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
```commandline
docker run --name centos7 -d pycontribs/centos:7 sleep 36000000 && docker run --name ubuntu -d pycontribs/ubuntu sleep 65000000
```
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
```commandline
$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] **********************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ****************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP *********************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
```commandline
$ cat group_vars/el/examp.yml
---
  some_fact: "el default fact"
```
```commandline
$ cat group_vars/deb/examp.yml
---
  some_fact: "deb default fact"
```
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
```commandline
$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] **********************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ****************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *********************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
```commandline
$ ansible-vault encrypt group_vars/deb/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
```
```commandline
$ ansible-vault encrypt group_vars/el/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
```
или можно так:
```commandline
$ ansible-vault encrypt group_vars/el/* group_vars/deb/*
New Vault password:
Confirm New Vault password:
Encryption successful
```

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
```commandline
$ ansible-playbook -i inventory/prod.yml site.yml  --ask-vault-pass
Vault password:

PLAY [Print os facts] **********************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ****************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *********************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
- в данном случае ищем по упоминанию локального чего-нибудь, т.к. работаем на с локального хоста
```commandline
$ ansible-doc -t connection --list | grep local
ansible.builtin.local          execute on controller
```
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
```commandline
$ cat inventory/prod.yml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
```commandline
$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] **********************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ****************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP *********************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

Push сделан в основную ветку main, где сохраняю сдачу всех заданий.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
```commandline
$ ansible-vault decrypt --ask-vault-password group_vars/deb/* group_vars/el/*
Vault password:
Decryption successful
```
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
```commandline
$ ansible-vault encrypt_string "PaSSw0rd"
New Vault password:
Confirm New Vault password:
Encryption successful
!vault |
          $ANSIBLE_VAULT;1.1;AES256
          36326264336362613462646165383262373930643161626665613430303862343164646234373037
          6461386137353238623337653939383164386461323865310a373038323761626637633466323038
          30366638353130346236306632306330656164623631323734393432633137363937663864646436
          6538333962393765370a393632363365313838356537306335393031643834666166633362346663
          3331
```
```commandline
$ cat group_vars/all/examp.yml
---
  some_fact: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          36326264336362613462646165383262373930643161626665613430303862343164646234373037
          6461386137353238623337653939383164386461323865310a373038323761626637633466323038
          30366638353130346236306632306330656164623631323734393432633137363937663864646436
          6538333962393765370a393632363365313838356537306335393031643834666166633362346663
          3331
```
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
```commandline
$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] **********************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ****************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP *********************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
- запускаем новый контейнер
```commandline
$ docker run --name fedora -d pycontribs/fedora sleep 36000000
```
- создаем fact для нового хоста и заводим хост в inventory
```commandline
$ cat group_vars/fed/examp.yml
---
  some_fact: "fed default fact"
```
```commandline
$ cat inventory/prod.yml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
  fed:
    hosts:
      fedora:
        ansible_connection: docker
```
6. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
- напишем требуемый скрипт (в нем используем файл с хранением пароля к зашифрованным значениям - в целях в целях безопасности права на файл рекомендуется ограничивать да и скрывать его) и проверим работу
```commandline
$ cat script.sh
#! /usr/bin/bash
docker run --name centos7 -d pycontribs/centos:7 sleep 36000000 && docker run --name ubuntu -d pycontribs/ubuntu sleep 65000000 && docker run --name fedora -d pycontribs/fedora sleep 36000000
ansible-playbook -i inventory/prod.yml site.yml --vault-password-file vault_pass.txt
docker stop $(docker ps -q) && docker container prune -f
```
```commandline
$ bash script.sh
2b4cfa9d0d429c39649957ba55211479584957bb01414ff48d968828334758a2
b3927f34d7bed9240393df56a5dc3d00c420c3ae5573e68820a717a4d522acf9
537e9b700f656b4022b2e8d8c8b55e671cb9298dbe2debb681a3cb79dc1ce81d

PLAY [Print os facts] ***************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [fedora]
ok: [centos7]

TASK [Print OS] *********************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [fedora] => {
    "msg": "Fedora"
}

TASK [Print fact] *******************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [fedora] => {
    "msg": "fed default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP **************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

537e9b700f65
b3927f34d7be
2b4cfa9d0d42
Deleted Containers:
537e9b700f656b4022b2e8d8c8b55e671cb9298dbe2debb681a3cb79dc1ce81d
b3927f34d7bed9240393df56a5dc3d00c420c3ae5573e68820a717a4d522acf9
2b4cfa9d0d429c39649957ba55211479584957bb01414ff48d968828334758a2

Total reclaimed space: 9.006kB
```
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

- последний commit с изменениями по необязательному заданию
