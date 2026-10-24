variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Resource group for the application"
  type        = string
  default     = "rg-health-check-api"
}

variable "vm_name" {
  description = "Linux VM name"
  type        = string
  default     = "health-check-api-vm"
}

variable "vm_size" {
  description = "Azure VM size; verify pricing and quota before deployment"
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "admin_username" {
  description = "Linux administrator username"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Absolute path to your SSH public key"
  type        = string
}

variable "github_runner_ip" {
  description = "GitHub Actions runner public IPv4 CIDR"
  type        = string
}

variable "admin_ssh_cidr" {
  description = "Administrator SSH source IP or CIDR"
  type        = string
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["172.16.0.0/16"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["172.16.0.0/24"]
}
