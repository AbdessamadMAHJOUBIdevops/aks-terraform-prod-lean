
output "vnet_id" {
    value = azurerm_virtual_network.this.id
  
}

output "aks_subnet_id" {
    value = azurerm_subnet.aks_subnet.id
    description = "L'ID du subnet.Crucial pour dire à AKS où s'installer !"
  
}