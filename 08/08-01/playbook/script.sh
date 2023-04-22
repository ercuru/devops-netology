#! /usr/bin/bash
docker run --name centos7 -d pycontribs/centos:7 sleep 36000000 && docker run --name ubuntu -d pycontribs/ubuntu sleep 65000000 && docker run --name fedora -d pycontribs/fedora sleep 36000000
ansible-playbook -i inventory/prod.yml site.yml --vault-password-file vault_pass.txt
docker stop $(docker ps -q) && docker container prune -f
