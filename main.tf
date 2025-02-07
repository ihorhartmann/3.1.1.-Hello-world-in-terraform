module "terraform_hw" {
  source         = "./modules/terraform_hw"
  volume_dir     = "/tmp/terraform_hw"
  container_name = "nginx_hello_world"
  external_port  = 8080
  internal_port  = 80
}
