
resource "azurerm_container_registry" "this" {

    name = var.acr_name
    resource_group_name = var.rg_name
    location = var.location

    # FinOps : Le niveau Basic est largement suffisant et le moins cher pour notre projet
  sku = "Basic"

  # Sécurité Enterprise : On désactive l'admin local
  # K8s s'authentifiera de manière moderne via RBAC

  admin_enabled = false



  
}