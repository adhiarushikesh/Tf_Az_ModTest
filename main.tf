variable module_base { default = "./Tf_Az_ModTest/" }

module "resource_group" {
  source = "./resource_group"
  name = "${var.name}"
  location = "${var.location}"
}

module "virtual_network" {
  source = "./virtual_network"
  name = "${var.name}"
  location = "${var.location}"
  resource_group_name = "${module.resource_group.name}"
  address_space = "${var.network_address_space}"
}

module "subnet" {
  source = "./subnet"
  name = "${var.name}"
  resource_group_name = "${module.resource_group.name}"
  virtual_network_name = "${module.virtual_network.name}"
  address_prefixes = "${var.subnet_address_prefixes}"
}

#module "storage_account" {
#  source = "./storage_account"
#  account_name = "${var.name}osdisks"
#  resource_group_name = "${module.resource_group.name}"
#  location = "${var.location}"
#}

module "public_ips_control" {
  name = "control"
  source = "./public_ip"
  location = "${var.location}"
  resource_group_name = "${module.resource_group.name}"
  count = "${var.control_count}"
}

module "load_balancer" {
  source = "./load_balancer"
  name = "${var.name}-lb"
}
  
module "vms_control" {
  source = "./virtual_machines"
  name = "${var.name}-control"
  count = "${var.control_count}"
  vm_name = "control"
  location = "${var.location}"
  role = "role=control"
  datacenter = "${var.datacenter}"
  resource_group_name = "${module.resource_group.name}"
  subnet_ids = "${module.subnet.ids}"
  storage_account_name = "${module.storage_account.name}"
  storage_primary_blob_endpoint = "${module.storage_account.primary_blob_endpoint}"
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
#  public_ip_addresses = "${module.public_ips_control.ip_addresses}"
  public_ip_address_ids = "${module.public_ips_control.ids}"
#  network_security_group_id = "${module.network_security_group_default.id}"
}
