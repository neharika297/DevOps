data "azurerm_resources" "target_resource" {
  for_each            = var.app_service_virtual_network_swift_connection_variables
  name                = each.value.app_service_virtual_network_swift_connection_target_resource_name
  resource_group_name = each.value.app_service_virtual_network_swift_connection_target_resource_resource_group_name
}

data "azurerm_subnet" "subnet" {
  for_each             = var.app_service_virtual_network_swift_connection_variables
  name                 = each.value.app_service_virtual_network_swift_connection_subnet_name
  virtual_network_name = each.value.app_service_virtual_network_swift_connection_virtual_network_name
  resource_group_name  = each.value.app_service_virtual_network_swift_connection_subnet_resource_group_name
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_service_virtual_network_swift_connection" {
  for_each       = var.app_service_virtual_network_swift_connection_variables
  app_service_id = data.azurerm_resources.target_resource[each.key].resources[0].id
  subnet_id      = data.azurerm_subnet.subnet[each.key].id
}