resource "docker_image" "backend_image" {
  name = "dzhmel/todo-app-backend:latest"
}

resource "docker_container" "backend_container" {
  name  = "backend_container"
  image = docker_image.backend_image.name

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 8080
    external = 8080
  }

  env = [
    "DB_URI=mongodb://${var.mongodb_container_name}:27017/mydb",
    "DB_NAME=mydb",
    "DB_COLLECTION_NAME=todolist"
  ]
}
