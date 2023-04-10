resource "yandex_compute_instance" "test" {
  name = "testnode"
  zone                      = "ru-central1-a"
  hostname                  = "node01.netology.cloud"
  platform_id               = "standard-v2"
  allow_stopping_for_update = true

  resources {
    cores  = 8
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8289cji0h6v14lblq9"
      name        = "root-node01"
      type        = "network-nvme"
      size        = "50"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default1.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_vpc_network" "default1" {
  name = "net1"
}

resource "yandex_vpc_subnet" "default1" {
  name = "subnet1"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default1.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}

output "internal_ip_address_test_vm" {
  value = yandex_compute_instance.test.network_interface.0.ip_address
}

output "external_ip_address_test_vm" {
  value = yandex_compute_instance.test.network_interface.0.nat_ip_address
}
