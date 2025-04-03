provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-windows-vm"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "windows-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "windows-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "windows-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

module "windows_vm" {
  source              = "./modules/windows_vm"
  vm_name             = "win-vm-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vm_size             = "Standard_D2s_v3"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd!"
  network_interface_id = azurerm_network_interface.nic.id
  os_disk_size        = 128
  os_disk_type        = "Premium_LRS"

  image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  data_disks = [
    {
      name                 = "datadisk1"
      disk_size_gb         = 256
      storage_account_type = "Premium_LRS"
      lun                  = 0
    },
    {
      name                 = "datadisk2"
      disk_size_gb         = 512
      storage_account_type = "StandardSSD_LRS"
      lun                  = 1
    }
  ]
}
