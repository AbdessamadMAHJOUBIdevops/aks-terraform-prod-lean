
variable "cluster_name" {type = string}
variable "rg_name" { type = string }
variable "location" { type = string }
variable "dns_prefix" { type = string }
variable "vnet_subnet_id" { type = string }
variable "acr_id" { type = string }

variable "node_count" {
    type = number
    default = 1   # 1 seul nœud suffit pour le dev, on fera plus pour la prod !
  
}

variable "vm_size" {
    type = string
    default = "Standard_B2s"   # Petite machine pas chère
}



