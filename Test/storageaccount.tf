
resource "random_string" "tfrs" {
  upper = false
  length = 10
  special = false 
}

resource "azurerm_storage_account" "tfsa" {
  name = "sa${random_string.tfrs.id}"  
  account_replication_type = "LRS"
  account_tier = "Standard"
  location = azurerm_resource_group.tfrg.location
  resource_group_name = azurerm_resource_group.tfrg.name
}