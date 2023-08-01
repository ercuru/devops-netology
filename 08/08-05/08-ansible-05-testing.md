# Домашнее задание к занятию 5 «Тестирование roles»


<details>
  <summary>Подготовка к выполнению</summary>

>1. Установите molecule: `pip3 install "molecule==3.5.2"` и драйвера `pip3 install molecule_docker molecule_podman`.
>2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри.

Предварительная установка 
```shell
pip3 install "molecule==3.5.2"
pip3 install "molecule-docker==1.1.0"
pip install "requests==2.28.1"
pip install flake8
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install containers.podman
ansible-galaxy collection install community.docker
```

Образ aragast/netology:latest скачан

</details>


## Основная часть

>Ваша цель — настроить тестирование ваших ролей. 
>
>Задача — сделать сценарии тестирования для vector. 
>
>Ожидаемый результат — все сценарии успешно проходят тестирование ролей.

### Molecule

>1. Запустите  `molecule test -s centos_7` внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу.

<details>
  <summary>Вывод molecule test для clickhouse</summary>

```shell
$ molecule test -s centos_7
INFO     centos_7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/andrey/.cache/ansible-compat/7e099f/modules:/home/andrey/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/andrey/.cache/ansible-compat/7e099f/collections:/home/andrey/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/andrey/.cache/ansible-compat/7e099f/roles:/home/andrey/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > lint
COMMAND: yamllint .
ansible-lint
flake8

WARNING: PATH altered to include /usr/bin
WARNING  Loading custom .yamllint config file, this extends our internal yamllint config.
WARNING  Listing 1 violation(s) that are fatal
risky-file-permissions: File permissions unset or incorrect
tasks/install/apt.yml:45 Task/Handler: Hold specified version during APT upgrade | Package installation

You can skip specific rules or tags by adding them to your configuration file:
# .ansible-lint
warn_list:  # or 'skip_list' to silence them completely
  - experimental  # all rules tagged as experimental

Finished with 0 failure(s), 1 warning(s) on 53 files.
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos_7)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > syntax

playbook: /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/resources/playbooks/converge.yml
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > create

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Create Dockerfiles from image names] *************************************
changed: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'diff': [], 'dest': '/home/andrey/.cache/molecule/clickhouse/centos_7/Dockerfile_centos_7', 'src': '/home/andrey/.ansible/tmp/ansible-tmp-1690746354.6549332-7877-194218216983571/source', 'md5sum': 'e90d08cd34f49a5f8a41a07de1348618', 'checksum': '4b70768619482424811f2977aa277a5acf2b13a1', 'changed': True, 'uid': 1000, 'gid': 1000, 'owner': 'andrey', 'group': 'andrey', 'mode': '0600', 'state': 'file', 'size': 2199, 'invocation': {'module_args': {'src': '/home/andrey/.ansible/tmp/ansible-tmp-1690746354.6549332-7877-194218216983571/source', 'dest': '/home/andrey/.cache/molecule/clickhouse/centos_7/Dockerfile_centos_7', 'mode': '0600', 'follow': False, '_original_basename': 'Dockerfile.j2', 'checksum': '4b70768619482424811f2977aa277a5acf2b13a1', 'backup': False, 'force': True, 'unsafe_writes': False, 'content': None, 'validate': None, 'directory_mode': None, 'remote_src': None, 'local_follow': None, 'owner': None, 'group': None, 'seuser': None, 'serole': None, 'selevel': None, 'setype': None, 'attributes': None}}, 'failed': False, 'item': {'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
ok: [localhost] => (item=molecule_local/centos:7)

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '404978787754.8004', 'results_file': '/home/andrey/.ansible_async/404978787754.8004', 'changed': True, 'item': {'capabilities': ['SYS_ADMIN'], 'command': '/usr/sbin/init', 'dockerfile': '../resources/Dockerfile.j2', 'env': {'ANSIBLE_USER': 'ansible', 'DEPLOY_GROUP': 'deployer', 'SUDO_GROUP': 'wheel', 'container': 'docker'}, 'image': 'centos:7', 'name': 'centos_7', 'privileged': True, 'tmpfs': ['/run', '/tmp'], 'volumes': ['/sys/fs/cgroup:/sys/fs/cgroup']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=7    changed=3    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_7]

TASK [Apply Clickhouse Role] ***************************************************

TASK [clickhouse : Include OS Family Specific Variables] ***********************
ok: [centos_7]

TASK [clickhouse : include_tasks] **********************************************
included: /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/tasks/precheck.yml for centos_7

TASK [clickhouse : Requirements check | Checking sse4_2 support] ***************
ok: [centos_7]

TASK [clickhouse : Requirements check | Not supported distribution && release] ***
skipping: [centos_7]

TASK [clickhouse : include_tasks] **********************************************
included: /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/tasks/params.yml for centos_7

TASK [clickhouse : Set clickhouse_service_enable] ******************************
ok: [centos_7]

TASK [clickhouse : Set clickhouse_service_ensure] ******************************
ok: [centos_7]

TASK [clickhouse : include_tasks] **********************************************
included: /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/tasks/install/yum.yml for centos_7

TASK [clickhouse : Install by YUM | Ensure clickhouse repo installed] **********
--- before: /etc/yum.repos.d/clickhouse.repo
+++ after: /etc/yum.repos.d/clickhouse.repo
@@ -0,0 +1,6 @@
+[clickhouse]
+baseurl = https://packages.clickhouse.com/rpm/stable/
+enabled = 1
+gpgcheck = 0
+name = Clickhouse repo
+

changed: [centos_7]

TASK [clickhouse : Install by YUM | Ensure clickhouse package installed (latest)] ***
changed: [centos_7]

TASK [clickhouse : Install by YUM | Ensure clickhouse package installed (version latest)] ***
skipping: [centos_7]

TASK [clickhouse : include_tasks] **********************************************
included: /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/tasks/configure/sys.yml for centos_7

TASK [clickhouse : Check clickhouse config, data and logs] *********************
ok: [centos_7] => (item=/var/log/clickhouse-server)
--- before
+++ after
@@ -1,4 +1,4 @@
 {
-    "mode": "0700",
+    "mode": "0770",
     "path": "/etc/clickhouse-server"
 }

changed: [centos_7] => (item=/etc/clickhouse-server)
--- before
+++ after
@@ -1,7 +1,7 @@
 {
-    "group": 0,
-    "mode": "0755",
-    "owner": 0,
+    "group": 996,
+    "mode": "0770",
+    "owner": 999,
     "path": "/var/lib/clickhouse/tmp/",
-    "state": "absent"
+    "state": "directory"
 }

changed: [centos_7] => (item=/var/lib/clickhouse/tmp/)
--- before
+++ after
@@ -1,4 +1,4 @@
 {
-    "mode": "0700",
+    "mode": "0770",
     "path": "/var/lib/clickhouse/"
 }

changed: [centos_7] => (item=/var/lib/clickhouse/)

TASK [clickhouse : Config | Create config.d folder] ****************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
-    "mode": "0500",
+    "mode": "0770",
     "path": "/etc/clickhouse-server/config.d"
 }

changed: [centos_7]

TASK [clickhouse : Config | Create users.d folder] *****************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
-    "mode": "0500",
+    "mode": "0770",
     "path": "/etc/clickhouse-server/users.d"
 }

changed: [centos_7]

TASK [clickhouse : Config | Generate system config] ****************************
--- before
+++ after: /home/andrey/.ansible/tmp/ansible-local-8139sm03rg3r/tmpb0tmvvwd/config.j2
@@ -0,0 +1,382 @@
+<?xml version="1.0"?>
+<!--
+ -
+ - Ansible managed: Do NOT edit this file manually!
+ -
+-->
+<clickhouse>
+    <logger>
+        <!-- Possible levels: https://github.com/pocoproject/poco/blob/develop/Foundation/include/Poco/Logger.h#L105 -->
+        <level>trace</level>
+        <log>/var/log/clickhouse-server/clickhouse-server.log</log>
+        <errorlog>/var/log/clickhouse-server/clickhouse-server.err.log</errorlog>
+        <size>1000M</size>
+        <count>10</count>
+    </logger>
+
+    <http_port>8123</http_port>
+
+    <tcp_port>9000</tcp_port>
+
+    <!-- Used with https_port and tcp_port_secure. Full ssl options list: https://github.com/ClickHouse-Extras/poco/blob/master/NetSSL_OpenSSL/include/Poco/Net/SSLManager.h#L71 -->
+    <openSSL>
+        <server> <!-- Used for https server AND secure tcp port -->
+            <!-- openssl req -subj "/CN=localhost" -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout /etc/clickhouse-server/server.key -out /etc/clickhouse-server/server.crt -->
+            <certificateFile>/etc/clickhouse-server/server.crt</certificateFile>
+            <privateKeyFile>/etc/clickhouse-server/server.key</privateKeyFile>
+            <!-- openssl dhparam -out /etc/clickhouse-server/dhparam.pem 4096 -->
+            <dhParamsFile>/etc/clickhouse-server/dhparam.pem</dhParamsFile>
+            <verificationMode>none</verificationMode>
+            <loadDefaultCAFile>true</loadDefaultCAFile>
+            <cacheSessions>true</cacheSessions>
+            <disableProtocols>sslv2,sslv3</disableProtocols>
+            <preferServerCiphers>true</preferServerCiphers>
+        </server>
+
+        <client> <!-- Used for connecting to https dictionary source -->
+            <loadDefaultCAFile>true</loadDefaultCAFile>
+            <cacheSessions>true</cacheSessions>
+            <disableProtocols>sslv2,sslv3</disableProtocols>
+            <preferServerCiphers>true</preferServerCiphers>
+            <!-- Use for self-signed: <verificationMode>none</verificationMode> -->
+            <invalidCertificateHandler>
+                <!-- Use for self-signed: <name>AcceptCertificateHandler</name> -->
+                <name>RejectCertificateHandler</name>
+            </invalidCertificateHandler>
+        </client>
+    </openSSL>
+
+    <!-- Default root page on http[s] server. For example load UI from https://tabix.io/ when opening http://localhost:8123 -->
+    <!--
+    <http_server_default_response><![CDATA[<html ng-app="SMI2"><head><base href="http://ui.tabix.io/"></head><body><div ui-view="" class="content-ui"></div><script src="http://loader.tabix.io/master.js"></script></body></html>]]></http_server_default_response>
+    -->
+
+    <!-- Port for communication between replicas. Used for data exchange. -->
+    <interserver_http_port>9009</interserver_http_port>
+
+
+
+    <!-- Hostname that is used by other replicas to request this server.
+         If not specified, than it is determined analoguous to 'hostname -f' command.
+         This setting could be used to switch replication to another network interface.
+      -->
+    <!--
+    <interserver_http_host>example.clickhouse.com</interserver_http_host>
+    -->
+
+    <!-- Listen specified host. use :: (wildcard IPv6 address), if you want to accept connections both with IPv4 and IPv6 from everywhere. -->
+    <!-- <listen_host>::</listen_host> -->
+    <!-- Same for hosts with disabled ipv6: -->
+    <!-- <listen_host>0.0.0.0</listen_host> -->
+    <listen_host>127.0.0.1</listen_host>
+
+    <max_connections>2048</max_connections>
+    <keep_alive_timeout>3</keep_alive_timeout>
+
+    <!-- Maximum number of concurrent queries. -->
+    <max_concurrent_queries>100</max_concurrent_queries>
+
+    <!-- Set limit on number of open files (default: maximum). This setting makes sense on Mac OS X because getrlimit() fails to retrieve
+         correct maximum value. -->
+    <!-- <max_open_files>262144</max_open_files> -->
+
+    <!-- Size of cache of uncompressed blocks of data, used in tables of MergeTree family.
+         In bytes. Cache is single for server. Memory is allocated only on demand.
+         Cache is used when 'use_uncompressed_cache' user setting turned on (off by default).
+         Uncompressed cache is advantageous only for very short queries and in rare cases.
+      -->
+    <uncompressed_cache_size>8589934592</uncompressed_cache_size>
+
+    <!-- Approximate size of mark cache, used in tables of MergeTree family.
+         In bytes. Cache is single for server. Memory is allocated only on demand.
+         You should not lower this value.
+      -->
+    <mark_cache_size>5368709120</mark_cache_size>
+
+
+    <!-- Path to data directory, with trailing slash. -->
+    <path>/var/lib/clickhouse/</path>
+
+    <!-- Path to temporary data for processing hard queries. -->
+    <tmp_path>/var/lib/clickhouse/tmp/</tmp_path>
+
+    <!-- Directory with user provided files that are accessible by 'file' table function. -->
+    <user_files_path>/var/lib/clickhouse/user_files/</user_files_path>
+
+    <!-- Path to configuration file with users, access rights, profiles of settings, quotas. -->
+    <users_config>users.xml</users_config>
+
+    <!-- Default profile of settings. -->
+    <default_profile>default</default_profile>
+
+    <!-- System profile of settings. This settings are used by internal processes (Buffer storage, Distibuted DDL worker and so on). -->
+    <!-- <system_profile>default</system_profile> -->
+
+    <!-- Default database. -->
+    <default_database>default</default_database>
+
+    <!-- Server time zone could be set here.
+
+         Time zone is used when converting between String and DateTime types,
+          when printing DateTime in text formats and parsing DateTime from text,
+          it is used in date and time related functions, if specific time zone was not passed as an argument.
+
+         Time zone is specified as identifier from IANA time zone database, like UTC or Africa/Abidjan.
+         If not specified, system time zone at server startup is used.
+
+         Please note, that server could display time zone alias instead of specified name.
+         Example: W-SU is an alias for Europe/Moscow and Zulu is an alias for UTC.
+    -->
+    <!-- <timezone>Europe/Moscow</timezone> -->
+
+    <!-- You can specify umask here (see "man umask"). Server will apply it on startup.
+         Number is always parsed as octal. Default umask is 027 (other users cannot read logs, data files, etc; group can only read).
+    -->
+    <!-- <umask>022</umask> -->
+
+    <!-- Perform mlockall after startup to lower first queries latency
+          and to prevent clickhouse executable from being paged out under high IO load.
+         Enabling this option is recommended but will lead to increased startup time for up to a few seconds.
+    -->
+    <mlock_executable>False</mlock_executable>
+
+    <!-- Configuration of clusters that could be used in Distributed tables.
+         https://clickhouse.com/docs/en/engines/table-engines/special/distributed/
+      -->
+    <remote_servers incl="clickhouse_remote_servers" />
+
+
+    <!-- If element has 'incl' attribute, then for it's value will be used corresponding substitution from another file.
+         By default, path to file with substitutions is /etc/metrika.xml. It could be changed in config in 'include_from' element.
+         Values for substitutions are specified in /clickhouse/name_of_substitution elements in that file.
+      -->
+
+    <!-- ZooKeeper is used to store metadata about replicas, when using Replicated tables.
+         Optional. If you don't use replicated tables, you could omit that.
+
+         See https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/replication/
+      -->
+    <zookeeper incl="zookeeper-servers" optional="true" />
+
+    <!-- Substitutions for parameters of replicated tables.
+          Optional. If you don't use replicated tables, you could omit that.
+         See https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/replication/#creating-replicated-tables
+      -->
+    <macros incl="macros" optional="true" />
+
+
+    <!-- Reloading interval for embedded dictionaries, in seconds. Default: 3600. -->
+    <builtin_dictionaries_reload_interval>3600</builtin_dictionaries_reload_interval>
+
+    <!-- If true, dictionaries are created lazily on first use. Otherwise they are initialised on server startup. Default: true -->
+    <!-- See also: https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-dictionaries_lazy_load -->
+    <dictionaries_lazy_load>True</dictionaries_lazy_load>
+
+    <!-- Maximum session timeout, in seconds. Default: 3600. -->
+    <max_session_timeout>3600</max_session_timeout>
+
+    <!-- Default session timeout, in seconds. Default: 60. -->
+    <default_session_timeout>60</default_session_timeout>
+
+    <!-- Sending data to Graphite for monitoring. Several sections can be defined. -->
+    <!--
+        interval - send every X second
+        root_path - prefix for keys
+        hostname_in_path - append hostname to root_path (default = true)
+        metrics - send data from table system.metrics
+        events - send data from table system.events
+        asynchronous_metrics - send data from table system.asynchronous_metrics
+    -->
+    <!--
+    <graphite>
+        <host>localhost</host>
+        <port>42000</port>
+        <timeout>0.1</timeout>
+        <interval>60</interval>
+        <root_path>one_min</root_path>
+        <hostname_in_path>true</hostname_in_path>
+
+        <metrics>true</metrics>
+        <events>true</events>
+        <asynchronous_metrics>true</asynchronous_metrics>
+    </graphite>
+    <graphite>
+        <host>localhost</host>
+        <port>42000</port>
+        <timeout>0.1</timeout>
+        <interval>1</interval>
+        <root_path>one_sec</root_path>
+
+        <metrics>true</metrics>
+        <events>true</events>
+        <asynchronous_metrics>false</asynchronous_metrics>
+    </graphite>
+    -->
+
+
+    <!-- Query log. Used only for queries with setting log_queries = 1. -->
+    <query_log>
+        <!-- What table to insert data. If table is not exist, it will be created.
+             When query log structure is changed after system update,
+              then old table will be renamed and new table will be created automatically.
+        -->
+        <database>system</database>
+        <table>query_log</table>
+        <!--
+            PARTITION BY expr https://clickhouse.com/docs/en/table_engines/mergetree-family/custom_partitioning_key/
+            Example:
+                event_date
+                toMonday(event_date)
+                toYYYYMM(event_date)
+                toStartOfHour(event_time)
+        -->
+        <partition_by>toYYYYMM(event_date)</partition_by>
+        <!-- Interval of flushing data. -->
+        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
+    </query_log>
+
+    <!-- Query thread log. Has information about all threads participated in query execution.
+         Used only for queries with setting log_query_threads = 1. -->
+    <query_thread_log>
+        <database>system</database>
+        <table>query_thread_log</table>
+        <partition_by>toYYYYMM(event_date)</partition_by>
+
+        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
+    </query_thread_log>
+
+    <!-- Uncomment if use part log.
+         Part log contains information about all actions with parts in MergeTree tables (creation, deletion, merges, downloads).
+    <part_log>
+        <database>system</database>
+        <table>part_log</table>
+        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
+    </part_log>
+    -->
+
+
+    <!-- Parameters for embedded dictionaries, used in Yandex.Metrica.
+         See https://clickhouse.com/docs/en/dicts/internal_dicts/
+    -->
+
+    <!-- Path to file with region hierarchy. -->
+    <!-- <path_to_regions_hierarchy_file>/opt/geo/regions_hierarchy.txt</path_to_regions_hierarchy_file> -->
+
+    <!-- Path to directory with files containing names of regions -->
+    <!-- <path_to_regions_names_files>/opt/geo/</path_to_regions_names_files> -->
+
+
+    <!-- Configuration of external dictionaries. See:
+         https://clickhouse.com/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts
+    -->
+    <dictionaries_config>*_dictionary.xml</dictionaries_config>
+
+    <!-- Uncomment if you want data to be compressed 30-100% better.
+         Don't do that if you just started using ClickHouse.
+      -->
+    <compression incl="clickhouse_compression">
+    <!--
+        <!- - Set of variants. Checked in order. Last matching case wins. If nothing matches, lz4 will be used. - ->
+        <case>
+
+            <!- - Conditions. All must be satisfied. Some conditions may be omitted. - ->
+            <min_part_size>10000000000</min_part_size>        <!- - Min part size in bytes. - ->
+            <min_part_size_ratio>0.01</min_part_size_ratio>   <!- - Min size of part relative to whole table size. - ->
+
+            <!- - What compression method to use. - ->
+            <method>zstd</method>
+        </case>
+    -->
+    </compression>
+
+    <!-- Allow to execute distributed DDL queries (CREATE, DROP, ALTER, RENAME) on cluster.
+         Works only if ZooKeeper is enabled. Comment it if such functionality isn't required. -->
+    <distributed_ddl>
+        <!-- Path in ZooKeeper to queue with DDL queries -->
+        <path>/clickhouse/task_queue/ddl</path>
+
+        <!-- Settings from this profile will be used to execute DDL queries -->
+        <!-- <profile>default</profile> -->
+    </distributed_ddl>
+
+    <!-- Settings to fine tune MergeTree tables. See documentation in source code, in MergeTreeSettings.h -->
+        <merge_tree>
+        </merge_tree>
+
+    <!-- Protection from accidental DROP.
+         If size of a MergeTree table is greater than max_table_size_to_drop (in bytes) than table could not be dropped with any DROP query.
+         If you want do delete one table and don't want to restart clickhouse-server, you could create special file <clickhouse-path>/flags/force_drop_table and make DROP once.
+         By default max_table_size_to_drop is 50GB; max_table_size_to_drop=0 allows to DROP any tables.
+         The same for max_partition_size_to_drop.
+         Uncomment to disable protection.
+    -->
+    <!-- <max_table_size_to_drop>0</max_table_size_to_drop> -->
+    <!-- <max_partition_size_to_drop>0</max_partition_size_to_drop> -->
+
+    <!-- Example of parameters for GraphiteMergeTree table engine -->
+    <graphite_rollup_example>
+        <pattern>
+            <regexp>click_cost</regexp>
+            <function>any</function>
+            <retention>
+                <age>0</age>
+                <precision>3600</precision>
+            </retention>
+            <retention>
+                <age>86400</age>
+                <precision>60</precision>
+            </retention>
+        </pattern>
+        <default>
+            <function>max</function>
+            <retention>
+                <age>0</age>
+                <precision>60</precision>
+            </retention>
+            <retention>
+                <age>3600</age>
+                <precision>300</precision>
+            </retention>
+            <retention>
+                <age>86400</age>
+                <precision>3600</precision>
+            </retention>
+        </default>
+    </graphite_rollup_example>
+
+
+    <!-- Exposing metrics data for scraping from Prometheus. -->
+    <!--
+        endpoint – HTTP endpoint for scraping metrics by prometheus server. Start from ‘/’.
+        port – Port for endpoint.
+        metrics – Flag that sets to expose metrics from the system.metrics table.
+        events – Flag that sets to expose metrics from the system.events table.
+        asynchronous_metrics – Flag that sets to expose current metrics values from the system.asynchronous_metrics table.
+    -->
+    <!--
+    <prometheus>
+        <endpoint>/metrics</endpoint>
+        <port>8001</port>
+        <metrics>true</metrics>
+        <events>true</events>
+        <asynchronous_metrics>true</asynchronous_metrics>
+    </prometheus>
+    -->
+
+
+    <!-- Directory in <clickhouse-path> containing schema files for various input formats.
+         The directory will be created if it doesn't exist.
+      -->
+    <format_schema_path>/var/lib/clickhouse//format_schemas/</format_schema_path>
+
+    <!-- Uncomment to disable ClickHouse internal DNS caching. -->
+    <!-- <disable_internal_dns_cache>1</disable_internal_dns_cache> -->
+
+    <kafka>
+    </kafka>
+
+
+
+
+
+</clickhouse>

changed: [centos_7]

TASK [clickhouse : Config | Generate users config] *****************************
--- before
+++ after: /home/andrey/.ansible/tmp/ansible-local-8139sm03rg3r/tmpqwy_upgx/users.j2
@@ -0,0 +1,106 @@
+<?xml version="1.0"?>
+<!--
+ -
+ - Ansible managed: Do NOT edit this file manually!
+ -
+-->
+<clickhouse>
+   <profiles>
+    <!-- Profiles of settings. -->
+    <!-- Default profiles. -->
+        <default>
+            <max_memory_usage>10000000000</max_memory_usage>
+            <use_uncompressed_cache>0</use_uncompressed_cache>
+            <load_balancing>random</load_balancing>
+            <max_partitions_per_insert_block>100</max_partitions_per_insert_block>
+        </default>
+        <readonly>
+            <readonly>1</readonly>
+        </readonly>
+        <!-- Default profiles end. -->
+    <!-- Custom profiles. -->
+        <!-- Custom profiles end. -->
+    </profiles>
+
+    <!-- Users and ACL. -->
+    <users>
+    <!-- Default users. -->
+            <!-- Default user for login if user not defined -->
+        <default>
+                <password></password>
+                <networks incl="networks" replace="replace">
+                <ip>::1</ip>
+                <ip>127.0.0.1</ip>
+                </networks>
+        <profile>default</profile>
+        <quota>default</quota>
+            </default>
+            <!-- Example of user with readonly access -->
+        <readonly>
+                <password></password>
+                <networks incl="networks" replace="replace">
+                <ip>::1</ip>
+                <ip>127.0.0.1</ip>
+                </networks>
+        <profile>readonly</profile>
+        <quota>default</quota>
+            </readonly>
+        <!-- Custom users. -->
+            <!-- classic user with plain password -->
+        <testuser>
+                <password_sha256_hex>f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2</password_sha256_hex>
+                <networks incl="networks" replace="replace">
+                <ip>::1</ip>
+                <ip>127.0.0.1</ip>
+                </networks>
+        <profile>default</profile>
+        <quota>default</quota>
+                 <allow_databases>
+                    <database>testu1</database>
+                </allow_databases>
+                            </testuser>
+            <!-- classic user with hex password -->
+        <testuser2>
+                <password>testplpassword</password>
+                <networks incl="networks" replace="replace">
+                <ip>::1</ip>
+                <ip>127.0.0.1</ip>
+                </networks>
+        <profile>default</profile>
+        <quota>default</quota>
+                 <allow_databases>
+                    <database>testu2</database>
+                </allow_databases>
+                            </testuser2>
+            <!-- classic user with multi dbs and multi-custom network allow password -->
+        <testuser3>
+                <password>testplpassword</password>
+                <networks incl="networks" replace="replace">
+                <ip>192.168.0.0/24</ip>
+                <ip>10.0.0.0/8</ip>
+                </networks>
+        <profile>default</profile>
+        <quota>default</quota>
+                 <allow_databases>
+                    <database>testu1</database>
+                    <database>testu2</database>
+                    <database>testu3</database>
+                </allow_databases>
+                            </testuser3>
+        </users>
+
+    <!-- Quotas. -->
+    <quotas>
+        <!-- Default quotas. -->
+        <default>
+        <interval>
+        <duration>3600</duration>
+        <queries>0</queries>
+        <errors>0</errors>
+        <result_rows>0</result_rows>
+        <read_rows>0</read_rows>
+        <execution_time>0</execution_time>
+    </interval>
+        </default>
+            </quotas>
+</clickhouse>

changed: [centos_7]

TASK [clickhouse : Config | Generate remote_servers config] ********************
skipping: [centos_7]

TASK [clickhouse : Config | Generate macros config] ****************************
skipping: [centos_7]

TASK [clickhouse : Config | Generate zookeeper servers config] *****************
skipping: [centos_7]

TASK [clickhouse : Config | Fix interserver_http_port and intersever_https_port collision] ***
skipping: [centos_7]

TASK [clickhouse : Notify Handlers Now] ****************************************

RUNNING HANDLER [clickhouse : Restart Clickhouse Service] **********************
ok: [centos_7]

TASK [clickhouse : include_tasks] **********************************************
included: /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/tasks/service.yml for centos_7

TASK [clickhouse : Ensure clickhouse-server.service is enabled: True and state: restarted] ***
fatal: [centos_7]: FAILED! => {"changed": false, "msg": "Service is in unknown state", "status": {}}

PLAY RECAP *********************************************************************
centos_7                   : ok=18   changed=7    unreachable=0    failed=1    skipped=6    rescued=0    ignored=0

CRITICAL Ansible return code was 2, command was: ['ansible-playbook', '-D', '--inventory', '/home/andrey/.cache/molecule/clickhouse/centos_7/inventory', '--skip-tags', 'molecule-notest,notest', '/home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/resources/playbooks/converge.yml']
WARNING  An error occurred during the test sequence action: 'converge'. Cleaning up.
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/andrey/practise/netology/8_4/playbook/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/andrey/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos_7)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

</details>

>4. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
>3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.

После создания сценария по умолчанию добавляем платформы с настройками для возможности вызова systemd в контенере docker - workaround для ошибки systemd в docker контейнере взят [тут](https://github.com/gdraheim/docker-systemctl-replacement/tree/master)
```yaml
platforms:
  - name: centos_8
    image: docker.io/pycontribs/centos:8
    pre_build_image: true
    volumes:
      - "$MOLECULE_PROJECT_DIRECTORY/systemctl3.py:/usr/bin/systemctl"
  - name: ubuntu_latest
    image: docker.io/pycontribs/ubuntu:latest
    volumes:
      - "$MOLECULE_PROJECT_DIRECTORY/systemctl3.py:/usr/bin/systemctl"
    pre_build_image: true
```

>5. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.). 

Добавляем проверки
```shell
---
# This is an example playbook to execute Ansible tests.

- name: Verify
  hosts: all
  gather_facts: true
  vars_files:
    -  "{{ lookup('ansible.builtin.env', 'MOLECULE_PROJECT_DIRECTORY') }}/defaults/main.yml"
    -  "{{ lookup('ansible.builtin.env', 'MOLECULE_PROJECT_DIRECTORY') }}/vars/main.yml"
  tasks:
  - name: Get Vector version
    become: true
    ansible.builtin.shell:  "vector -V | cut -d ' ' -f 2"
    register: vector_installed
    failed_when: vector_installed.rc !=0
    changed_when: vector_installed.rc ==0
    ignore_errors: true

  - name: Assert Vector version
    ansible.builtin.assert:
      that:
        - "({{ vector_installed.rc }} == 0  and vector_installed.stdout == vector_version)"
      success_msg: "{{ vector_installed.stdout }}"
      fail_msg:
        - "Failed to get Vector version. stdout: {{ vector_installed.stdout_lines }}"
        - "Failed to get Vector version. stderr: {{ vector_installed.stderr_lines }}"
  - name: Validate Vector config
    ansible.builtin.command:
      cmd: "vector validate --no-environment --config-toml {{ vector_config }}"
    changed_when: false
    failed_when: false
    register: vector_config
  - name: Assert Vector config
    ansible.builtin.assert:
      that:
        - "{{ vector_config.rc }} == 0"
      success_msg: "{{ vector_config.stdout }}"
      fail_msg: "{{ vector_config.stderr_lines }}"
  - name: Validate Vector service
    ansible.builtin.command:
      cmd: "systemctl status vector"
    changed_when: false
    failed_when: false
    register: vector_status
  - name: Assert Vector service
    ansible.builtin.assert:
      that:
        - "{{ vector_status.stdout_lines | regex_findall('running', multiline=True, ignorecase=True) }}"
        - "{{ vector_status.stdout_lines | regex_findall('enabled', multiline=True, ignorecase=True) }}"
      success_msg: Vector started and enabled
      fail_msg: "{{ vector_status.stdout_lines }}"
```

>7. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.

<details>
  <summary>Вывод molecule test для vector</summary>

```shell
$ molecule test
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/andrey/.cache/ansible-compat/e3fa2b/modules:/home/andrey/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/andrey/.cache/ansible-compat/e3fa2b/collections:/home/andrey/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/andrey/.cache/ansible-compat/e3fa2b/roles:/home/andrey/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos_8)
ok: [localhost] => (item=ubuntu_latest)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /home/andrey/practise/netology/8_5/vector_role/molecule/default/converge.yml
INFO     Running default > create

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/home/andrey/practise/netology/8_5/vector_role/systemctl3.py:/usr/bin/systemctl']})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/home/andrey/practise/netology/8_5/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/home/andrey/practise/netology/8_5/vector_role/systemctl3.py:/usr/bin/systemctl']})
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/home/andrey/practise/netology/8_5/vector_role/systemctl3.py:/usr/bin/systemctl']})
skipping: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/home/andrey/practise/netology/8_5/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/home/andrey/practise/netology/8_5/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item', 'i': 1, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest)
skipping: [localhost]

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/home/andrey/practise/netology/8_5/vector_role/systemctl3.py:/usr/bin/systemctl']})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/home/andrey/practise/netology/8_5/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '494920770658.178122', 'results_file': '/home/andrey/.ansible_async/494920770658.178122', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/home/andrey/practise/netology/8_5/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '880101612465.178148', 'results_file': '/home/andrey/.ansible_async/880101612465.178148', 'changed': True, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/home/andrey/practise/netology/8_5/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Include vector_role] *****************************************************

TASK [vector_role : Create directory vector] ***********************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Get vector distrib] ****************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Unarchive vector] ******************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector_role : Create a symbolic link] ************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector_role : Mkdir vector data] *****************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector_role : Vector config create] **************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Create vector unit flie] ***********************************
changed: [ubuntu_latest]
changed: [centos_8]

RUNNING HANDLER [vector_role : Restart Vector] *********************************
changed: [ubuntu_latest]
changed: [centos_8]

PLAY RECAP *********************************************************************
centos_8                   : ok=9    changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=9    changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running default > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [Include vector_role] *****************************************************

TASK [vector_role : Create directory vector] ***********************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [vector_role : Get vector distrib] ****************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [vector_role : Unarchive vector] ******************************************
skipping: [centos_8]
skipping: [ubuntu_latest]

TASK [vector_role : Create a symbolic link] ************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [vector_role : Mkdir vector data] *****************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [vector_role : Vector config create] **************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [vector_role : Create vector unit flie] ***********************************
ok: [centos_8]
ok: [ubuntu_latest]

PLAY RECAP *********************************************************************
centos_8                   : ok=7    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu_latest              : ok=7    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Get Vector version] ******************************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [Assert Vector version] ***************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "0.29.1"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "0.29.1"
}

TASK [Validate Vector config] **************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Assert Vector config] ****************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}

TASK [Validate Vector service] *************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Assert Vector service] ***************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "Vector started and enabled"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "Vector started and enabled"
}

PLAY RECAP *********************************************************************
centos_8                   : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
```

</details>

>6. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

Добавил тег: [1.1.0](https://github.com/ercuru/vector_role/tree/1.1.0)

### Tox

>1. Добавьте в директорию с vector-role файлы из [директории](./example).
>2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
>3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.

<details>
  <summary>Вывод tox</summary>

```shell
$ docker run --privileged=True -v /home/andrey/practise/netology/8_5/vector_role:/opt/vector_role -w /opt/vector_role -it aragast/netology:latest /bin/bash
[root@0583c528e8be vector_role]# tox
py37-ansible210 create: /opt/vector_role/.tox/py37-ansible210
py37-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.7.22,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.6,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.5.1,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.4,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='93055344'
py37-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector_role/.tox/py37-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py37-ansible30 create: /opt/vector_role/.tox/py37-ansible30
py37-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py37-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.7.22,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.6,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.5.1,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.4,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='93055344'
py37-ansible30 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector_role/.tox/py37-ansible30/bin/molecule test -s compatibility --destroy always (exited with code 1)
py39-ansible210 create: /opt/vector_role/.tox/py39-ansible210
py39-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py39-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==4.1.5,ansible-core==2.15.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.7.22,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.6,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jmespath==1.0.1,jsonschema==4.18.4,jsonschema-specifications==2023.7.1,lxml==4.9.3,markdown-it-py==3.0.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==2.0.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,referencing==0.30.0,requests==2.31.0,resolvelib==1.0.1,rich==13.5.1,rpds-py==0.9.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.4,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible210 run-test-pre: PYTHONHASHSEED='93055344'
py39-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector_role/.tox/py39-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py39-ansible30 create: /opt/vector_role/.tox/py39-ansible30
py39-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py39-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==4.1.5,ansible-core==2.15.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.7.22,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.6,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jmespath==1.0.1,jsonschema==4.18.4,jsonschema-specifications==2023.7.1,lxml==4.9.3,markdown-it-py==3.0.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==2.0.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,referencing==0.30.0,requests==2.31.0,resolvelib==1.0.1,rich==13.5.1,rpds-py==0.9.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.4,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible30 run-test-pre: PYTHONHASHSEED='93055344'
py39-ansible30 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector_role/.tox/py39-ansible30/bin/molecule test -s compatibility --destroy always (exited with code 1)
_________________________________________________________________________ summary __________________________________________________________________________
ERROR:   py37-ansible210: commands failed
ERROR:   py37-ansible30: commands failed
ERROR:   py39-ansible210: commands failed
ERROR:   py39-ansible30: commands failed
[root@0583c528e8be vector_role]#
```

</details>

>6. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.

Создал новый облегченный сценарий для podman 
```shell
---
dependency:
  name: galaxy
driver:
  name: podman
platforms:
  - name: centos_8
    image: docker.io/pycontribs/centos:8
    pre_build_image: true
    volumes:
      - "$MOLECULE_PROJECT_DIRECTORY/systemctl3.py:/usr/bin/systemctl"
    privileged: true
  - name: ubuntu_latest
    image: docker.io/pycontribs/ubuntu:latest
    volumes:
      - "$MOLECULE_PROJECT_DIRECTORY/systemctl3.py:/usr/bin/systemctl"
    pre_build_image: true
    privileged: true
provisioner:
  name: ansible
verifier:
  name: ansible
scenario:
  test_sequence:
  - destroy
  - create
  - converge
  - verify
  - destroy
```

>8. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.

<p align="center">
  <img  src=".//scr/1.jpg">
</p>

>8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.

<details>
  <summary>Вывод tox с новым tox.ini и сценарием podman в контейнере</summary>

```shell
[root@5c7abcbdfdb4 vector_role]# tox -rv
using tox.ini: /opt/vector_role/tox.ini (pid 23)
using tox-3.25.0 from /usr/local/lib/python3.6/site-packages/tox/__init__.py (pid 23)
py37-ansible210 cannot reuse: -r flag
py37-ansible210 recreate: /opt/vector_role/.tox/py37-ansible210
[30] /opt/vector_role/.tox$ /usr/bin/python3 -m virtualenv --no-download --python /usr/local/bin/python3.7 py37-ansible210 >py37-ansible210/log/py37-ansible210-0.log
py37-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
[44] /opt/vector_role$ /opt/vector_role/.tox/py37-ansible210/bin/python -m pip install -rtox-requirements.txt 'ansible<3.0' >.tox/py37-ansible210/log/py37-ansible210-1.log
write config to /opt/vector_role/.tox/py37-ansible210/.tox-config1 as '5936a1b960028407ab91e134153aed45ae70704a5c83c41d313f9c647b198b88 /usr/local/bin/python3.7\n3.25.0 0 0 0\n00000000000000000000000000000000 -rtox-requirements.txt\n00000000000000000000000000000000 ansible<3.0'
[139] /opt/vector_role$ /opt/vector_role/.tox/py37-ansible210/bin/python -m pip freeze >.tox/py37-ansible210/log/py37-ansible210-2.log
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.7.22,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.6,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,rich==13.5.1,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.4,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='4053314110'
py37-ansible210 run-test: commands[0] | molecule test -s podman --destroy always
[142] /opt/vector_role$ /opt/vector_role/.tox/py37-ansible210/bin/molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/76a2e5/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/76a2e5/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/76a2e5/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})
changed: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '495151389382.179', 'results_file': '/root/.ansible_async/495151389382.179', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '243287525189.199', 'results_file': '/root/.ansible_async/243287525189.199', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="centos_8 registry username: None specified")
skipping: [localhost] => (item="ubuntu_latest registry username: None specified")

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/centos:8")
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/ubuntu:latest")

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=centos_8)
ok: [localhost] => (item=ubuntu_latest)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=docker.io/pycontribs/ubuntu:latest)

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="centos_8 command: None specified")
ok: [localhost] => (item="ubuntu_latest command: None specified")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=centos_8: None specified)
skipping: [localhost] => (item=ubuntu_latest: None specified)

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (299 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (298 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (297 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (296 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (295 retries left).
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running podman > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Copy something to test use of synchronize module] ************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [Include vector_role] *****************************************************

TASK [vector_role : Create directory vector] ***********************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Get vector distrib] ****************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector_role : Unarchive vector] ******************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector_role : Create a symbolic link] ************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Mkdir vector data] *****************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Vector config create] **************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector_role : Create vector unit flie] ***********************************
changed: [ubuntu_latest]
changed: [centos_8]

RUNNING HANDLER [vector_role : Restart Vector] *********************************
changed: [centos_8]
changed: [ubuntu_latest]

PLAY RECAP *********************************************************************
centos_8                   : ok=10   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=10   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Get Vector version] ******************************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [Assert Vector version] ***************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "0.29.1"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "0.29.1"
}

TASK [Validate Vector config] **************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Assert Vector config] ****************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}

TASK [Validate Vector service] *************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Assert Vector service] ***************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "Vector started and enabled"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "Vector started and enabled"
}

PLAY RECAP *********************************************************************
centos_8                   : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})
changed: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) deletion to complete (299 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '95264427212.5733', 'results_file': '/root/.ansible_async/95264427212.5733', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '496054130872.5753', 'results_file': '/root/.ansible_async/496054130872.5753', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
py37-ansible30 cannot reuse: -r flag
py37-ansible30 recreate: /opt/vector_role/.tox/py37-ansible30
[5893] /opt/vector_role/.tox$ /usr/bin/python3 -m virtualenv --no-download --python /usr/local/bin/python3.7 py37-ansible30 >py37-ansible30/log/py37-ansible30-0.log
py37-ansible30 installdeps: -rtox-requirements.txt, ansible>=2.12
[5900] /opt/vector_role$ /opt/vector_role/.tox/py37-ansible30/bin/python -m pip install -rtox-requirements.txt 'ansible>=2.12' >.tox/py37-ansible30/log/py37-ansible30-1.log
write config to /opt/vector_role/.tox/py37-ansible30/.tox-config1 as '5936a1b960028407ab91e134153aed45ae70704a5c83c41d313f9c647b198b88 /usr/local/bin/python3.7\n3.25.0 0 0 0\n00000000000000000000000000000000 -rtox-requirements.txt\n00000000000000000000000000000000 ansible>=2.12'
[5920] /opt/vector_role$ /opt/vector_role/.tox/py37-ansible30/bin/python -m pip freeze >.tox/py37-ansible30/log/py37-ansible30-2.log
py37-ansible30 installed: ansible==4.10.0,ansible-compat==1.0.0,ansible-core==2.11.12,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2023.7.22,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.6,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.7.0,Jinja2==3.1.2,jmespath==1.0.1,lxml==4.9.3,markdown-it-py==2.2.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,requests==2.31.0,resolvelib==0.5.4,rich==13.5.1,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.4,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='4053314110'
py37-ansible30 run-test: commands[0] | molecule test -s podman --destroy always
[5923] /opt/vector_role$ /opt/vector_role/.tox/py37-ansible30/bin/molecule test -s podman --destroy always
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/76a2e5/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/76a2e5/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/76a2e5/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})
changed: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '400784080677.5965', 'results_file': '/root/.ansible_async/400784080677.5965', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '371514208578.5985', 'results_file': '/root/.ansible_async/371514208578.5985', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > create
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="centos_8 registry username: None specified")
skipping: [localhost] => (item="ubuntu_latest registry username: None specified")

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/centos:8")
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/ubuntu:latest")

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=centos_8)
ok: [localhost] => (item=ubuntu_latest)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=docker.io/pycontribs/ubuntu:latest)

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="centos_8 command: None specified")
ok: [localhost] => (item="ubuntu_latest command: None specified")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=centos_8: None specified)
skipping: [localhost] => (item=ubuntu_latest: None specified)

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running podman > converge
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Copy something to test use of synchronize module] ************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [Include vector_role] *****************************************************

TASK [vector_role : Create directory vector] ***********************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Get vector distrib] ****************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Unarchive vector] ******************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector_role : Create a symbolic link] ************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Mkdir vector data] *****************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Vector config create] **************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector_role : Create vector unit flie] ***********************************
changed: [centos_8]
changed: [ubuntu_latest]

RUNNING HANDLER [vector_role : Restart Vector] *********************************
changed: [centos_8]
changed: [ubuntu_latest]

PLAY RECAP *********************************************************************
centos_8                   : ok=10   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=10   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > verify
INFO     Running Ansible Verifier
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Verify] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Get Vector version] ******************************************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [Assert Vector version] ***************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "0.29.1"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "0.29.1"
}

TASK [Validate Vector config] **************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Assert Vector config] ****************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}

TASK [Validate Vector service] *************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Assert Vector service] ***************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "Vector started and enabled"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "Vector started and enabled"
}

PLAY RECAP *********************************************************************
centos_8                   : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running podman > destroy
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.7.10 (default, Jun 13
 2022, 19:37:24) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})
changed: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) deletion to complete (299 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '789617153053.11251', 'results_file': '/root/.ansible_async/789617153053.11251', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '18154989174.11271', 'results_file': '/root/.ansible_async/18154989174.11271', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
py39-ansible210 cannot reuse: -r flag
py39-ansible210 recreate: /opt/vector_role/.tox/py39-ansible210
[11414] /opt/vector_role/.tox$ /usr/bin/python3 -m virtualenv --no-download --python /usr/local/bin/python3.9 py39-ansible210 >py39-ansible210/log/py39-ansible210-0.log
py39-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
[11428] /opt/vector_role$ /opt/vector_role/.tox/py39-ansible210/bin/python -m pip install -rtox-requirements.txt 'ansible<3.0' >.tox/py39-ansible210/log/py39-ansible210-1.log
write config to /opt/vector_role/.tox/py39-ansible210/.tox-config1 as 'b510db7918ae5db9e42709a71f141e64865d93035d115320ea8b760de8411d34 /usr/local/bin/python3.9\n3.25.0 0 0 0\n00000000000000000000000000000000 -rtox-requirements.txt\n00000000000000000000000000000000 ansible<3.0'
[11484] /opt/vector_role$ /opt/vector_role/.tox/py39-ansible210/bin/python -m pip freeze >.tox/py39-ansible210/log/py39-ansible210-2.log
py39-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==4.1.5,ansible-core==2.15.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.7.22,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.6,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jmespath==1.0.1,jsonschema==4.18.4,jsonschema-specifications==2023.7.1,lxml==4.9.3,markdown-it-py==3.0.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==2.0.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,referencing==0.30.0,requests==2.31.0,resolvelib==1.0.1,rich==13.5.1,rpds-py==0.9.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.4,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible210 run-test-pre: PYTHONHASHSEED='4053314110'
py39-ansible210 run-test: commands[0] | molecule test -s podman --destroy always
[11485] /opt/vector_role$ /opt/vector_role/.tox/py39-ansible210/bin/molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/e3fa2b/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/e3fa2b/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/e3fa2b/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'
Traceback (most recent call last):
  File "/opt/vector_role/.tox/py39-ansible210/bin/molecule", line 8, in <module>
    sys.exit(main())
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1157, in __call__
    return self.main(*args, **kwargs)
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1078, in main
    rv = self.invoke(ctx)
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1688, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1434, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 783, in invoke
    return __callback(*args, **kwargs)
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/click/decorators.py", line 33, in new_func
    return f(get_current_context(), *args, **kwargs)
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/test.py", line 159, in test
    base.execute_cmdline_scenarios(scenario_name, args, command_args, ansible_args)
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 118, in execute_cmdline_scenarios
    execute_scenario(scenario)
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 160, in execute_scenario
    execute_subcommand(scenario.config, action)
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 149, in execute_subcommand
    return command(config).execute()
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/logger.py", line 188, in wrapper
    rt = func(*args, **kwargs)
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/destroy.py", line 107, in execute
    self._config.provisioner.destroy()
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/provisioner/ansible.py", line 705, in destroy
    pb.execute()
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/provisioner/ansible_playbook.py", line 110, in execute
    self._config.driver.sanity_checks()
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule_podman/driver.py", line 224, in sanity_checks
    if runtime.version < Version("2.10.0"):
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible_compat/runtime.py", line 375, in version
    self._version = parse_ansible_version(proc.stdout)
  File "/opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible_compat/config.py", line 42, in parse_ansible_version
    raise InvalidPrerequisiteError(msg)
ansible_compat.errors.InvalidPrerequisiteError: Unable to parse ansible cli version: ansible 2.10.17
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /opt/vector_role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible
  executable location = /opt/vector_role/.tox/py39-ansible210/bin/ansible
  python version = 3.9.2 (default, Jun 13 2022, 19:42:33) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]

Keep in mind that only 2.12 or newer are supported.
ERROR: InvocationError for command /opt/vector_role/.tox/py39-ansible210/bin/molecule test -s podman --destroy always (exited with code 1)
py39-ansible30 cannot reuse: -r flag
py39-ansible30 recreate: /opt/vector_role/.tox/py39-ansible30
[11489] /opt/vector_role/.tox$ /usr/bin/python3 -m virtualenv --no-download --python /usr/local/bin/python3.9 py39-ansible30 >py39-ansible30/log/py39-ansible30-0.log
py39-ansible30 installdeps: -rtox-requirements.txt, ansible>=2.12
[11496] /opt/vector_role$ /opt/vector_role/.tox/py39-ansible30/bin/python -m pip install -rtox-requirements.txt 'ansible>=2.12' >.tox/py39-ansible30/log/py39-ansible30-1.log
write config to /opt/vector_role/.tox/py39-ansible30/.tox-config1 as 'b510db7918ae5db9e42709a71f141e64865d93035d115320ea8b760de8411d34 /usr/local/bin/python3.9\n3.25.0 0 0 0\n00000000000000000000000000000000 -rtox-requirements.txt\n00000000000000000000000000000000 ansible>=2.12'
[11501] /opt/vector_role$ /opt/vector_role/.tox/py39-ansible30/bin/python -m pip freeze >.tox/py39-ansible30/log/py39-ansible30-2.log
py39-ansible30 installed: ansible==8.2.0,ansible-compat==4.1.5,ansible-core==2.15.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==23.1.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2023.7.22,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.2.0,click==8.1.6,click-help-colors==0.9.1,cookiecutter==2.2.3,cryptography==41.0.2,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-resources==5.0.7,Jinja2==3.1.2,jmespath==1.0.1,jsonschema==4.18.4,jsonschema-specifications==2023.7.1,lxml==4.9.3,markdown-it-py==3.0.0,MarkupSafe==2.1.3,mdurl==0.1.2,molecule==3.5.2,molecule-podman==2.0.0,packaging==23.1,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.15.1,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.1,PyYAML==5.4.1,referencing==0.30.0,requests==2.31.0,resolvelib==1.0.1,rich==13.5.1,rpds-py==0.9.2,ruamel.yaml==0.17.32,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.2,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.4,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible30 run-test-pre: PYTHONHASHSEED='4053314110'
py39-ansible30 run-test: commands[0] | molecule test -s podman --destroy always
[11502] /opt/vector_role$ /opt/vector_role/.tox/py39-ansible30/bin/molecule test -s podman --destroy always
INFO     podman scenario test matrix: destroy, create, converge, verify, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/root/.cache/ansible-compat/e3fa2b/modules:/root/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/root/.cache/ansible-compat/e3fa2b/collections:/root/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/root/.cache/ansible-compat/e3fa2b/roles:/root/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})
changed: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j546562096206.11527', 'results_file': '/root/.ansible_async/j546562096206.11527', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j100009725643.11546', 'results_file': '/root/.ansible_async/j100009725643.11546', 'changed': True, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="centos_8 registry username: None specified")
skipping: [localhost] => (item="ubuntu_latest registry username: None specified")
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/centos:8")
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/ubuntu:latest")
skipping: [localhost]

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=centos_8)
ok: [localhost] => (item=ubuntu_latest)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=docker.io/pycontribs/ubuntu:latest)
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="centos_8 command: None specified")
ok: [localhost] => (item="ubuntu_latest command: None specified")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=centos_8: None specified)
skipping: [localhost] => (item=ubuntu_latest: None specified)
skipping: [localhost]

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running podman > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [Copy something to test use of synchronize module] ************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [Include vector_role] *****************************************************

TASK [vector_role : Create directory vector] ***********************************
changed: [centos_8]
changed: [ubuntu_latest]

TASK [vector_role : Get vector distrib] ****************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Unarchive vector] ******************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Create a symbolic link] ************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Mkdir vector data] *****************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Vector config create] **************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [vector_role : Create vector unit flie] ***********************************
changed: [ubuntu_latest]
changed: [centos_8]

RUNNING HANDLER [vector_role : Restart Vector] *********************************
changed: [centos_8]
changed: [ubuntu_latest]

PLAY RECAP *********************************************************************
centos_8                   : ok=10   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=10   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running podman > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [Get Vector version] ******************************************************
changed: [ubuntu_latest]
changed: [centos_8]

TASK [Assert Vector version] ***************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "0.29.1"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "0.29.1"
}

TASK [Validate Vector config] **************************************************
ok: [centos_8]
ok: [ubuntu_latest]

TASK [Assert Vector config] ****************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
}

TASK [Validate Vector service] *************************************************
ok: [ubuntu_latest]
ok: [centos_8]

TASK [Assert Vector service] ***************************************************
ok: [centos_8] => {
    "changed": false,
    "msg": "Vector started and enabled"
}
ok: [ubuntu_latest] => {
    "changed": false,
    "msg": "Vector started and enabled"
}

PLAY RECAP *********************************************************************
centos_8                   : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})
changed: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (299 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j696693733708.16791', 'results_file': '/root/.ansible_async/j696693733708.16791', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j603301611841.16809', 'results_file': '/root/.ansible_async/j603301611841.16809', 'changed': True, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'privileged': True, 'volumes': ['/opt/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
_________________________________________________________________________ summary __________________________________________________________________________
  py37-ansible210: commands succeeded
  py37-ansible30: commands succeeded
ERROR:   py39-ansible210: commands failed
  py39-ansible30: commands succeeded
```

</details>

>10. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

Новый тег: [1.2.0](https://github.com/ercuru/vector_role/tree/1.2.0)
