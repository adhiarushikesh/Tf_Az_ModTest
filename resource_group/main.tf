variable "RG_name" { 
   default = "RG1"
   description = "Name of the resource group"
}

variable "location" {
  default = "southeastasia"
  description = "Geographic location of the Resource Group"
} 

provider "azurerm" {
    version = "=1.20.0"
}

resource "azurerm_resource_group" "rg" {
    name     = "${var.RG_name}"
    location = "${var.location}"
}

output "id" {
  value = "${azurerm_resource_group.rg.id}"
}

output "name" {
  value = "${azurerm_resource_group.rg.name}"
}
