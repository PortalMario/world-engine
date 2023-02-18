variable "linux_virtual_machines" {
  type = map(
    object({
      admin_username = string
      location       = string
      network_interface_ids = list(string)
      size                  = string
      resource_group_name   = string
      os_disk               = object({
        caching               = string
        storage_account_type  = string
      })
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
