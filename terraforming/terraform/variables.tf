variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "linux_virtual_machines" {
  type = map(
    object({
      admin_username = string
      size           = string
      interfaces     = map(object({
        virtual_network               = string
        subnet                        = string
        private_ip_address_allocation = string
        private_ip_address            = string
      }))
      os_disk        = object({
        caching              = string
        storage_account_type = string
      })
    })
  )
}


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
