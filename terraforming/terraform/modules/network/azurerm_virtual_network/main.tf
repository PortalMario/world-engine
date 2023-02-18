locals {
  resource_groups = flatten([
    for k1, rg in var.resource_groups : [
      for k2, vn in var.virtual_networks : {
        group = merge({name = "${k1}"}, rg )
        network = merge({name = "${k2}"}, vn )
      }
    ]
  ])
  virtual_networks = {for obj in local.resource_groups : "${obj.group.name}_${obj.network.name}" => obj}
}

resource "azurerm_virtual_network" "virtual_network" {
  for_each = local.virtual_networks

  name                = each.value.network.name
  resource_group_name = each.value.group.name
  location            = each.value.group.location
  address_space       = each.value.network.address_space

}

