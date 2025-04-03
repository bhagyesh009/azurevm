resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [var.network_interface_id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size
  }

  source_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }
}

# Data Disks (Using Managed Disks & Attachments)
resource "azurerm_managed_disk" "data_disks" {
  count                = length(var.data_disks)
  name                 = var.data_disks[count.index].name
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_type = var.data_disks[count.index].storage_account_type
  disk_size_gb         = var.data_disks[count.index].disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  count              = length(var.data_disks)
  managed_disk_id    = azurerm_managed_disk.data_disks[count.index].id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun               = var.data_disks[count.index].lun
  caching           = "None"
}
