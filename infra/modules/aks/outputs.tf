

output "kube_config" {
    value = azurerm_kubernetes_cluster.this.kube_config_raw
    sensitive = true  # On cache ça dans les logs car c'est le mot de passe du cluster !
    description = "Le fichier de configuration pour se connecter avec kubectl"
  
}


output "cluster_name" {
    value = azurerm_kubernetes_cluster.this.name
  
}