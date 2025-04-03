variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "vm_size" {
  description = "Azure VM Size"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "Admin Username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin Password for the VM"
  type        = string
  sensitive   = true
}

variable "network_interface_id" {
  description = "ID of the existing Network Interface"
  type        = string
}

variable "os_disk_size" {
  description = "OS Disk size in GB"
  type        = number
  default     = 128
}

variable "os_disk_type" {
  description = "Type of OS Disk"
  type        = string
  default     = "Premium_LRS"
}

variable "image_reference" {
  description = "OS Image Reference"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

variable "data_disks" {
  description = "List of data disks to attach"
  type = list(object({
    name                 = string
    disk_size_gb         = number
    storage_account_type = string
    lun                  = number
  }))
  default = []
}
