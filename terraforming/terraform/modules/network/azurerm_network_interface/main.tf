# Create virtual networks for all virtual_machines in all resource groups.

locals {
  group_interfaces = flatten([
    for k1, rg in var.resource_groups : [
      for k2, vm in var.linux_virtual_machines : {
        group             = merge({name = "${k1}"}, rg )
        vm_name           = "${k2}"
        network_interface = "${k1}_${vm.virtual_network}_${vm.subnet}"
  #      network_interface = merge({name = "${k2}_interface"}, {subnet = vm.subnet })
      }
    ]
  ])
  network_interface = {for obj in local.group_interfaces : "${obj.vm_name}_${obj.network_interface}_interface" => obj}
}
# ich will var.linux_virtual_machines.subnet als regex search nutzen um dann die richtige id aus var.subnet_ids zu filtern.

resource "azurerm_network_interface" "network_interface" {
  for_each = local.network_interface

  location            = each.value.group["location"]
  resource_group_name = each.value.group["name"]
  name                = "${each.value["vm_name"]}_${each.value["network_interface"]}_interface"
  ip_configuration {
    name                          = "ip-config"
    # virtual_network var wird benötigt um die richtige subent id zu filtern
    subnet_id                     = var.subnet_ids[each.value["network_interface"]].id
    private_ip_address_allocation = "Dynamic"
  }
} 

