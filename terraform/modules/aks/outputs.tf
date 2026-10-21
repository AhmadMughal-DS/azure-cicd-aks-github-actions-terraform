output "acr_name" {
  value = azurerm_container_registry.acr.name
}
output "aks_name" {
  value = azurerm_kubernetes_cluster.this.name
}
output "resource_group" {
  value = azurerm_resource_group.this.name
}
