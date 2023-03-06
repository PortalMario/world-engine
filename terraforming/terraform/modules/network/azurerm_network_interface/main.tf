locals {
  group_interfaces = flatten([
    for k1, rg in var.resource_groups : [
      for k2, vm in var.linux_virtual_machines : [
        for k3, interfaces in vm.interfaces : {
          group             = merge({name = "${k1}"}, rg )
          vm_name           = "${k2}"
          interface        = merge({name = "${k3}"}, interfaces)
      }
      ]]
  ])
  network_interface = {for obj in local.group_interfaces : "${obj.group.name}_${obj.vm_name}_${obj.interface.name}" => obj}
}


resource "null_resource" "name" {
  for_each = local.network_interface

  triggers = {
    "test" = var.subnet_ids["${each.value["group"]["name"]}_${each.value["interface"]["virtual_network"]}_${each.value["interface"]["subnet"]}"].id
  }
}

resource "azurerm_network_interface" "network_interface" {
  for_each = local.network_interface

  location            = each.value.group["location"]
  resource_group_name = each.value.group["name"]
  name                = each.key
  ip_configuration {
    name                          = "ip-config"
    # Virtual_network is required to filter the correct id from "var.subnet_ids".
    subnet_id                     = var.subnet_ids["${each.value["group"]["name"]}_${each.value["interface"]["virtual_network"]}_${each.value["interface"]["subnet"]}"].id
    private_ip_address_allocation = each.value["interface"]["private_ip_address_allocation"]
    private_ip_address            = each.value["interface"]["private_ip_address"]
  }
} 

