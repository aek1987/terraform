terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20.0"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

resource "docker_image" "nginx" {
  name         = "nginx:${var.nginx_version}"
  keep_locally = true
}

resource "docker_container" "nginx_container" {
  name  = var.container_name
  image = docker_image.nginx.name

  ports {
    internal = var.internal_port
    external = var.external_port
  }

  volumes {
    host_path      = abspath("${path.module}/${var.site_folder}")
    container_path = var.container_path
    read_only      = false
  }
  volumes {
    host_path      = abspath("${path.module}/nginx_conf")
    container_path = "/etc/nginx/conf.d"
    read_only      = false
  }

  depends_on = [docker_image.nginx]
}

resource "docker_container" "nginx_exporter" {
  name  = "nginx-exporter"
  image = "nginx/nginx-prometheus-exporter:latest"

  ports {
    internal = 9113
    external = 9113
  }

  command = [
    "-nginx.scrape-uri=http://nginx-webapp:8081/stub_status"
  ]

  depends_on = [docker_container.nginx_container]
}

