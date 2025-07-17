terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx_container" {
  name  = "nginx-webapp"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8080
  }

  volumes {
    host_path      = abspath("${path.module}/site")
    container_path = "/usr/share/nginx/html"
    read_only      = false
  }

  depends_on = [docker_image.nginx]
}  # <-- cette accolade ferme bien le bloc
