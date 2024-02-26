resource "yandex_compute_instance" "instance_nat-vm" {
  count       = var.instance_count
  folder_id   = var.folder_id
  platform_id = var.instance_type
  name        = "${var.instance_name}-nat"
  hostname    = "${var.instance_name}-nat.${var.domain}"
  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id = "fd883hg3q7olkoc30kav" #https://cloud.yandex.ru/ru/marketplace/products/yc/nat-instance-ubuntu-18-04-lts
      type     = var.boot_disk
      size     = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.vpc-public.id
    nat       = true
    ip_address = var.instance-nat-ip
  }

    metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("~/.ssh/id_ed25519.pub")}"
  }
    scheduling_policy {
    preemptible = true
  }

  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "public-vm" {
  count       = var.instance_count
  folder_id   = var.folder_id
  platform_id = var.instance_type
  name        = "${var.instance_name}-public"
  hostname    = "${var.instance_name}-public.${var.domain}"
  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = var.boot_disk
      size     = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.vpc-public.id
    nat       = true
  }

    metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("~/.ssh/id_ed25519.pub")}"
  }
    scheduling_policy {
    preemptible = true
  }
  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "private-vm" {
  count       = var.instance_count
  folder_id   = var.folder_id
  platform_id = var.instance_type
  name        = "${var.instance_name}-private"
  hostname    = "${var.instance_name}-private.${var.domain}"
  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = var.boot_disk
      size     = var.disk_size
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.vpc-private.id
  }

    metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("~/.ssh/id_ed25519.pub")}"
  }
    scheduling_policy {
    preemptible = true
  }
  allow_stopping_for_update = true
}