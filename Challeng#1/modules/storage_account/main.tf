resource "azurerm_storage_account" "storage_account" {
  for_each                          = var.storage_account_variables
  name                              = each.value.storage_account_name
  resource_group_name               = each.value.storage_account_resource_group_name
  location                          = each.value.storage_account_location
  account_kind                      = each.value.storage_account_account_kind
  account_tier                      = each.value.storage_account_account_tier
  account_replication_type          = each.value.storage_account_account_replication_type
  
  
}