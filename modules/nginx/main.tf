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
    external = 8080
  }

  ports {
    internal = 443
    external = 8089
  }

  volumes {
    host_path      = abspath("${path.module}/nginx.conf")
    container_path = "/etc/nginx/nginx.conf"
  }

  volumes {
    host_path      = abspath("${path.module}/nginx.crt")
    container_path = "/etc/nginx/certs/nginx.crt"
  }

  volumes {
    host_path      = abspath("${path.module}/nginx.key")
    container_path = "/etc/nginx/certs/nginx.key"
  }
}

resource "tls_private_key" "nginx_key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "nginx_cert" {
  private_key_pem = tls_private_key.nginx_key.private_key_pem

  subject {
    common_name  = "localhost"
    organization = "My home org"
  }

  validity_period_hours = 8760
  is_ca_certificate     = true

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "local_file" "nginx_cert_file" {
  content  = tls_self_signed_cert.nginx_cert.cert_pem
  filename = abspath("${path.module}/nginx.crt")
}

resource "local_file" "nginx_key_file" {
  content  = tls_private_key.nginx_key.private_key_pem
  filename = abspath("${path.module}/nginx.key")
}
