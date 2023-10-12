data "azurerm_subnet" "subnet_id" {
  for_each             = var.mssql_virtual_network_rule_variables
  name                 = each.value.mssql_virtual_network_rule_subnet_name
  virtual_network_name = each.value.mssql_virtual_network_rule_virtual_network_name
  resource_group_name  = each.value.mssql_virtual_network_rule_subnet_resource_group_name
}

data "azurerm_mssql_server" "mssql_server_id" {
  for_each            = var.mssql_virtual_network_rule_variables
  name                = each.value.mssql_virtual_network_rule_mssqlserver_name
  resource_group_name = each.value.mssql_virtual_network_rule_mssqlserver_resource_group_name
}

resource "azurerm_mssql_virtual_network_rule" "mssql_virtual_network_rule" {
  for_each                             = var.mssql_virtual_network_rule_variables
  name                                 = each.value.mssql_virtual_network_rule_name
  server_id                            = data.azurerm_mssql_server.mssql_server_id[each.key].id
  subnet_id                            = data.azurerm_subnet.subnet_id[each.key].id
}
