
resource "azurerm_kubernetes_cluster" "this" {

  name = var.cluster_name
  location = var.location
  resource_group_name = var.rg_name
  dns_prefix = var.dns_prefix

  # La configuration de nos machines (Node Pool)

  default_node_pool {
   name = "default"
   node_count = var.node_count
   vm_size = var.vm_size
   vnet_subnet_id = var.vnet_subnet_id    # On branche K8s sur notre réseau !
  }


  # On active l'identité managée (Azure gère l'identité du cluster)

  identity {type = "SystemAssigned"}

}


#  LA MAGIE DU CLOUD NATIVE : On donne le droit "AcrPull" au cluster sur l'ACR
resource "azurerm_role_assignment" "aks_to_acr" {
  principal_id = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope = var.acr_id
  skip_service_principal_aad_check = true
  
}