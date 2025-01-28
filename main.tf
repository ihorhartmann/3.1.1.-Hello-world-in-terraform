terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

variable "volume_dir" {
  type    = string
  default = "/home/ubuntu/terraform_hw"
}

resource "docker_container" "nginx_hello_world" {
  name  = "nginx_hello_world"
  image = docker_image.nginx_image.name
  depends_on = [local_file.index_html]

  ports {
    internal = 80
    external = 8080
  }

  volumes {
    host_path      = "${var.volume_dir}/html"
    container_path = "/usr/share/nginx/html"
  }
}

# html folder creation
resource "null_resource" "create_volume_dir" {
  provisioner "local-exec" {
    command = "mkdir -p ${var.volume_dir}/html"
  }
}

# html page creation
resource "local_file" "index_html" {
  filename = "${var.volume_dir}/html/index.html"
  content  = "<html><body><h1>Hello, World!</h1></body></html>"
  depends_on = [null_resource.create_volume_dir]
}
