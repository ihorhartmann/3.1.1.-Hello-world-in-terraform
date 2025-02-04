terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

variable "volume_dir" {
  type = string
}

variable "container_name" {
  type = string
}

variable "external_port" {
  type = number
}

variable "internal_port" {
  type = number
}

resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

resource "null_resource" "create_volume_dir" {
  provisioner "local-exec" {
    command = "mkdir -p ${var.volume_dir}/html"
  }
}

resource "local_file" "index_html" {
  filename   = "${var.volume_dir}/html/index.html"
  content    = "<html><body><h1>Hello, World!</h1></body></html>"
  depends_on = [null_resource.create_volume_dir]
}

resource "docker_container" "nginx_hello_world" {
  name       = var.container_name
  image      = docker_image.nginx_image.name
  depends_on = [local_file.index_html]

  ports {
    internal = var.internal_port
    external = var.external_port
  }

  volumes {
    host_path      = "${var.volume_dir}/html"
    container_path = "/usr/share/nginx/html"
  }
}
