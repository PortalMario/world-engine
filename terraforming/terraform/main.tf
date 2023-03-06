module "azurerm_linux_virtual_machine" {
  source                 = "./modules/compute/azurerm_linux_virtual_machine"
  resource_groups        = var.resource_groups
  linux_virtual_machines = var.linux_virtual_machines
  network_interfaces     = module.azurerm_network_interface.network_interfaces
  ansible_ssh_key        = var.ansible_ssh_key
  depends_on             = [module.azurerm_network_interface]
}

# Create interface out of linux_virtual_machines interfaces.
module "azurerm_network_interface" {
  source                 = "./modules/network/azurerm_network_interface"
  resource_groups        = var.resource_groups
  subnets                = module.azurerm_subnet.subnets
  linux_virtual_machines = var.linux_virtual_machines
  depends_on             = [module.azurerm_subnet]
}

module "azurerm_resource_group" {
  source          = "./modules/base/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "azurerm_subnet" {
  source            = "./modules/network/azurerm_subnet"
  resource_groups   = var.resource_groups
  virtual_networks  = var.virtual_networks
  depends_on        = [module.azurerm_virtual_network]
}

module "azurerm_virtual_network" {
  source           = "./modules/network/azurerm_virtual_network" 
  resource_groups  = var.resource_groups
  virtual_networks = var.virtual_networks
  depends_on       = [module.azurerm_resource_group]
}

/* output "debug1" {
  value = module.azurerm_linux_virtual_machine
} */