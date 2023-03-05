variable "subnet_ids" {
  type = any
}

variable "linux_virtual_machines" {
  type = any
}

variable "resource_groups" {
  type    = map(
    object({
      location = string
    })
  )
}
