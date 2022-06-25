resource "azurerm_resource_group" "unyleya" {
  name     = "unyleya"
  location = "brazilsouth"
}

resource "azurerm_kubernetes_cluster" "unyleya" {
  name                = "aksunyleya1"
  location            = azurerm_resource_group.unyleya.location
  resource_group_name = azurerm_resource_group.unyleya.name
  dns_prefix          = "aksunyleya1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.unyleya.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.unyleya.kube_config_raw

  sensitive = true
}