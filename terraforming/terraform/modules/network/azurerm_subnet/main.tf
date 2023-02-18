locals {
  virtual_networks_subnets = flatten([
    for k1, rg in var.resource_groups : [
      for k2, vn in var.virtual_networks : [
        for k3, sn in vn.subnets : {
          group = merge({name = "${k1}"}, rg )
          network = merge({name = "${k2}"}, vn )
          subnets = merge({name = "${k3}"}, sn)
        }
      ]
    ]
  ])
  subnets = {for obj in local.virtual_networks_subnets : "${obj.group.name}_${obj.network.name}_${obj.subnets.name}" => obj}
}

resource "azurerm_subnet" "subnet" {
  for_each = local.subnets

  name                  = each.value.subnets["name"]
  resource_group_name   = each.value.group["name"]
  virtual_network_name  = each.value.network["name"]
  address_prefixes      = each.value.subnets["address_prefixes"]
}

data "azurerm_subnet" "subnet" {
  for_each = local.subnets

  name                  = each.value.subnets["name"]
  resource_group_name   = each.value.group["name"]
  virtual_network_name  = each.value.network["name"]
}
