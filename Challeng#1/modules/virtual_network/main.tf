#Virtual network
resource "azurerm_virtual_network" "virtual_network" {
  for_each                = var.virtual_network_variables
  name                    = each.value.virtual_network_name
  location                = each.value.virtual_network_location
  resource_group_name     = each.value.virtual_network_resource_group_name
  address_space           = each.value.virtual_network_address_space
}