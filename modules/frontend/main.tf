resource "docker_image" "frontend_image" {
  name = "dzhmel/todo-app-frontend:latest"
}

resource "docker_container" "frontend_container" {
  name  = "frontend_container"
  image = docker_image.frontend_image.name

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 80
    external = 3000
  }
}
