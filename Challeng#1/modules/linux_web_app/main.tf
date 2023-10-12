#linux function app resource 
#data source for service paln
data "azurerm_service_plan" "app_service_plan" {
  for_each            = var.linux_web_app_variables
  name                = each.value.app_service_plan_name
  resource_group_name = each.value.app_service_plan_resource_group_name
}

resource "azurerm_linux_web_app" "linux_web_app" {
  for_each                        = var.linux_web_app_variables
  name                            = each.value.linux_web_app_name
  location                        = each.value.linux_web_app_location
  resource_group_name             = each.value.linux_web_app_resource_group_name
  enabled                         = each.value.linux_web_app_enabled
  https_only                      = each.value.linux_web_app_https_only
  service_plan_id = data.azurerm_service_plan.app_service_plan[each.key].id
  dynamic "site_config" {
    for_each = each.value.linux_web_app_site_config != null ? toset(each.value.linux_web_app_site_config) : []
    content {
      always_on                                     = site_config.value.site_config_always_on
      minimum_tls_version                           = site_config.value.site_config_minimum_tls_version
    }
}
}
