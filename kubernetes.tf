terraform {
  required_providers {
    	docker = {
      source = "kreuzwerker/docker"
    }
  }
}
provider "docker" {
  version = "~> 2.6"
  host    = "npipe:////.//pipe//docker_engine"
}
 variable "host" {
  type = string
}

variable "client_certificate" {
  type = string
}

variable "client_key" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

provider "kubernetes" {
  host = var.host

  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}
resource "docker_image" "flask" {
  name         = "umamages/flaskapp:latest"
  keep_locally = false
}
resource "docker_container" "flask" {
  image = docker_image.flask.latest
  name  = "flaskapp"
  ports {
    internal = 8003
    external = 8003
  }
}
