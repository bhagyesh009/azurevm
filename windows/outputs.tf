output "vm_id" {
  description = "The ID of the Virtual Machine"
  value       = azurerm_windows_virtual_machine.vm.id
}

output "vm_private_ip" {
  description = "The private IP address of the Virtual Machine"
  value       = azurerm_windows_virtual_machine.vm.private_ip_address
}
