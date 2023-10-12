data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  for_each                        = var.key_vault_variables
  name                            = each.value.key_vault_name
  location                        = each.value.key_vault_location
  resource_group_name             = each.value.key_vault_resource_group_name
  enabled_for_disk_encryption     = each.value.key_vault_enabled_for_disk_encryption
  enabled_for_deployment          = each.value.key_vault_enabled_for_deployment
  enabled_for_template_deployment = each.value.key_vault_enabled_for_template_deployment
  enable_rbac_authorization       = each.value.key_vault_enable_rbac_authorization
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = each.value.key_vault_soft_delete_retention_days # other new features like this
  purge_protection_enabled        = each.value.key_vault_purge_protection_enabled
  sku_name                        = each.value.key_vault_sku_name
}

resource "azurerm_key_vault_access_policy" "default_access" {
  for_each                = var.key_vault_variables
  key_vault_id            = azurerm_key_vault.keyvault[each.key].id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = each.value.key_vault_object_id
  key_permissions         = each.value.key_vault_access_policy_key_permissions
  secret_permissions      = each.value.key_vault_access_policy_secret_permissions
}