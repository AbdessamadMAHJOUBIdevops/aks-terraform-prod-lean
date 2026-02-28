

variable "acr_name" {
    type = string
    description = "Le nom de l'Azure Container Registry (doit être globalement unique et sans tirets)"
  
}

variable "rg_name" {
    type = string
    description = "Le nom du Resource Group"
  
}

variable "location" {
  description = "La localisation Azure"
  type        = string
}