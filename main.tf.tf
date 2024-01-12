terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  # Configuration options
}

resource "docker_image" "mycv" {
  name         = "nour0/cv:latest"
  keep_locally = false
}

resource "docker_container" "cv" {
  image = docker_image.cv.name  # Use 'name' attribute, not '.latest'
  name  = "cv_nour"
  
  dynamic "ports" {
    for_each = [1, 2]  # Adjust based on the number of ports you want
    content {
      internal = 80
      external = 8080 + ports.key - 1
    }
  }
}