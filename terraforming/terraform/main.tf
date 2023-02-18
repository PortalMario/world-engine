module "azurerm_resource_group" {
  source          = "./modules/base/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "azurerm_subnet" {
  source            = "./modules/network/azurerm_subnet"
  resource_groups   = var.resource_groups
  virtual_networks  = var.virtual_networks
  depends_on = [module.azurerm_virtual_network]
}

module "azurerm_virtual_network" {
  source           = "./modules/network/azurerm_virtual_network" 
  resource_groups  = var.resource_groups
  virtual_networks = var.virtual_networks
  depends_on = [module.azurerm_resource_group]
}

# interface über anzahl der vmserstellen

output "debug" {
  value = module.azurerm_subnet
}
