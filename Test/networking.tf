# Virtual Network
resource "azurerm_virtual_network" "tfvnet" {
    name = "Finance-Prod-vNet"
    location = azurerm_resource_group.tfrg.location
    resource_group_name = azurerm_resource_group.tfrg.name 
    address_space = [ "99.0.0.0/16" ]
}


#Subnets
resource "azurerm_subnet" "tfsubnet1" {
    name = "WebServerSubnet"
    resource_group_name = azurerm_resource_group.tfrg.name
    virtual_network_name = azurerm_virtual_network.tfvnet.name 
    address_prefixes = ["99.0.1.0/24"]
}

resource "azurerm_subnet" "tfsubnet2" {
    name = "AppServerSubnet"
    resource_group_name = azurerm_resource_group.tfrg.name
    virtual_network_name = azurerm_virtual_network.tfvnet.name
    address_prefixes = ["99.0.2.0/24"]
}


#Public Ip
resource "azurerm_public_ip" "tfpubip1" {
    name = "webserver-pubip1"
    resource_group_name = azurerm_resource_group.tfrg.name 
    location = azurerm_resource_group.tfrg.location
    allocation_method = "Dynamic"  
}


#Network interface
resource "azurerm_network_interface" "tfnic1" {
    name = "webnic1"
    location = azurerm_resource_group.tfrg.location
    resource_group_name = azurerm_resource_group.tfrg.name
    ip_configuration {
      name = "internal"
      subnet_id = azurerm_subnet.tfsubnet1.id
      private_ip_address_allocation = "dynamic"
      public_ip_address_id = azurerm_public_ip.tfpubip1.id
      primary = true
    }
}