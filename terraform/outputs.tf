output "resource_group_name" {
  description = "Azure resource group"
  value       = azurerm_resource_group.main.name
}

output "vm_name" {
  description = "Virtual machine name"
  value       = azurerm_linux_virtual_machine.main.name
}

output "public_ip_address" {
  description = "VM public IP address"
  value       = azurerm_public_ip.main.ip_address
}

output "private_ip_address" {
  description = "VM private IP address"
  value       = azurerm_network_interface.main.private_ip_address
}

output "virtual_network_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.main.name
}

output "subnet_name" {
  description = "Subnet name"
  value       = azurerm_subnet.main.name
}

output "network_security_group_name" {
  description = "Network security group name"
  value       = azurerm_network_security_group.main.name
}

output "network_interface_name" {
  description = "Network interface name"
  value       = azurerm_network_interface.main.name
}

output "ssh_command" {
  description = "SSH command to connect to the VM"
  value       = "ssh -i <PATH_TO_PRIVATE_KEY> ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}
