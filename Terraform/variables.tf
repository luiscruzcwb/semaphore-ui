variable "target_node" {
  default = "pve"
}

# Ajustar nome do recurso
variable "hostname" {
  default = "vm-nome-do-recurso" 
}

# Ajustar ID do recurso
variable "vmid" {
  default = "xxx" 
}

variable "ostemplate" {
  default = "local:vztmpl/ubuntu-25.04-standard_25.04-1.1_amd64.tar.zst"
}

# Ajustar IP da VM
variable "vm_ip" {
  default = "192.168.18.xxx/24" 
}

# Ajustar CIDR da VM
variable "vm_ip_cidr_only" {
  default = "192.168.18.xxx" 
}

# Ajustar gateway
variable "gateway" {
  default = "192.168.18.1" 
}

variable "storage" {
  default = "local-lvm"
}

# Ajustar caminho da chave SSH
variable "ssh_key_path" {
  description = "Caminho para a chave SSH pública"
  default = "" 
}

# Ajustar token do Vault
variable "vault_token" {
  description = "Token do Vault para acesso aos secrets" 
}

