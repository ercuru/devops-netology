# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
Использую репозиторий, что создан для обучения в netology с отдельной директорией под задание
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
```commandline
$ svn checkout https://github.com/netology-code/mnt-homeworks/trunk/08-ansible-02-playbook/playbook
```
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.
 - Создаем хостовые машины - использую Vagrant c образом centos/7 предварительно загруженным
```commandline
$ cat Vagrantfile
ISO = "centos/7"
NET = "192.168.57."
DOMAIN = ".netology"
HOST_PREFIX = "8-2.server"
INVENTORY_PATH = "../ansible/inventory"

servers = [
  {
    :hostname => HOST_PREFIX + "1" + DOMAIN,
    :ip => NET + "11",
    :ssh_host => "20011",
    :ssh_vm => "22",
    :ram => 1024,
    :core => 1
  },
  {
    :hostname => HOST_PREFIX + "2" + DOMAIN,
    :ip => NET + "12",
    :ssh_host => "20012",
    :ssh_vm => "22",
    :ram => 1024,
    :core => 1
  }
]

Vagrant.configure(2) do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: false
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = ISO
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip]
      node.vm.network :forwarded_port, guest: machine[:ssh_vm], host: machine[:ssh_host]
      node.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
        vb.customize ["modifyvm", :id, "--cpus", machine[:core]]
        vb.name = machine[:hostname]
      end
# add public key to created VM
      node.vm.provision "shell" do |s|
        ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_ed25519.pub").first.strip
        s.inline = <<-SHELL
# for vagrant user
          echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
# for debian systems
#         echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
        SHELL
      end
    end
  end
end
```
- дополняем inventory и проверяем доступность VM
```commandline
$ ansible all -m ping -i inventory/prod.yml
clickhouse-02 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
clickhouse-01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```
## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
- устанавливаем ansible-lint
```commandline
sudo apt-get install ansible-lint
```
- запускаем
```commandline
$ ansible-lint ./playbook/site.yml
WARNING: PATH altered to include /usr/bin
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: ./playbook/site.yml
WARNING  Listing 2 violation(s) that are fatal
yaml: wrong indentation: expected 8 but found 9 (indentation)
playbook/site.yml:34

yaml: too many blank lines (1 > 0) (empty-lines)
playbook/site.yml:79

You can skip specific rules or tags by adding them to your configuration file:
# .ansible-lint
warn_list:  # or 'skip_list' to silence them completely
  - yaml  # Violations reported by yamllint

Finished with 2 failure(s), 0 warning(s) on 1 files.
```
- исправляем ошибки и снова запускаем проверку
```commandline
$ ansible-lint ./playbook/site.yml
WARNING: PATH altered to include /usr/bin
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: ./playbook/site.yml
$
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```commandline
$ ansible-playbook site.yml -i inventory/prod.yml --check

PLAY [Install Clickhouse] **********************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ******************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ******************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] *************************************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system", "rc": 127, "results": ["No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system"]}

PLAY RECAP *************************************************************************************************************************************************
clickhouse-01              : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```commandline
$ ansible-playbook site.yml -i inventory/prod.yml --diff

PLAY [Install Clickhouse] **********************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ******************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ******************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] *************************************************************************************************************************
changed: [clickhouse-01]

TASK [Flush handlers] **************************************************************************************************************************************

RUNNING HANDLER [Start clickhouse service] *****************************************************************************************************************
changed: [clickhouse-01]

TASK [Wait for Clickhouse] *********************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] *************************************************************************************************************************************
changed: [clickhouse-01]

PLAY [Install Vector] **************************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************
ok: [clickhouse-02]

TASK [Get Vector distrib] **********************************************************************************************************************************
changed: [clickhouse-02]

TASK [Install Vector | YUM install] ************************************************************************************************************************
changed: [clickhouse-02]

TASK [Vector | Template config] ****************************************************************************************************************************
--- before
+++ after: /home/andrey/.ansible/tmp/ansible-local-172753dpdip1am/tmptwc5psbr/vector.yml.j2
@@ -0,0 +1,15 @@
+---
+sinks:
+    to_clickhouse:
+        compression: gzip
+        database: logs
+        endpoint: http://10.0.2.15:8123
+        healthcheck: false
+        inputs:
+        - our_log
+        skip_unknown_fields: true
+        table: access_logs
+        type: clickhouse
+sources:
+    our_log:
+        ignore_older_secs: 600
+        include:
+        - home/vagrant/logs/1.log
+        read_from: beginning
+        type: file

changed: [clickhouse-02]

TASK [Vector | Template systemd unit] **********************************************************************************************************************
--- before
+++ after: /home/andrey/.ansible/tmp/ansible-local-172753dpdip1am/tmpkknrkq0n/vector.service.yml.j2
@@ -0,0 +1,12 @@
+---
+[Unit]
+Description=Vector service
+After=network.target
+Requires=network-online.target
+[Service]
+User=root
+Group=root
+ExecStart=/usr/bin/vector --config-yaml /etc/vector/vector.yml
+Restart=always
+[Install]
+WantedBy=multi-user.target
\ No newline at end of file

changed: [clickhouse-02]

PLAY RECAP *************************************************************************************************************************************************
clickhouse-01              : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
clickhouse-02              : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```commandline
$ ansible-playbook site.yml -i inventory/prod.yml --diff

PLAY [Install Clickhouse] **********************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ******************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "vagrant", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "vagrant", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ******************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] *************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] **************************************************************************************************************************************

TASK [Wait for Clickhouse] *********************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] *************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] **************************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************
ok: [clickhouse-02]

TASK [Get Vector distrib] **********************************************************************************************************************************
ok: [clickhouse-02]

TASK [Install Vector | YUM install] ************************************************************************************************************************
ok: [clickhouse-02]

TASK [Vector | Template config] ****************************************************************************************************************************
ok: [clickhouse-02]

TASK [Vector | Template systemd unit] **********************************************************************************************************************
ok: [clickhouse-02]

PLAY RECAP *************************************************************************************************************************************************
clickhouse-01              : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
clickhouse-02              : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
-  [README.md](./playbook/README.md)
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

