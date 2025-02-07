resource "docker_volume" "mongodb_volume" {
  name = "mongodb_volume"
}

resource "docker_image" "mongodb_image" {
  name = "mongo:latest"
}

resource "docker_container" "mongodb_container" {
  name  = "mongodb_container"
  image = docker_image.mongodb_image.name

  networks_advanced {
    name = var.network_name
  }

  volumes {
    container_path = "/data/db"
    host_path      = docker_volume.mongodb_volume.mountpoint
  }
}
