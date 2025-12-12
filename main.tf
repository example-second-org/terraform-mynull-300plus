terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
    null = {
      source  = "hashicorp/null"
    }
  }
}

variable "mycount" {
  default = 7
}

resource "random_pet" "pet1" {
  prefix = timestamp()
  length = 3
}

output "pet1" {
  value = random_pet.pet1.*.id
}

resource "null_resource" "null1" {
  count = var.mycount
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "echo ${random_pet.pet1.id}"
  }
}

output "null1" {
  value = null_resource.null1.*.id
}

resource "null_resource" "null2" {
  count = var.mycount
  triggers = {
    always_run = timestamp()
  }
}

output "null2" {
  value = null_resource.null2.*.id
}

resource "random_pet" "pet2" {
  count  = var.mycount
  prefix = timestamp()
}

output "version" {
  value = 1
}
