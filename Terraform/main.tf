provider "vault" {
  address = "" # URL do Vault
  token   = var.vault_token
}

data "vault_kv_secret_v2" "proxmox" {
  mount = "secret"
  name  = "homelab/proxmox"
}

locals {
  pm_api_url          = data.vault_kv_secret_v2.proxmox.data["pm_api_url"]
  pm_api_token_secret = data.vault_kv_secret_v2.proxmox.data["pm_api_token_secret"]
  pm_api_token_id     = data.vault_kv_secret_v2.proxmox.data["pm_api_token_id"]
  password            = data.vault_kv_secret_v2.proxmox.data["password"]
  ssh_password        = data.vault_kv_secret_v2.proxmox.data["password"]
}

provider "proxmox" {
  pm_api_url          = local.pm_api_url
  pm_api_token_id     = local.pm_api_token_id
  pm_api_token_secret = local.pm_api_token_secret
  pm_tls_insecure     = true
}

resource "proxmox_lxc" "vm-plex" {
target_node  = var.target_node
  hostname     = var.hostname
  vmid         = var.vmid
  ostemplate   = var.ostemplate
  password     = local.ssh_password
    unprivileged = true
  cores        = 2
  memory       = 2048
  swap         = 1024
  start        = true
  onboot       = true

  features {
    nesting = true
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = var.vm_ip
    gw     = var.gateway
  }

  rootfs {
    storage = var.storage
    size    = "50G"
  }

  ssh_public_keys = file(var.ssh_key_path)
}