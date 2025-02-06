module "todo_app_network" {
  source = "./modules/todo_app_network"
}

module "backend" {
  source                 = "./modules/backend"
  network_name           = module.todo_app_network.network_name
  mongodb_container_name = module.mongodb.mongodb_container_name
}

module "frontend" {
  source       = "./modules/frontend"
  network_name = module.todo_app_network.network_name
}

module "mongodb" {
  source       = "./modules/mongodb"
  network_name = module.todo_app_network.network_name
}

module "nginx" {
  source       = "./modules/nginx"
  network_name = module.todo_app_network.network_name
}