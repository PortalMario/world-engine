locals {
  dns_zones_records = flatten([
    for k1, zones in var.dns_zones : [
      for k2, a_records in zones.a_records : {
        resource_group = zones.resource_group
        ttl            = zones.ttl
        zone           = k1
        hostname       = k2
        ip_address     = a_records
      }
    ]
  ])
  dns_zones = {for obj in local.dns_zones_records : "${obj.zone}_${obj.hostname}" => obj}
}



resource "azurerm_dns_a_record" "dns_a_record" {
  for_each = local.dns_zones

  resource_group_name = each.value["resource_group"]
  ttl                 = each.value["ttl"]
  zone_name           = each.value["zone"]
  name                = each.value["hostname"]
  records             = each.value["ip_address"]

}