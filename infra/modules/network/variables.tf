
variable "vnet_name" {
    type = string
}

variable "location" {
    type = string
}

variable "rg_name" {
    type = string 
}

variable "vnet_address_space" {
    type = list(string)
    default = ["10.0.0.0/8"] # un grand réseau pour etre tranquille
  
}

variable "aks_subnet_name" {
    type = string
    default = "snet-aks"
}

variable "aks_subent_address_prefixes" {
    type = list(string)
    default = ["10.240.0.0/16"]  #assez grand pour des milliers de conteneurs
  
}