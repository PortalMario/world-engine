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

/* variable "linux_virtual_machines" {
  type = any
}
 */

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
