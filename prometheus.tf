resource "docker_image" "prometheus" {
  name         = "prom/prometheus:${var.prometheus_version}"
  keep_locally = true
}

resource "docker_container" "prometheus_container" {
  name  = var.prometheus_container_name
  image = docker_image.prometheus.name

  ports {
    internal = var.prometheus_internal_port
    external = var.prometheus_external_port
  }

  volumes {
    host_path      = abspath("${path.module}/${var.prometheus_config_folder}")
    container_path = "/etc/prometheus"
    read_only      = false
  }

  depends_on = [docker_image.prometheus]
}
