locals {
  generate_new_password   = { for k, v in var.mssql_server_variables : k => v if(lookup(v, "mssql_server_generate_new_admin_password", false) == true) }
}

data "azurerm_key_vault" "key_vault_id" {
  for_each            = var.mssql_server_variables
  name                = each.value.mssql_server_admin_credentials_key_vault_name
  resource_group_name = each.value.mssql_server_admin_credentials_key_vault_resource_group_name
}


#Generate random password
resource "random_password" "password" {
  for_each    = local.generate_new_password
  length      = 12
  special     = true
  lower       = true
  upper       = true
  numeric     = true
  min_lower   = 4
  min_upper   = 4
  min_numeric = 2
  min_special = 2
}

#Add the newly created login and password as a secret to a key vault for admin login purpose

resource "azurerm_key_vault_secret" "generated_password_key_vault_secret" {
  for_each     = local.generate_new_password
  name         = each.value.mssql_server_generated_admin_password_key_vault_secret_name
  value        = random_password.password[each.key].result
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
}

resource "azurerm_mssql_server" "mssql_server" {
  for_each = var.mssql_server_variables
  name                = each.value.mssql_server_name
  resource_group_name = each.value.mssql_server_resource_group_name
  location            = each.value.mssql_server_location
  version             = each.value.mssql_server_version
  dynamic "azuread_administrator" {
    for_each = each.value.mssql_server_azuread_administrator.azuread_administrator_login_email != null ? [1] : []
    content {
      login_username              = each.value.mssql_server_azuread_administrator.azuread_administrator_login_email
      object_id                   = each.value.mssql_server_azuread_administrator.azuread_administrator_object_id
    }
  }

  administrator_login                  = each.value.mssql_server_administrator_login
  administrator_login_password         = azurerm_key_vault_secret.generated_password_key_vault_secret[each.key].value

}