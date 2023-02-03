module "azurerm_resource_group" {
  source          = "./modules/base/azurerm_resource_group"
  resource_groups = var.resource_groups
}