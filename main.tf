module "todo_app_network" {
  source = "./modules/todo_app_network"
}

module "backend" {
  source       = "./modules/backend"
  network_name = module.todo_app_network.network_name
  depends_on   = [module.todo_app_network, module.mongodb]
}

module "frontend" {
  source       = "./modules/frontend"
  network_name = module.todo_app_network.network_name
  depends_on   = [module.todo_app_network, module.backend]
}

module "mongodb" {
  source       = "./modules/mongodb"
  network_name = module.todo_app_network.network_name
  depends_on   = [module.todo_app_network]
}

module "nginx" {
  source       = "./modules/nginx"
  network_name = module.todo_app_network.network_name
  depends_on   = [module.todo_app_network, module.backend, module.frontend]
}