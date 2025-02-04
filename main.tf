terraform {
  required_version = ">= 1.10.5"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

module "terraform_hw" {
  source         = "./modules/terraform_hw"
  volume_dir     = "/tmp/terraform_hw"
  container_name = "nginx_hello_world"
  external_port  = 8080
  internal_port  = 80
}
