#Mssql server virtual network rule
variable "mssql_virtual_network_rule_variables" {
  type = map(object({
    mssql_virtual_network_rule_name                                 = string #(Required)The name of the SQL virtual network rule. Changing this forces a new resource to be created.
    mssql_virtual_network_rule_mssqlserver_name                     = string #(Required)The resource ID of the SQL Server to which this SQL virtual network rule will be applied. Changing this forces a new resource to be created.
    mssql_virtual_network_rule_mssqlserver_resource_group_name      = string #(Required)The name of the resource group in which to create the mysql server virual network.
    mssql_virtual_network_rule_virtual_network_name                 = string #(Required)The vnet from which the SQL server will accept communications.
    mssql_virtual_network_rule_subnet_name                          = string #(Required)The ID of the subnet from which the SQL server will accept communications.
    mssql_virtual_network_rule_subnet_resource_group_name           = string #(Optional)The name of the resource group in which to create the subnet rg.   
  }))
}