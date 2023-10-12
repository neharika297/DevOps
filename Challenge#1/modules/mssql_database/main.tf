data "azurerm_mssql_server" "mssql_server" {
  for_each            = var.mssql_database_variables
  name                = each.value.mssql_database_mssql_server_name
  resource_group_name = each.value.mssql_database_mssql_server_resource_group_name
}

data "azurerm_key_vault" "key_vault_id" {
  for_each            = var.mssql_database_variables
  name                = each.value.mssql_database_key_vault_name
  resource_group_name = each.value.mssql_database_key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "mysql_password" {
  for_each            = var.mssql_database_variables
  name                = each.value.mssql_database_admin_password_key_vault_secret_name
  key_vault_id        = data.azurerm_key_vault.key_vault_id[each.key].id
}

# MSSQL Database
resource "azurerm_mssql_database" "mssql_database" {
  for_each                            = var.mssql_database_variables
  name                                = each.value.mssql_database_name
  server_id                           = data.azurerm_mssql_server.mssql_server[each.key].id
  collation                           = each.value.mssql_database_collation
  license_type                        = each.value.mssql_database_license_type
  max_size_gb                         = each.value.mssql_database_max_size_gb
  read_scale                          = each.value.mssql_database_read_scale
  sku_name                            = each.value.mssql_database_sku_name
  zone_redundant                      = each.value.mssql_database_zone_redundant
}

resource "azurerm_key_vault_secret" "sql_connection_string" {
  for_each = var.mssql_database_variables
  name = "db-conn-str"
  value = "Driver={ODBC Driver 18 for SQL Server};Server=tcp:${each.value.mssql_database_mssql_server_name}.database.windows.net,1433;Database=${each.value.mssql_database_name};Uid=tssqladmin;Pwd=${data.azurerm_key_vault_secret.mysql_password[each.key].value};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}