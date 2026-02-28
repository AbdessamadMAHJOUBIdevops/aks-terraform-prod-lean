
output "acr_id" {
    value = azurerm_container_registry.this.id
    description = "L'ID de l'ACR (utile pour donner les droits à AKS plus tard)"
  
}


output "acr_login_server" {
    
    value = azurerm_container_registry.this.login_server
    description = "L'URL de connexion à l'ACR"
  
}