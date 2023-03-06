locals {
  group_linux_virtual_machines = flatten([
    for k1, rg in var.resource_groups : [
      for k2, vm in var.linux_virtual_machines : {
        group                  = merge({name = "${k1}"}, rg )
        linux_virtual_machine  = merge({name = "${k2}"}, vm )
        interfaces = flatten([
            for k3, interfaces in vm.interfaces : [
                var.network_interfaces["${k1}_${k2}_${k3}"].id
            ]
        ])
      }
    ]
  ])
  linux_virtual_machines = {for obj in local.group_linux_virtual_machines : "${obj.group.name}_${obj.linux_virtual_machine.name}" => obj}
}



resource "azurerm_linux_virtual_machine" "linux_virtual_machines" {
  for_each = local.linux_virtual_machines

  location                     = each.value.group["location"]
  resource_group_name          = each.value.group["name"]
  name                         = each.value.linux_virtual_machine["name"]
  admin_username               = each.value.linux_virtual_machine["admin_username"]
  size                         = each.value.linux_virtual_machine["size"]
  network_interface_ids        = each.value.interfaces
  os_disk {
    caching              = each.value.linux_virtual_machine["os_disk"]["caching"]
    storage_account_type = each.value.linux_virtual_machine["os_disk"]["storage_account_type"]
  }
  admin_ssh_key {
    username = "world-engine"
    public_key = var.ansible_ssh_key
  }
  source_image_reference {
    publisher = each.value.linux_virtual_machine["source_image_reference"]["publisher"]
    offer     = each.value.linux_virtual_machine["source_image_reference"]["offer"]
    sku       = each.value.linux_virtual_machine["source_image_reference"]["sku"]
    version   = each.value.linux_virtual_machine["source_image_reference"]["version"]
  }
}