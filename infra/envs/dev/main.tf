
# 1. On appelle le module RG
module "rg" {
    source = "../../modules/rg"
    rg_name = "rg-aks-dev-frc"
    location = "francecentral"
  
}



# 2. On appelle le module Network (qui dépend du RG)

module "network" {
    source = "../../modules/network"
    rg_name = module.rg.rg_name
    location = module.rg.reg_location
    vnet_name = "vnet-aks-dev-frc"
  
}


# 3. On appelle le module ACR
module "acr" {

    source = "../../modules/acr"

    # Le nom de l'ACR doit être UNIQUE AU MONDE et composé UNIQUEMENT de minuscules/chiffres (pas de tirets !)
    acr_name = "acrmahjoubidev2026"
    rg_name = module.rg.rg_name
    location = module.rg.reg_location
  
}


# 4. On appelle le module AKS
module "aks" {

    source = "../../modules/aks"
    cluster_name = "aks-dev-frc-001"
    rg_name = module.rg.rg_name
    location = module.rg.reg_location
    dns_prefix = "aksdevmahjoubi"

    # On connecte AKS au Subnet créé par le module network
    vnet_subnet_id = module.network.aks_subnet_id

    # On connecte AKS à l'ACR créé par le module acr
    acr_id = module.acr.acr_id

  
}