resource "azurerm_container_registry" "acr" {
  name                = "unyleyaacr1"
  resource_group_name = azurerm_resource_group.unyleya.name
  location            = azurerm_resource_group.unyleya.location
  sku                 = "Standard"
  admin_enabled       = false
}
resource "azurerm_role_assignment" "acr" {
  principal_id                     = azurerm_kubernetes_cluster.unyleya.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
