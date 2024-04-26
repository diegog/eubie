data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "diegog0x${random_string.storage_account_name.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "documents" {
  name                  = "document-container"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "blob"
}

resource "azurerm_search_service" "search" {
  name                = "diegog-${random_string.azurerm_search_service_name.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "standard"
  replica_count       = 1
  partition_count     = 1
}

resource "azurerm_cognitive_account" "openai_service" {
  name                  = "diegog-${random_string.openai_service_name.result}"
  custom_subdomain_name = "diegog-${random_string.openai_service_name.result}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  sku_name              = "S0"
  kind                  = "OpenAI"
}

resource "azurerm_cognitive_deployment" "gpt_35_deployment" {
  name                 = "diegog-gpt-35-${random_string.model_deployment_name.result}"
  cognitive_account_id = azurerm_cognitive_account.openai_service.id

  model {
    format  = "OpenAI"
    name    = "gpt-35-turbo"
    version = "0301"
  }

  scale {
    type     = "Standard"
    capacity = 10
  }
}

resource "azurerm_cognitive_deployment" "ada_002_deployment" {
  name                 = "diegog-ada-002-${random_string.model_deployment_name.result}"
  cognitive_account_id = azurerm_cognitive_account.openai_service.id

  model {
    format  = "OpenAI"
    name    = "text-embedding-ada-002"
    version = "2"
  }

  scale {
    type     = "Standard"
    capacity = 10
  }
}
