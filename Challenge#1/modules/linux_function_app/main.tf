data "azurerm_storage_account" "storage_account" {
  for_each            = { for k, v in var.linux_function_app_variables : k => v if lookup(v, "linux_function_app_storage_account_name") != null }
  name                = each.value.linux_function_app_storage_account_name
  resource_group_name = each.value.linux_function_app_storage_account_resource_group_name
}

data "azurerm_subnet" "ip_restriction_subnet" {
  for_each = var.linux_function_app_variables
  name                 = each.value.linux_function_app_ip_restriction_subnet_name
  virtual_network_name = each.value.linux_function_app_ip_restriction_virtual_network_name
  resource_group_name  = each.value.linux_function_app_ip_restriction_virtual_network_resource_group_name
}

data "azurerm_service_plan" "service_plan" {
  for_each            = var.linux_function_app_variables
  name                = each.value.linux_function_app_service_plan_name
  resource_group_name = each.value.linux_function_app_service_plan_resource_group_name
}

#LINUX FUNCTION APP RESOURCE
resource "azurerm_linux_function_app" "linux_function_app" {
  for_each                           = var.linux_function_app_variables
  name                               = each.value.linux_function_app_name
  resource_group_name                = each.value.linux_function_app_resource_group_name
  location                           = each.value.linux_function_app_location
  service_plan_id                    = data.azurerm_service_plan.service_plan[each.key].id
  enabled                            = each.value.linux_function_app_enabled
  storage_account_name               = each.value.linux_function_app_storage_account_name
  storage_account_access_key         = data.azurerm_storage_account.storage_account[each.key].primary_access_key

  dynamic "identity" {
    for_each = each.value.linux_function_app_identity != null ? [1] : []
    content {
      type         = each.value.linux_function_app_identity.linux_function_app_identity_type
    }
  }

  dynamic "site_config" {
    for_each = each.value.linux_function_app_site_config == [] ? [] : [each.value.linux_function_app_site_config]
    content {
      always_on                                     = site_config.value.site_config_always_on
      dynamic "application_stack" {
        for_each = site_config.value.application_stack_enabled == false ? [] : [site_config.value.application_stack]
        content {
          python_version              = application_stack.value.application_stack_python_version
        }
      }
      dynamic "ip_restriction" {
        for_each = site_config.value.ip_restriction_enabled == false ? [] : [site_config.value.ip_restriction]
        content {
          name                      = ip_restriction.value.ip_restriction_name
          priority                  = ip_restriction.value.ip_restriction_priority
          virtual_network_subnet_id = data.azurerm_subnet.ip_restriction_subnet[each.key].id
        }
      }

    }
  }

}