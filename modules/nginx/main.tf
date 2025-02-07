resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_container" {
  name  = "nginx_container"
  image = docker_image.nginx_image.name

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 80
    external = 8090
  }
}