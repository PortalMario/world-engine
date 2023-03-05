include "root" {
  path = find_in_parent_folders()
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
  linux_virtual_machines = {   
    "world_engine-k8s01" : {
      admin_username  = "world-engine"
      size            = "Standard_F2"
      virtual_network = "infrastructure"
      subnet          = "k8s"
      os_disk         = {
        caching              = "None"
        storage_account_type = "Standard_LRS"
      }
    } 
  }
}