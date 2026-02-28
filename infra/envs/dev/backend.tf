terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state" 
    
    storage_account_name = "tfstateabdessamad2026"
    container_name       = "tfstate"
    key                  = "aks-prod-lean.terraform.tfstate" 
    use_oidc             = true 
  }
}