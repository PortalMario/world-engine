terraform {
  source = "../terraform///"
}

locals {
  client_id       = get_env("ARM_CLIENT_ID")
  client_secret   = get_env("ARM_CLIENT_SECRET")
  subscription_id = get_env("ARM_SUBSCRIPTION_ID")
  tenant_id       = get_env("ARM_TENANT_ID")
}

inputs = {
  client_id       = local.client_id
  client_secret   = local.client_secret
  subscription_id = local.subscription_id
  tenant_id       = local.tenant_id
}