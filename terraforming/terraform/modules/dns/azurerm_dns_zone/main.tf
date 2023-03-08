resource "azurerm_dns_zone" "dns_zone" {
  for_each = var.dns_zones

  name                = each.key
  resource_group_name = each.value["resource_group"]
}