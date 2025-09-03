variable "docker_host" {
  description = "Adresse du socket Docker"
  type        = string
  default     = "npipe:////.//pipe//docker_engine"
}

variable "nginx_version" {
  description = "Version de l'image Nginx"
  type        = string
  default     = "latest"
}

variable "container_name" {
  description = "Nom du conteneur Nginx"
  type        = string
  default     = "nginx-webapp"
}

variable "internal_port" {
  description = "Port interne du conteneur"
  type        = number
  default     = 80
}

variable "external_port" {
  description = "Port exposé sur la machine hôte"
  type        = number
  default     = 8080
}

variable "site_folder" {
  description = "Dossier local pour les fichiers du site"
  type        = string
  default     = "site"
}

variable "container_path" {
  description = "Chemin dans le conteneur où les fichiers seront montés"
  type        = string
  default     = "/usr/share/nginx/html"
}


# Prometheus
variable "prometheus_version" {
  default = "latest"
}
variable "prometheus_container_name" {
  default = "my-prometheus"
}
variable "prometheus_internal_port" {
  default = 9090
}
variable "prometheus_external_port" {
  default = 9090
}
variable "prometheus_config_folder" {
  default = "prometheus"
}