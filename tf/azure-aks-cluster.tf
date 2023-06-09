# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tenpo-aks" {
  name                = "rg-tenpo-aks"
  location            = "East US"
  resource_group_name = "tenpo-resource-group"
}

resource "azurerm_kubernetes_cluster" "aks-lab01" {
  name                = "tenpo-aks1"
  location            = azurerm_resource_group.tenpo.location
  resource_group_name = azurerm_resource_group.tenpo.name
  dns_prefix          = "lab.tenpo.cl"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "lab"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}