inputs = {
  dns_zones = {
    "world-engine.cloud": {
      ttl            = 300
      resource_group = "world_engine-EU"
      a_records = {
        "world-engine-k8s01" = ["10.0.0.10"]
        "world-engine-k8s02" = ["10.0.0.12"]
      }
    }
  }
}