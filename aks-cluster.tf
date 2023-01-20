resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group}-rg"
  location = var.resource_group_location

  tags = {
    environment = "aks"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}acr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Premium"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                             = "${var.resource_group}-aks"
  location                         = azurerm_resource_group.rg.location
  resource_group_name              = azurerm_resource_group.rg.name
  http_application_routing_enabled = true
  dns_prefix                       = "${var.resource_group}-aks"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "aks"
  }
}

resource "azurerm_role_assignment" "role" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}