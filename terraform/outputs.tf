output "acr_name" {
  description = "ACR name (set as the ACR_NAME GitHub secret)"
  value       = azurerm_container_registry.acr.name
}

output "aks_name" {
  description = "AKS cluster name (set as the AKS_CLUSTER GitHub secret)"
  value       = azurerm_kubernetes_cluster.this.name
}

output "resource_group" {
  description = "Resource group (set as the AKS_RESOURCE_GROUP GitHub secret)"
  value       = azurerm_resource_group.this.name
}
