terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "${var.yc_token}"
  cloud_id  = "${var.yc_cloud_id}"
  folder_id = "b1gho6h703nrdkpr2j6r"
  zone      = "ru-central1-a"
}

variable "yc_token" {
  type = string
}

variable "yc_cloud_id" {
  type = string
}
