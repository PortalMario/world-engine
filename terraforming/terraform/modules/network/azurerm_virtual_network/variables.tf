variable "virtual_networks" {
  type  = map
}

variable "resource_groups" {
  type    = map(
    object({
      location = string
    })
  )
}
