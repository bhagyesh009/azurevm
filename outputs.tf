output "vm_id" {
  description = "The ID of the Virtual Machine"
  value       = module.windows_vm.vm_id
}

output "vm_private_ip" {
  description = "The private IP address of the Virtual Machine"
  value       = module.windows_vm.vm_private_ip
}
