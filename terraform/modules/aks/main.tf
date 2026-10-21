resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "this" {
  name     = "${var.name_prefix}-rg"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "${var.name_prefix}-law"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_registry" "acr" {
  name                = "${replace(var.name_prefix, "-", "")}acr${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.name_prefix}-aks"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  dns_prefix          = var.name_prefix

  role_based_access_control_enabled = true
  azure_policy_enabled              = true

  default_node_pool {
    name            = "system"
    node_count      = 2
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
