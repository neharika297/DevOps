#APP SERVICE VIRTUAL NETWORK SWIFT CONNECTION VARIABLES
variable "app_service_virtual_network_swift_connection_variables" {
  type = map(object({
    app_service_virtual_network_swift_connection_subnet_name                         = string #(Required) The Name of the subnet the app service will be associated to (the subnet must have a service_delegation configured for Microsoft.Web/serverFarms
    app_service_virtual_network_swift_connection_virtual_network_name                = string #(Required) Name of the Virtual Network in which the target subnet resides
    app_service_virtual_network_swift_connection_subnet_resource_group_name          = string #(Required) The Name of the Resource Group of the subnet the app service will be associated to (the subnet must have a service_delegation configured for Microsoft.Web/serverFarms
    app_service_virtual_network_swift_connection_target_resource_name                = string #(Required) The Name of the App Service or Function App to associate to the VNet. Changing this forces a new resource to be created.
    app_service_virtual_network_swift_connection_target_resource_resource_group_name = string #(Required) The Resource Group name of the App Service or Function App to associate to the VNet. Changing this forces a new resource to be created. 
  }))
}
