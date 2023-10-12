#RG
module "resource_group" {
  source = "../modules/resource_group"
  resource_group_variables = var.resource_group_variables
}

#VNET  
module "virtual_network" {
  source = "../modules/virtual_network"
  virtual_network_variables = var.virtual_network_variables
  depends_on = [ module.resource_group ]
}

#Subnet
module "subnet" {
  source = "../modules/subnet"
  subnet_variables = var.subnet_variables
  depends_on = [ module.virtual_network ]
}

#KV
module "key_vault" {
  source = "../modules/key_vault"
  key_vault_variables = var.key_vault_variables
  depends_on = [ module.resource_group ]
}

#Mysql Server
module "mssql_server" {
  source = "../modules/mssql_server"
  mssql_server_variables = var.mssql_server_variables
  depends_on = [ module.key_vault, module.subnet ]
}

module "mssql_virtual_network_rule" {
  source = "../modules/mssql_virtual_network_rule"
  mssql_virtual_network_rule_variables = var.mssql_virtual_network_rule_variables
  depends_on = [ module.mssql_server ]
}

#Mysql DB
module "mssql_database" {
  source = "../modules/mssql_database"
  mssql_database_variables = var.mssql_database_variables
  depends_on = [ module.mssql_server ]
}

#ASP
module "app_service_plan" {
  source = "../modules/app_service_plan"
  app_service_plan_variables = var.app_service_plan_variables
  depends_on = [ module.resource_group ]
}

#Linux Webapp
module "linux_web_app" {
  source = "../modules/linux_web_app"
  linux_web_app_variables = var.linux_web_app_variables
  depends_on = [ module.app_service_plan ]
}

#SA
module "storage_account" {
  source = "../modules/storage_account"
  storage_account_variables = var.storage_account_variables
  depends_on = [ module.resource_group ]
}

#Linux Function App
module "linux_function_app" {
  source = "../modules/linux_function_app"
  linux_function_app_variables = var.linux_function_app_variables
  depends_on = [ module.storage_account ]
}

#VNET Swift Connection
module "app_service_virtual_network_swift_connection" {
  source = "../modules/app_service_virtual_network_swift_connection/v1.2.0"
  app_service_virtual_network_swift_connection_variables = var.app_service_virtual_network_swift_connection_variables
  depends_on = [ module.linux_function_app, module.linux_web_app ]
}