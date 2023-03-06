variable "virtual_networks" {
  type = map(
    object({
      address_space = list(string)
      subnets       = map(object({
        address_prefixes = list(string)
      }))
    })
  )
}


variable "resource_groups" {
  type    = map(
    object({
      location = string
    })
  )
}
