include "root" {
  path = find_in_parent_folders()
  merge_strategy = "deep"
}

include "dns" {
  path = "${get_terragrunt_dir()}/dns/terragrunt.hcl"
  merge_strategy = "deep"
}

inputs = {
  resource_groups = {
    "world_engine-EU": {
      location = "West Europe"
    }
    "world_engine-US": {
      location = "eastus"
    }
  }

#####################
#  Virtual Machines #
#####################

  linux_virtual_machines = {   
    "world-engine-k8s01" : {
      admin_username         = "world-engine"
      size                   = "Standard_F2"
      interfaces = {
        "interface_1": {
          virtual_network               = "infrastructure"
          subnet                        = "k8s"
          private_ip_address_allocation = "Static"
          private_ip_address            = "10.0.0.10"
        }
        "interface_2": {
          virtual_network               = "infrastructure"
          subnet                        = "k8s"
          private_ip_address_allocation = "Static"
          private_ip_address            = "10.0.0.11" 
        }
      }
      os_disk                = {
        caching              = "None"
        storage_account_type = "Standard_LRS"
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    }
    "world-engine-k8s02" : {
      admin_username         = "world-engine"
      size                   = "Standard_F2"
      interfaces = {
        "interface_1": {
          virtual_network               = "infrastructure"
          subnet                        = "k8s"
          private_ip_address_allocation = "Static"
          private_ip_address            = "10.0.0.12"
        }
      }
      os_disk                = {
        caching              = "None"
        storage_account_type = "Standard_LRS"
      }
      source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    } 
  }
##################
# Load Balancers #
##################

/*   load_balancers = {
    "k8s-lb01": {
      frontend_ip = 
    }
  }
 */
}