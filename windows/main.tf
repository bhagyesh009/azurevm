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

  dynamic "data_disk" {
    for_each = var.data_disks
    content {
      name                 = data_disk.value.name
      disk_size_gb         = data_disk.value.disk_size_gb
      storage_account_type = data_disk.value.storage_account_type
      lun                  = data_disk.value.lun
      caching              = "None"
    }
  }

  source_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }
}
