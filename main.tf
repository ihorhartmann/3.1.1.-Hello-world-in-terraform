terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

module "terraform_hw" {
  source      = "./modules/terraform_hw"
  volume_dir  = var.volume_dir
  container_name = "nginx_hello_world"
  external_port = 8080
  internal_port = 80
}

variable "volume_dir" {
  type    = string
  default = "/tmp/terraform_hw"
}
