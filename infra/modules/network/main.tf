
# 1 le réseau virtuel global
resource "azurerm_virtual_network" "this" {
  name = var.vnet_name
  location = var.location
  resource_group_name = var.rg_name
  address_space = var.vnet_address_space
  
}


# 2 le sous réseau dédié uniquement au cluster AKS
resource "azurerm_subnet" "aks_subnet" {
  name = var.aks_subnet_name
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes = var.aks_subent_address_prefixes
  
}

