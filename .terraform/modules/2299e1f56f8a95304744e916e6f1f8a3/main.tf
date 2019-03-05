variable resource_group_name {
  description = "Resource group name"
}

variable "location" {
   default = "southeastasia"
   description = "Geographic location"
}
variable account_name {
  description = "Storage account name. Must be unique across Azure." 
}

variable "account_tier" {
  default = "Standard"
}
variable "account_rep_type" {
  default = "LRS"
}


resource "azurerm_storage_account" "sa" {
    name = "${var.account_name}"
    resource_group_name = "${var.resource_group_name}"
    account_tier             = "${var.account_tier}"
    account_replication_type = "${var.account_rep_type}"
    location                 = "${var.location}"
}

output "primary_blob_endpoint" {
    value = "${azurerm_storage_account.sa.primary_blob_endpoint}"
}

output "name" {
    value = "${azurerm_storage_account.sa.name}"
}
