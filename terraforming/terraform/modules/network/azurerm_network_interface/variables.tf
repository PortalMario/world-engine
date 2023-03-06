variable "subnets" {
  type = any
}

variable "linux_virtual_machines" {
  type = map(
    object({
      admin_username         = string
      size                   = string
      interfaces             = map(object({
        virtual_network               = string
        subnet                        = string
        private_ip_address_allocation = string
        private_ip_address            = string
      }))
      os_disk                = object({
        caching              = string
        storage_account_type = string
      })
      source_image_reference = object({
        publisher = string
        offer     = string
        sku       = string
        version   = string
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
