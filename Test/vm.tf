resource "azurerm_linux_virtual_machine" "tflivm" {
    name = "linuxvm1"
    location = azurerm_resource_group.tfrg.location
    resource_group_name = azurerm_resource_group.tfrg.name
    size = "Standard_DS1_v2"
    admin_username = "adminrati"
    network_interface_ids = [ azurerm_network_interface.tfnic1.id ]

    admin_ssh_key {
      username = "adminrati"
      public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
    }

    os_disk {
      name = "osdisk"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }

  custom_data = filebase64("${path.module}/app-script/app1-cloud-init.txt")

  
}