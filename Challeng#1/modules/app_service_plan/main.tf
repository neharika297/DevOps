resource "azurerm_service_plan" "app_service_plan" {
  for_each                     = var.app_service_plan_variables
  name                         = each.value.app_service_plan_name
  location                     = each.value.app_service_plan_location
  os_type                      = each.value.app_service_plan_os_type
  resource_group_name          = each.value.app_service_plan_resource_group_name
  sku_name                     = each.value.app_service_plan_sku_name
}
