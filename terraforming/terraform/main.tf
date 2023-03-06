# Create interface out of linux_virtual_machines interfaces.
module "azurerm_network_interface" {
  source                 = "./modules/network/azurerm_network_interface"
  resource_groups        = var.resource_groups
  subnet_ids             = module.azurerm_subnet.subnets
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

/* output "test" {
  value = module.azurerm_network_interface
} */