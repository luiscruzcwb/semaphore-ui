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

# Ajustar IP da VM (ex: "10.0.0.10/24")
variable "vm_ip" {
  description = "IP da VM com máscara CIDR (ex: 10.0.0.10/24)"
  default = ""
}

# Ajustar CIDR da VM (ex: "10.0.0.10")
variable "vm_ip_cidr_only" {
  description = "IP da VM sem máscara (ex: 10.0.0.10)"
  default = ""
}

# Ajustar gateway (ex: "10.0.0.1")
variable "gateway" {
  description = "Gateway da rede (ex: 10.0.0.1)"
  default = ""
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

