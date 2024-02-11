#!/bin/bash

set -e

function create_yc_vm {
  local NA=$1

  YC=$(cat <<END
    yc compute instance create \
      --name $NA \
      --hostname $NA \
      --zone ru-central1-b \
      --network-interface subnet-name=default-ru-central1-b,nat-ip-version=ipv4 \
      --memory 4 \
      --cores 2 \
      --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts,size=50 \
      --ssh-key /home/andrey/.ssh/id_ed25519.pub
END
  )

  eval "$YC"
}

create_yc_vm "kubmaster"
create_yc_vm "kubworker1"
create_yc_vm "kubworker2"
create_yc_vm "kubworker3"
create_yc_vm "kubworker4"

yc compute instance list
