output "rg_name" {
    value = azurerm_resource_group.this.name
    description = "Le nom du RG crée"
}

output "reg_location" {
    value = azurerm_resource_group.this.location
    description = "La localisation di RG"
  
}