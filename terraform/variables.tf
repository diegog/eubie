variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
  default     = "eastus"
}

variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
  default     = "diegog"
}

resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "random_string" "storage_account_name" {
  length  = 16
  lower   = true
  numeric = true
  special = false
  upper   = false
}

resource "random_string" "azurerm_search_service_name" {
  length  = 8
  upper   = false
  numeric = false
  special = false
}

resource "random_string" "openai_service_name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "random_string" "model_deployment_name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}
