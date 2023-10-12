#Subnet
resource "azurerm_subnet" "subnet" {
  for_each                                       = var.subnet_variables
  resource_group_name                            = each.value.subnet_resource_group_name
  name                                           = each.value.subnet_name
  virtual_network_name                           = each.value.subnet_virtual_network_name
  address_prefixes                               = each.value.subnet_address_prefixes
  service_endpoints = each.value.subnet_service_endpoints
  #Subnet delegation
  dynamic "delegation" {
    for_each = each.value.delegation != null ? each.value.delegation : []
    content {
      name = delegation.value.delegation_name
      service_delegation {
        name    = delegation.value.service_delegation_name
        actions = delegation.value.service_delegation_actions
      }
    }
  }
}