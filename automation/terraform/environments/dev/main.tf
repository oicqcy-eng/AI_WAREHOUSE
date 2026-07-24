# ============================================
# AI-WAREHOUSE — Terraform 开发环境
# ============================================
# terraform init
# terraform plan -var-file=terraform.tfvars
# terraform apply
# ============================================

terraform {
  required_version = ">= 1.6"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# ── Docker 网络 ──
resource "docker_network" "ai_warehouse_net" {
  name   = "ai-warehouse-net"
  driver = "bridge"
  ipam_config {
    subnet = "172.20.0.0/16"
  }
}

# ── Docker 卷 ──
resource "docker_volume" "postgres_data" {
  name = "postgres-data"
}

resource "docker_volume" "redis_data" {
  name = "redis-data"
}

resource "docker_volume" "milvus_data" {
  name = "milvus-data"
}

resource "docker_volume" "prometheus_data" {
  name = "prometheus-data"
}

resource "docker_volume" "grafana_data" {
  name = "grafana-data"
}

# ── Nginx ──
resource "docker_container" "nginx" {
  name    = "ai-warehouse-nginx"
  image   = "nginx:1.27-alpine"
  restart = "unless-stopped"
  ports {
    internal = 80
    external = 80
  }
  ports {
    internal = 443
    external = 443
  }
  networks_advanced {
    name = docker_network.ai_warehouse_net.name
  }
  volumes {
    host_path      = abspath("${path.module}/../../../orchestration/docker/nginx")
    container_path = "/etc/nginx"
  }
}
