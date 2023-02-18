resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  for_each = var.resource_groups

  name = each.key
  admin_username = "test"
  location = "westeurope"
  
}