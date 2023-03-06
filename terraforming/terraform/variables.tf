variable "client_id" {
  type      = string
  sensitive = true
}

variable "client_secret" {
  type      = string
  sensitive = true
}

variable "subscription_id" {
  type      = string
  sensitive = true
}

variable "tenant_id" {
  type      = string
  sensitive = true
}

variable "ansible_ssh_key" {
  type      = string
  sensitive = true
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
