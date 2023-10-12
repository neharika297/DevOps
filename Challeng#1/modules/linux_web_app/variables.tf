#linux web app variables
variable "linux_web_app_variables" {
  type = map(object({
    linux_web_app_name                       = string      #(Required) The name which should be used for this Linux Web App. Changing this forces a new Linux Web App to be created.
    linux_web_app_location                   = string      #(Required) The Azure Region where the Linux Web App should exist. Changing this forces a new Linux Web App to be created.
    linux_web_app_resource_group_name        = string      #(Required) The name of the Resource Group where the Linux Web App should exist. Changing this forces a new Linux Web App to be created.
    linux_web_app_enabled                    = bool        #Defaults to true
    linux_web_app_https_only                 = bool        #(Optional) Should the Linux Web App require HTTPS connections. 
    app_service_plan_name                        = string #(Required) The name of the Service Plan that this Linux App Service will be created in for the service plan id .
    app_service_plan_resource_group_name         = string #(Required) The service plan resource group name  that this Linux App Service will be created in for the service plan id .
    linux_web_app_site_config = list(object({                                  #(Required) A site_config block as defined below.
      site_config_always_on                                     = bool         # (Optional) If this Linux Web App is Always On enabled. Defaults to true.
      site_config_minimum_tls_version                           = string       # (Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
    }))
  }))
}
