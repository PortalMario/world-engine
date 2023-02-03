include "root" {
  path = find_in_parent_folders()
  merge_strategy = "deep"
}

inputs = {
  resource_groups = {
    "world-engine_test": {
      location  = "West Europe"
    }
  }
}