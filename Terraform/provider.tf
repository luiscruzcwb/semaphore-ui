terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      # version = ">= 2.9.11"
      version = "3.0.2-rc04"
    }
    vault = {
      source = "hashicorp/vault"
    }
  }
}