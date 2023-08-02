# Домашнее задание к занятию 10 «Jenkins»


<details>
  <summary>Подготовка к выполнению</summary>

>1. Создать два VM: для jenkins-master и jenkins-agent.
>2. Установить Jenkins при помощи playbook.
>3. Запустить и проверить работоспособность.
>4. Сделать первоначальную настройку.

</details>



## Основная часть

>1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

Долго подбирались версии пакетов для избавления от ошибок о не стыковки версий. Но в итоге собрался фулл хаус

- Git репозиторий: https://github.com/ercuru/vector_role.git
- ветка: new_main
- Включены настройки 'Delete workspace before build starts' и 'Add timestamps to the Console Output'

```shell
pip3 install --user "ansible-lint" "ansible-core" "yamllint" "molecule==3.5.2" "molecule-docker==1.1.0" 
pip3 install --user "cryptography==36.0.0" "requests==2.23.0"
ansible-galaxy collection install community.docker
molecule --version
chmod -R 755 systemctl3.py
molecule test
```

<p align="center">
  <img  src=".//scr/1.jpg">
</p>

<details>
  <summary>Вывод Console Output</summary>

```shell
22:12:00 Started by user admin
22:12:00 Running as SYSTEM
22:12:00 Building remotely on agent-01 (linux ansible) in workspace /opt/jenkins_agent/workspace/vector_role
22:12:00 [WS-CLEANUP] Deleting project workspace...
22:12:00 [WS-CLEANUP] Deferred wipeout is used...
22:12:00 [WS-CLEANUP] Done
22:12:00 The recommended git tool is: NONE
22:12:00 using credential 2d710b85-07f5-4d07-a378-5979377da219
22:12:00 Cloning the remote Git repository
22:12:00 Cloning repository https://github.com/ercuru/vector_role.git
22:12:00  > git init /opt/jenkins_agent/workspace/vector_role # timeout=10
22:12:00 Fetching upstream changes from https://github.com/ercuru/vector_role.git
22:12:00  > git --version # timeout=10
22:12:00  > git --version # 'git version 1.8.3.1'
22:12:00 using GIT_SSH to set credentials 
22:12:00 [INFO] Currently running in a labeled security context
22:12:00 [INFO] Currently SELinux is 'enforcing' on the host
22:12:00  > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/vector_role@tmp/jenkins-gitclient-ssh3330707858936314956.key
22:12:00  > git fetch --tags --progress https://github.com/ercuru/vector_role.git +refs/heads/*:refs/remotes/origin/* # timeout=10
22:12:01  > git config remote.origin.url https://github.com/ercuru/vector_role.git # timeout=10
22:12:01  > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
22:12:01 Avoid second fetch
22:12:01  > git rev-parse refs/remotes/origin/new_main^{commit} # timeout=10
22:12:01 Checking out Revision 72bfe626afcfafef0e50cfe39f605cc2cfea1a62 (refs/remotes/origin/new_main)
22:12:01  > git config core.sparsecheckout # timeout=10
22:12:01  > git checkout -f 72bfe626afcfafef0e50cfe39f605cc2cfea1a62 # timeout=10
22:12:01 Commit message: "add podman test for tox"
22:12:01  > git rev-list --no-walk 72bfe626afcfafef0e50cfe39f605cc2cfea1a62 # timeout=10
22:12:01 [vector_role] $ /bin/sh -xe /tmp/jenkins2939543587799360112.sh
22:12:01 + pip3 install --user ansible-lint ansible-core yamllint molecule==3.5.2 molecule-docker==1.1.0
22:12:01 Requirement already satisfied: ansible-lint in /home/jenkins/.local/lib/python3.6/site-packages (5.4.0)
22:12:01 Requirement already satisfied: ansible-core in /home/jenkins/.local/lib/python3.6/site-packages (2.11.12)
22:12:01 Requirement already satisfied: yamllint in /home/jenkins/.local/lib/python3.6/site-packages (1.28.0)
22:12:01 Requirement already satisfied: molecule==3.5.2 in /home/jenkins/.local/lib/python3.6/site-packages (3.5.2)
22:12:01 Requirement already satisfied: molecule-docker==1.1.0 in /home/jenkins/.local/lib/python3.6/site-packages (1.1.0)
22:12:01 Requirement already satisfied: click-help-colors>=0.9 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (0.9.1)
22:12:01 Requirement already satisfied: click<9,>=8.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (8.0.4)
22:12:01 Requirement already satisfied: PyYAML<6,>=5.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (5.4.1)
22:12:01 Requirement already satisfied: rich>=9.5.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (12.6.0)
22:12:01 Requirement already satisfied: cerberus!=1.3.3,!=1.3.4,>=1.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (1.3.2)
22:12:01 Requirement already satisfied: ansible-compat>=0.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (1.0.0)
22:12:01 Requirement already satisfied: paramiko<3,>=2.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (2.12.0)
22:12:01 Requirement already satisfied: selinux in /usr/local/lib/python3.6/site-packages (from molecule==3.5.2) (0.2.1)
22:12:01 Requirement already satisfied: importlib-metadata in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (4.8.3)
22:12:01 Requirement already satisfied: enrich>=1.2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (1.2.7)
22:12:01 Requirement already satisfied: subprocess-tee>=0.3.5 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (0.3.5)
22:12:01 Requirement already satisfied: packaging in /usr/local/lib/python3.6/site-packages (from molecule==3.5.2) (21.3)
22:12:01 Requirement already satisfied: Jinja2>=2.11.3 in /usr/local/lib/python3.6/site-packages (from molecule==3.5.2) (3.0.3)
22:12:01 Requirement already satisfied: pluggy<2.0,>=0.7.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (1.0.0)
22:12:01 Requirement already satisfied: cookiecutter>=1.7.3 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (1.7.3)
22:12:01 Requirement already satisfied: dataclasses in /home/jenkins/.local/lib/python3.6/site-packages (from molecule==3.5.2) (0.8)
22:12:01 Requirement already satisfied: requests in /home/jenkins/.local/lib/python3.6/site-packages (from molecule-docker==1.1.0) (2.23.0)
22:12:01 Requirement already satisfied: docker>=4.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule-docker==1.1.0) (5.0.3)
22:12:01 Requirement already satisfied: tenacity in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-lint) (8.2.2)
22:12:01 Requirement already satisfied: typing-extensions in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-lint) (4.1.1)
22:12:01 Requirement already satisfied: ruamel.yaml<1,>=0.15.34 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-lint) (0.17.32)
22:12:01 Requirement already satisfied: wcmatch>=7.0 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-lint) (8.3)
22:12:01 Requirement already satisfied: cryptography in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-core) (36.0.0)
22:12:01 Requirement already satisfied: resolvelib<0.6.0,>=0.5.3 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-core) (0.5.4)
22:12:01 Requirement already satisfied: pathspec>=0.5.3 in /home/jenkins/.local/lib/python3.6/site-packages (from yamllint) (0.9.0)
22:12:01 Requirement already satisfied: setuptools in /usr/local/lib/python3.6/site-packages (from yamllint) (59.6.0)
22:12:01 Requirement already satisfied: cached-property~=1.5 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-compat>=0.5.0->molecule==3.5.2) (1.5.2)
22:12:01 Requirement already satisfied: poyo>=0.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule==3.5.2) (0.5.0)
22:12:01 Requirement already satisfied: python-slugify>=4.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule==3.5.2) (6.1.2)
22:12:01 Requirement already satisfied: jinja2-time>=0.2.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule==3.5.2) (0.2.0)
22:12:01 Requirement already satisfied: binaryornot>=0.4.4 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule==3.5.2) (0.4.4)
22:12:01 Requirement already satisfied: six>=1.10 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule==3.5.2) (1.16.0)
22:12:01 Requirement already satisfied: websocket-client>=0.32.0 in /home/jenkins/.local/lib/python3.6/site-packages (from docker>=4.3.1->molecule-docker==1.1.0) (1.3.1)
22:12:02 Requirement already satisfied: MarkupSafe>=2.0 in /usr/local/lib64/python3.6/site-packages (from Jinja2>=2.11.3->molecule==3.5.2) (2.0.1)
22:12:02 Requirement already satisfied: pynacl>=1.0.1 in /home/jenkins/.local/lib/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule==3.5.2) (1.5.0)
22:12:02 Requirement already satisfied: bcrypt>=3.1.3 in /home/jenkins/.local/lib/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule==3.5.2) (4.0.1)
22:12:02 Requirement already satisfied: cffi>=1.12 in /usr/local/lib64/python3.6/site-packages (from cryptography->ansible-core) (1.15.1)
22:12:02 Requirement already satisfied: zipp>=0.5 in /home/jenkins/.local/lib/python3.6/site-packages (from importlib-metadata->molecule==3.5.2) (3.6.0)
22:12:02 Requirement already satisfied: chardet<4,>=3.0.2 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker==1.1.0) (3.0.4)
22:12:02 Requirement already satisfied: urllib3!=1.25.0,!=1.25.1,<1.26,>=1.21.1 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker==1.1.0) (1.24.3)
22:12:02 Requirement already satisfied: certifi>=2017.4.17 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker==1.1.0) (2023.7.22)
22:12:02 Requirement already satisfied: idna<3,>=2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker==1.1.0) (2.7)
22:12:02 Requirement already satisfied: commonmark<0.10.0,>=0.9.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->molecule==3.5.2) (0.9.1)
22:12:02 Requirement already satisfied: pygments<3.0.0,>=2.6.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->molecule==3.5.2) (2.14.0)
22:12:02 Requirement already satisfied: ruamel.yaml.clib>=0.2.7 in /home/jenkins/.local/lib/python3.6/site-packages (from ruamel.yaml<1,>=0.15.34->ansible-lint) (0.2.7)
22:12:02 Requirement already satisfied: bracex>=2.1.1 in /home/jenkins/.local/lib/python3.6/site-packages (from wcmatch>=7.0->ansible-lint) (2.2.1)
22:12:02 Requirement already satisfied: pyparsing!=3.0.5,>=2.0.2 in /usr/local/lib/python3.6/site-packages (from packaging->molecule==3.5.2) (3.1.1)
22:12:02 Requirement already satisfied: distro>=1.3.0 in /usr/local/lib/python3.6/site-packages (from selinux->molecule==3.5.2) (1.8.0)
22:12:02 Requirement already satisfied: pycparser in /usr/local/lib/python3.6/site-packages (from cffi>=1.12->cryptography->ansible-core) (2.21)
22:12:02 Requirement already satisfied: arrow in /home/jenkins/.local/lib/python3.6/site-packages (from jinja2-time>=0.2.0->cookiecutter>=1.7.3->molecule==3.5.2) (1.2.3)
22:12:02 Requirement already satisfied: text-unidecode>=1.3 in /home/jenkins/.local/lib/python3.6/site-packages (from python-slugify>=4.0.0->cookiecutter>=1.7.3->molecule==3.5.2) (1.3)
22:12:02 Requirement already satisfied: python-dateutil>=2.7.0 in /home/jenkins/.local/lib/python3.6/site-packages (from arrow->jinja2-time>=0.2.0->cookiecutter>=1.7.3->molecule==3.5.2) (2.8.2)
22:12:02 + pip3 install --user cryptography==36.0.0 requests==2.23.0
22:12:02 Requirement already satisfied: cryptography==36.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (36.0.0)
22:12:02 Requirement already satisfied: requests==2.23.0 in /home/jenkins/.local/lib/python3.6/site-packages (2.23.0)
22:12:02 Requirement already satisfied: cffi>=1.12 in /usr/local/lib64/python3.6/site-packages (from cryptography==36.0.0) (1.15.1)
22:12:03 Requirement already satisfied: certifi>=2017.4.17 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (2023.7.22)
22:12:03 Requirement already satisfied: idna<3,>=2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (2.7)
22:12:03 Requirement already satisfied: chardet<4,>=3.0.2 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (3.0.4)
22:12:03 Requirement already satisfied: urllib3!=1.25.0,!=1.25.1,<1.26,>=1.21.1 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (1.24.3)
22:12:03 Requirement already satisfied: pycparser in /usr/local/lib/python3.6/site-packages (from cffi>=1.12->cryptography==36.0.0) (2.21)
22:12:03 + ansible-galaxy collection install community.docker
22:12:03 [DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
22:12:03 controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20 
22:12:03 2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be 
22:12:03 removed from ansible-core in version 2.12. Deprecation warnings can be disabled
22:12:03  by setting deprecation_warnings=False in ansible.cfg.
22:12:04 Starting galaxy collection install process
22:12:04 Nothing to do. All requested collections are already installed. If you want to reinstall them, consider using `--force`.
22:12:04 + molecule --version
22:12:04 [DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
22:12:04 controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20 
22:12:04 2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be 
22:12:04 removed from ansible-core in version 2.12. Deprecation warnings can be disabled
22:12:04  by setting deprecation_warnings=False in ansible.cfg.
22:12:06 molecule 3.5.2 using python 3.6 
22:12:06     ansible:2.11.12
22:12:06     delegated:3.5.2 from molecule
22:12:06     docker:1.1.0 from molecule_docker requiring collections: community.docker>=1.9.1
22:12:06 + chmod -R 755 systemctl3.py
22:12:06 + molecule test
22:12:06 [DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
22:12:06 controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20 
22:12:06 2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be 
22:12:06 removed from ansible-core in version 2.12. Deprecation warnings can be disabled
22:12:06  by setting deprecation_warnings=False in ansible.cfg.
22:12:07 INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
22:12:07 INFO     Performing prerun...
22:12:07 INFO     Set ANSIBLE_LIBRARY=/home/jenkins/.cache/ansible-compat/7f76bb/modules:/home/jenkins/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
22:12:08 INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/jenkins/.cache/ansible-compat/7f76bb/collections:/home/jenkins/.ansible/collections:/usr/share/ansible/collections
22:12:08 INFO     Set ANSIBLE_ROLES_PATH=/home/jenkins/.cache/ansible-compat/7f76bb/roles:/home/jenkins/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
22:12:08 INFO     Running default > dependency
22:12:08 WARNING  Skipping, missing the requirements file.
22:12:08 WARNING  Skipping, missing the requirements file.
22:12:08 INFO     Running default > lint
22:12:08 INFO     Lint is disabled.
22:12:08 INFO     Running default > cleanup
22:12:08 WARNING  Skipping, cleanup playbook not configured.
22:12:08 INFO     Running default > destroy
22:12:08 INFO     Sanity checks: 'docker'
22:12:08 [DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
22:12:08 controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
22:12:08 2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
22:12:08 removed from ansible-core in version 2.12. Deprecation warnings can be disabled
22:12:08  by setting deprecation_warnings=False in ansible.cfg.
22:12:08 
22:12:08 PLAY [Destroy] *****************************************************************
22:12:08 
22:12:08 TASK [Destroy molecule instance(s)] ********************************************
22:12:09 changed: [localhost] => (item=centos_8)
22:12:10 changed: [localhost] => (item=ubuntu_latest)
22:12:10 
22:12:10 TASK [Wait for instance(s) deletion to complete] *******************************
22:12:10 ok: [localhost] => (item=centos_8)
22:12:10 ok: [localhost] => (item=ubuntu_latest)
22:12:10 
22:12:10 TASK [Delete docker networks(s)] ***********************************************
22:12:10 
22:12:10 PLAY RECAP *********************************************************************
22:12:10 localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
22:12:10 
22:12:10 INFO     Running default > syntax
22:12:11 [DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
22:12:11 controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
22:12:11 2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
22:12:11 removed from ansible-core in version 2.12. Deprecation warnings can be disabled
22:12:11  by setting deprecation_warnings=False in ansible.cfg.
22:12:11 
22:12:11 playbook: /opt/jenkins_agent/workspace/vector_role/molecule/default/converge.yml
22:12:11 INFO     Running default > create
22:12:11 [DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
22:12:11 controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
22:12:11 2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
22:12:11 removed from ansible-core in version 2.12. Deprecation warnings can be disabled
22:12:11  by setting deprecation_warnings=False in ansible.cfg.
22:12:12 
22:12:12 PLAY [Create] ******************************************************************
22:12:12 
22:12:12 TASK [Log into a Docker registry] **********************************************
22:12:12 skipping: [localhost] => (item=None)
22:12:12 skipping: [localhost] => (item=None)
22:12:12 skipping: [localhost]
22:12:12 
22:12:12 TASK [Check presence of custom Dockerfiles] ************************************
22:12:13 ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})
22:12:13 ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})
22:12:13 
22:12:13 TASK [Create Dockerfiles from image names] *************************************
22:12:13 skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})
22:12:13 skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})
22:12:13 
22:12:13 TASK [Discover local Docker images] ********************************************
22:12:14 ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})
22:12:14 ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item', 'i': 1, 'ansible_index_var': 'i'})
22:12:14 
22:12:14 TASK [Build an Ansible compatible image (new)] *********************************
22:12:14 skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8)
22:12:14 skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest)
22:12:14 
22:12:14 TASK [Create docker network(s)] ************************************************
22:12:15 
22:12:15 TASK [Determine the CMD directives] ********************************************
22:12:15 ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})
22:12:15 ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})
22:12:15 
22:12:15 TASK [Create molecule instance(s)] *********************************************
22:12:16 changed: [localhost] => (item=centos_8)
22:12:16 changed: [localhost] => (item=ubuntu_latest)
22:12:16 
22:12:16 TASK [Wait for instance(s) creation to complete] *******************************
22:12:16 FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
22:12:22 changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '511689197562.30130', 'results_file': '/home/jenkins/.ansible_async/511689197562.30130', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
22:12:22 changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '754097439945.30156', 'results_file': '/home/jenkins/.ansible_async/754097439945.30156', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
22:12:22 
22:12:22 PLAY RECAP *********************************************************************
22:12:22 localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0
22:12:22 
22:12:22 INFO     Running default > prepare
22:12:22 WARNING  Skipping, prepare playbook not configured.
22:12:22 INFO     Running default > converge
22:12:22 [DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
22:12:22 controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
22:12:22 2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
22:12:22 removed from ansible-core in version 2.12. Deprecation warnings can be disabled
22:12:22  by setting deprecation_warnings=False in ansible.cfg.
22:12:23 
22:12:23 PLAY [Converge] ****************************************************************
22:12:23 
22:12:23 TASK [Gathering Facts] *********************************************************
22:12:24 ok: [centos_8]
22:12:24 ok: [ubuntu_latest]
22:12:24 
22:12:24 TASK [Include vector_role] *****************************************************
22:12:24 
22:12:24 TASK [vector_role : Create directory vector] ***********************************
22:12:25 changed: [ubuntu_latest]
22:12:25 changed: [centos_8]
22:12:25 
22:12:25 TASK [vector_role : Get vector distrib] ****************************************
22:12:27 changed: [centos_8]
22:12:27 changed: [ubuntu_latest]
22:12:27 
22:12:27 TASK [vector_role : Unarchive vector] ******************************************
22:12:32 changed: [centos_8]
22:12:32 changed: [ubuntu_latest]
22:12:32 
22:12:32 TASK [vector_role : Create a symbolic link] ************************************
22:12:33 changed: [ubuntu_latest]
22:12:33 changed: [centos_8]
22:12:33 
22:12:33 TASK [vector_role : Mkdir vector data] *****************************************
22:12:33 changed: [ubuntu_latest]
22:12:33 changed: [centos_8]
22:12:34 
22:12:34 TASK [vector_role : Vector config create] **************************************
22:12:35 changed: [ubuntu_latest]
22:12:35 changed: [centos_8]
22:12:35 
22:12:35 TASK [vector_role : Create vector unit flie] ***********************************
22:12:36 changed: [ubuntu_latest]
22:12:36 changed: [centos_8]
22:12:36 
22:12:36 RUNNING HANDLER [vector_role : Restart Vector] *********************************
22:12:39 changed: [ubuntu_latest]
22:12:39 changed: [centos_8]
22:12:39 
22:12:39 PLAY RECAP *********************************************************************
22:12:39 centos_8                   : ok=9    changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
22:12:39 ubuntu_latest              : ok=9    changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
22:12:39 
22:12:39 INFO     Running default > idempotence
22:12:40 [DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
22:12:40 controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
22:12:40 2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
22:12:40 removed from ansible-core in version 2.12. Deprecation warnings can be disabled
22:12:40  by setting deprecation_warnings=False in ansible.cfg.
22:12:40 
22:12:40 PLAY [Converge] ****************************************************************
22:12:40 
22:12:40 TASK [Gathering Facts] *********************************************************
22:12:42 ok: [centos_8]
22:12:42 ok: [ubuntu_latest]
22:12:42 
22:12:42 TASK [Include vector_role] *****************************************************
22:12:42 
22:12:42 TASK [vector_role : Create directory vector] ***********************************
22:12:42 ok: [ubuntu_latest]
22:12:43 ok: [centos_8]
22:12:43 
22:12:43 TASK [vector_role : Get vector distrib] ****************************************
22:12:44 ok: [ubuntu_latest]
22:12:44 ok: [centos_8]
22:12:44 
22:12:44 TASK [vector_role : Unarchive vector] ******************************************
22:12:44 skipping: [ubuntu_latest]
22:12:44 skipping: [centos_8]
22:12:44 
22:12:44 TASK [vector_role : Create a symbolic link] ************************************
22:12:45 ok: [ubuntu_latest]
22:12:45 ok: [centos_8]
22:12:45 
22:12:45 TASK [vector_role : Mkdir vector data] *****************************************
22:12:46 ok: [ubuntu_latest]
22:12:46 ok: [centos_8]
22:12:46 
22:12:46 TASK [vector_role : Vector config create] **************************************
22:12:47 ok: [ubuntu_latest]
22:12:47 ok: [centos_8]
22:12:47 
22:12:47 TASK [vector_role : Create vector unit flie] ***********************************
22:12:48 ok: [ubuntu_latest]
22:12:48 ok: [centos_8]
22:12:48 
22:12:48 PLAY RECAP *********************************************************************
22:12:48 centos_8                   : ok=7    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
22:12:48 ubuntu_latest              : ok=7    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
22:12:48 
22:12:48 INFO     Idempotence completed successfully.
22:12:48 INFO     Running default > side_effect
22:12:48 WARNING  Skipping, side effect playbook not configured.
22:12:48 INFO     Running default > verify
22:12:48 INFO     Running Ansible Verifier
22:12:48 [DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
22:12:48 controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
22:12:48 2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
22:12:48 removed from ansible-core in version 2.12. Deprecation warnings can be disabled
22:12:48  by setting deprecation_warnings=False in ansible.cfg.
22:12:49 
22:12:49 PLAY [Verify] ******************************************************************
22:12:49 
22:12:49 TASK [Gathering Facts] *********************************************************
22:12:50 ok: [centos_8]
22:12:50 ok: [ubuntu_latest]
22:12:50 
22:12:50 TASK [Get Vector version] ******************************************************
22:12:51 changed: [ubuntu_latest]
22:12:51 changed: [centos_8]
22:12:51 
22:12:51 TASK [Assert Vector version] ***************************************************
22:12:51 ok: [centos_8] => {
22:12:51     "changed": false,
22:12:51     "msg": "0.29.1"
22:12:51 }
22:12:51 ok: [ubuntu_latest] => {
22:12:51     "changed": false,
22:12:51     "msg": "0.29.1"
22:12:51 }
22:12:51 
22:12:51 TASK [Validate Vector config] **************************************************
22:12:52 ok: [ubuntu_latest]
22:12:52 ok: [centos_8]
22:12:52 
22:12:52 TASK [Assert Vector config] ****************************************************
22:12:52 ok: [centos_8] => {
22:12:52     "changed": false,
22:12:52     "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
22:12:52 }
22:12:52 ok: [ubuntu_latest] => {
22:12:52     "changed": false,
22:12:52     "msg": "√ Loaded [\"/opt/vector/config/vector.toml\"]\n-------------------------------------------\n                                  Validated"
22:12:52 }
22:12:52 
22:12:52 TASK [Validate Vector service] *************************************************
22:12:53 ok: [ubuntu_latest]
22:12:53 ok: [centos_8]
22:12:53 
22:12:53 TASK [Assert Vector service] ***************************************************
22:12:53 ok: [centos_8] => {
22:12:53     "changed": false,
22:12:53     "msg": "Vector started and enabled"
22:12:53 }
22:12:53 ok: [ubuntu_latest] => {
22:12:53     "changed": false,
22:12:53     "msg": "Vector started and enabled"
22:12:53 }
22:12:53 
22:12:53 PLAY RECAP *********************************************************************
22:12:53 centos_8                   : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
22:12:53 ubuntu_latest              : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
22:12:53 
22:12:53 INFO     Verifier completed successfully.
22:12:53 INFO     Running default > cleanup
22:12:53 WARNING  Skipping, cleanup playbook not configured.
22:12:53 INFO     Running default > destroy
22:12:53 [DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
22:12:53 controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
22:12:53 2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
22:12:53 removed from ansible-core in version 2.12. Deprecation warnings can be disabled
22:12:53  by setting deprecation_warnings=False in ansible.cfg.
22:12:54 
22:12:54 PLAY [Destroy] *****************************************************************
22:12:54 
22:12:54 TASK [Destroy molecule instance(s)] ********************************************
22:12:55 changed: [localhost] => (item=centos_8)
22:12:55 changed: [localhost] => (item=ubuntu_latest)
22:12:55 
22:12:55 TASK [Wait for instance(s) deletion to complete] *******************************
22:12:56 FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
22:13:01 changed: [localhost] => (item=centos_8)
22:13:01 changed: [localhost] => (item=ubuntu_latest)
22:13:01 
22:13:01 TASK [Delete docker networks(s)] ***********************************************
22:13:01 
22:13:01 PLAY RECAP *********************************************************************
22:13:01 localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
22:13:01 
22:13:01 INFO     Pruning extra files from scenario ephemeral directory
22:13:02 Finished: SUCCESS
```

</details>

>3. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
>3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.

Создаем Declarative Pipeline Job c настройками из `Jenkinsfile`:
```
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                dir('vector-role') {
                    git branch: 'new_main', credentialsId: '2d710b85-07f5-4d07-a378-5979377da219', url: 'https://github.com/ercuru/vector_role'
                    sh 'chmod -R 755 systemctl3.py'
                }
            }
        }
        stage('Molecule') {
            steps {
                dir('vector-role') {
                    sh 'molecule --version'
                    sh 'molecule test'
                }
            }
        }
    }
}

```

- Git репозиторий: https://github.com/ercuru/vector_role.git уже с Jenkinsfile
- ветка: new_main

<p align="center">
  <img  src=".//scr/2.jpg">
</p>

<details>
  <summary>Вывод Console Output</summary>

```shell
Started by user admin
Obtained Jenkinsfile from git https://github.com/ercuru/vector_role
[Pipeline] Start of Pipeline
[Pipeline] node
Running on agent-01 in /opt/jenkins_agent/workspace/vector_role
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential 2d710b85-07f5-4d07-a378-5979377da219
Fetching changes from the remote Git repository
Checking out Revision 5343ab869033054ddb0185dfb8c9a5c8549b80a8 (refs/remotes/origin/new_main)
Commit message: "minor changes in Jankinsfile"
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/vector_role/.git # timeout=10
 > git config remote.origin.url https://github.com/ercuru/vector_role # timeout=10
Fetching upstream changes from https://github.com/ercuru/vector_role
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
using GIT_SSH to set credentials 
[INFO] Currently running in a labeled security context
[INFO] Currently SELinux is 'enforcing' on the host
 > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/vector_role@tmp/jenkins-gitclient-ssh7387574140778430803.key
 > git fetch --tags --progress https://github.com/ercuru/vector_role +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/new_main^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 5343ab869033054ddb0185dfb8c9a5c8549b80a8 # timeout=10
 > git rev-list --no-walk a9dcb6f4e3c93cdf25533b0a408161dba48d7a2b # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential 2d710b85-07f5-4d07-a378-5979377da219
Fetching changes from the remote Git repository
Checking out Revision 5343ab869033054ddb0185dfb8c9a5c8549b80a8 (refs/remotes/origin/new_main)
Commit message: "minor changes in Jankinsfile"
[Pipeline] sh
+ chmod -R 755 systemctl3.py
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/vector_role/.git # timeout=10
 > git config remote.origin.url https://github.com/ercuru/vector_role # timeout=10
Fetching upstream changes from https://github.com/ercuru/vector_role
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
using GIT_SSH to set credentials 
[INFO] Currently running in a labeled security context
[INFO] Currently SELinux is 'enforcing' on the host
 > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/vector_role@tmp/jenkins-gitclient-ssh15674531962880217248.key
 > git fetch --tags --progress https://github.com/ercuru/vector_role +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/new_main^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 5343ab869033054ddb0185dfb8c9a5c8549b80a8 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git checkout -b new_main 5343ab869033054ddb0185dfb8c9a5c8549b80a8 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Molecule)
[Pipeline] sh
+ molecule --version
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20 
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be 
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.
molecule 3.5.2 using python 3.6 
    ansible:2.11.12
    delegated:3.5.2 from molecule
    docker:1.1.0 from molecule_docker requiring collections: community.docker>=1.9.1
[Pipeline] sh
+ molecule test
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20 
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be 
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/jenkins/.cache/ansible-compat/7f76bb/modules:/home/jenkins/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/jenkins/.cache/ansible-compat/7f76bb/collections:/home/jenkins/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/jenkins/.cache/ansible-compat/7f76bb/roles:/home/jenkins/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos_8)
ok: [localhost] => (item=ubuntu_latest)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

playbook: /opt/jenkins_agent/workspace/vector_role/molecule/default/converge.yml
INFO     Running default > create
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item', 'i': 1, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8)
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest)

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '152916765158.9286', 'results_file': '/home/jenkins/.ansible_async/152916765158.9286', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos_8', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '444831927682.9312', 'results_file': '/home/jenkins/.ansible_async/444831927682.9312', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu_latest', 'pre_build_image': True, 'volumes': ['/opt/jenkins_agent/workspace/vector_role/systemctl3.py:/usr/bin/systemctl']}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

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
changed: [ubuntu_latest]
changed: [centos_8]

PLAY RECAP *********************************************************************
centos_8                   : ok=9    changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu_latest              : ok=9    changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running default > idempotence
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos_8]
ok: [ubuntu_latest]

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
ok: [ubuntu_latest]
ok: [centos_8]

PLAY RECAP *********************************************************************
centos_8                   : ok=7    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu_latest              : ok=7    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

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
ok: [ubuntu_latest]
ok: [centos_8]

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
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos_8)
changed: [localhost] => (item=ubuntu_latest)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

```

</details>

>6. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.

<p align="center">
  <img  src=".//scr/3.jpg">
</p>

>5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
>6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
>7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.

Создается параметризированный pipeline c переменной prod_run типа Boolean

Скрипт переделан:

```shell
node("linux"){
    stage("Git clone"){
        sh '''if [ -d ./example-playbook ]; then
          rm -rf ./example-playbook 
        fi
        '''
        sh 'git clone https://github.com/aragastmatb/example-playbook'
    }
    stage("Run playbook"){
        if (params.prod_run){
            sh '''cd ./example-playbook && ansible-playbook site.yml -i inventory/prod.yml
            '''
        }
        else{
            sh '''cd ./example-playbook && ansible-playbook site.yml -i inventory/prod.yml --check --diff
            '''
        }
    }
}
```
Пояснения:
- Так как в предоставленном скрипте берется конкретный репозиторий - а у нас нет нужных данных для chekout, клонируем его.
- Выполнение данного конкретного playbook будет валится с ошибкой на внутренних тасках самого playbook - требуется доработка самим автором данного playbook.

<details>
  <summary>Вывод  Console Output</summary>

```shell
Started by user admin
[Pipeline] Start of Pipeline
[Pipeline] node
Running on agent-01 in /opt/jenkins_agent/workspace/scripted
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Git clone)
[Pipeline] sh
+ '[' -d ./example-playbook ']'
+ rm -rf ./example-playbook
[Pipeline] sh
+ git clone https://github.com/aragastmatb/example-playbook
Cloning into 'example-playbook'...
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Run playbook)
[Pipeline] sh
+ cd ./example-playbook
+ ansible-playbook site.yml -i inventory/prod.yml
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the 
controller starting with Ansible 2.12. Current version: 3.6.8 (default, Jun 20 
2023, 11:53:23) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be 
removed from ansible-core in version 2.12. Deprecation warnings can be disabled
 by setting deprecation_warnings=False in ansible.cfg.

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [java : Upload .tar.gz file containing binaries from local storage] *******
skipping: [localhost]

TASK [java : Upload .tar.gz file conaining binaries from remote storage] *******
ok: [localhost]

TASK [java : Ensure installation dir exists] ***********************************
fatal: [localhost]: FAILED! => {"changed": false, "module_stderr": "sudo: a password is required\n", "module_stdout": "", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 1}

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=1    skipped=1    rescued=0    ignored=0   

[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
ERROR: script returned exit code 2
Finished: FAILURE
```

</details>


[ScriptedJenkinsfile](https://github.com/ercuru/devops-netology/tree/main/09/09-04/ScriptedJenkinsfile)
[Jenkinsfile](https://github.com/ercuru/vector_role/blob/new_main/Jenkinsfile)





