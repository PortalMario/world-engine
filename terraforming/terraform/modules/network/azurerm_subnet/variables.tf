variable "virtual_networks" {
  type  = any
}

variable "resource_groups" {
  type    = map(
    object({
      location = string
    })
  )
}
