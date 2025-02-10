resource "docker_network" "todo_app_network" {
  name   = "todo_app_network"
  driver = "bridge"
}
