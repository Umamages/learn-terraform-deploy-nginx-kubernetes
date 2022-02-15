terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
	docker = {
      source = "kreuzwerker/docker"
    }
  }
}
provider "docker" {
  host = "tcp://localhost:2375"
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
  must_run = "true"
  publish_all_ports = "true"
  hostname = "localhost"
  ports {
    internal = 8003
    external = 8003
  }
}
