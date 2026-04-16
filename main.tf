terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  type        = string
  description = "The DigitalOcean Personal Access Token"
  sensitive   = true
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "do_terraform"
}

resource "digitalocean_droplet" "my-node" {
  image  = "docker-20-04"
  name   = "my-node"
  region = "sgp1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
}

resource "digitalocean_project" "terraform" {
  name        = "terraform"
  description = "A project to represent terraform demo."
  purpose     = "Web Application"
  environment = "Production"
  resources = [
    digitalocean_droplet.my-node.urn
  ]
}

output "droplet_ip" {
  value = digitalocean_droplet.my-node.ipv4_address
}
# PAT = dop_v1_dc458c964f92c8dffc40231ec2b50e9de0711b626d9aba3feabbf3066d7214fb
# SSH = a5:66:7c:ae:d6:40:e9:58:5a:2e:b3:dd:cd:82:36:62