# LINUX FUNCTION APP VARIABLES
variable "linux_function_app_variables" {
  description = "map of object of linux function app variables"
  type = map(object({
    linux_function_app_service_plan_name                = string #(Required) The name of the App Service Plan within which to create this Function App.
    linux_function_app_service_plan_resource_group_name = string #(Required) The resource group name of the App Service Plan within which to create this Function App.

    linux_function_app_storage_account_name                = string #(Optional) The backend storage account name which will be used by this Function App.
    linux_function_app_storage_account_resource_group_name = string #(Optional) The backend storage account resource group name which will be used by this Function App.

    linux_function_app_location                           = string #(Required) The Azure Region where the Linux Function App should exist.
    linux_function_app_name                               = string #(Required) The name which should be used for this Linux Function App.Limit the function name to 32 characters to avoid naming collisions. 
    linux_function_app_resource_group_name                = string #(Required) The name of the Resource Group where the Linux Function App should exist. 
    linux_function_app_enabled                       = bool   #(Optional) Is the Function App enabled?
    linux_function_app_ip_restriction_subnet_name = string
    linux_function_app_ip_restriction_virtual_network_name = string
    linux_function_app_ip_restriction_virtual_network_resource_group_name = string

    linux_function_app_identity = object({                          #(Optional) A identity block as defined below.
      linux_function_app_identity_type = string                     #(Required) Possible values could be "UserAssigned", "SystemAssigned", "SystemAssigned, UserAssigned"
    })
    linux_function_app_site_config = object({                            #(Required) A site_config block as defined below
      site_config_always_on                               = bool         #(Optional) If this Linux Web App is Always On enabled. Defaults to false.

      application_stack_enabled = bool                         #(Optional) Should linux function app application stack be enabled .
      application_stack = object({                             ## NOTE:- If this is set, there must not be an application setting FUNCTIONS_WORKER_RUNTIME.
        application_stack_python_version              = string #(Optional) The version of Python to run. Possible values include 3.6, 3.7, 3.8, and 3.9.
      })
      ip_restriction_enabled = bool                               #(Optional) should linux function app ip restriction be enabled.
      ip_restriction = object({                               ## NOTE:- One and only one of ip_address, service_tag or virtual_network_subnet_id must be specified.
        ip_restriction_name                              = string #(Optional) The name which should be used for this ip_restriction.
        ip_restriction_priority                          = string #(Optional) The priority value of this ip_restriction.
        ip_restriction_virtual_network_subnet_id_enabled = bool

  })
  })
}))
}