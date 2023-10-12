#RESOURCE GROUP VARIABLES
variable "resource_group_variables" {
  type = map(object({
    resource_group_name     = string      #(Required) Name of the Resource Group with which it should be created.
    resource_group_location = string      #(Required) The Azure Region where the Resource Group should exist.
    resource_group_tags     = map(string) #(Optional) A mapping of tags which should be assigned to the Resource Group.
  }))
}

#VNET variable
variable "virtual_network_variables" {
  type = map(object({
    virtual_network_name                    = string       #(Required) the name of the virtual network. Changing this forces a new resource to be created.
    virtual_network_location                = string       #(Required) the location/region where the virtual network is created. Changing this forces a new resource to be created.
    virtual_network_resource_group_name     = string       #(Required) the name of the resource group in which to create the virtual network.
    virtual_network_address_space           = list(string) #(Required) the address space that is used the virtual network. You can supply more than one address space.
  }))
}

#Subnet Variables
variable "subnet_variables" {
  type = map(object({
    subnet_name                                           = string       # (Required) The name of the subnet. Changing this forces a new resource to be created.
    subnet_resource_group_name                            = string       #(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created.
    subnet_virtual_network_name                           = string       #(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created.
    subnet_address_prefixes                               = list(string) #(Required) The address prefixes to use for the subnet.
    subnet_service_endpoints                              = list(string) #(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web.
    delegation = list(object({
      delegation_name            = string       #(Required) A name for this delegation.
      service_delegation_name    = string       # (Required) The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.LabServices/labplans,Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.Orbital/orbitalGateways, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StoragePool/diskPools, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, Microsoft.Web/serverFarms, NGINX.NGINXPLUS/nginxDeployments and PaloAltoNetworks.Cloudngfw/firewalls.
      service_delegation_actions = list(string) #(Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/publicIPAddresses/read,Microsoft.Network/virtualNetworks/read,Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
    }))
  }))
}




#KEY VAULT VARIABLES
variable "key_vault_variables" {
  type = map(object({
    key_vault_name                                  = string       #(Required) Specifies the name of the Key Vault, The name must be globally unique.
    key_vault_resource_group_name                   = string       #(Required) The name of the resource group in which to create the Key Vault.
    key_vault_location                              = string       #(Required) Specifies the supported Azure location where the resource exists.
    key_vault_enabled_for_disk_encryption           = bool         #(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.
    key_vault_enabled_for_deployment                = bool         #(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false
    key_vault_enabled_for_template_deployment       = bool         # (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false.
    key_vault_enable_rbac_authorization             = bool         #(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.
    key_vault_soft_delete_retention_days            = string       #(Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.
    key_vault_purge_protection_enabled              = bool         # (Optional) Is Purge Protection enabled for this Key Vault? Defaults to false.
    key_vault_sku_name                              = string       #(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium
    key_vault_object_id = string
    key_vault_access_policy_key_permissions = list(string)
    key_vault_access_policy_secret_permissions = list(string)
  }))
}

#APP SERVICE PLAN VARIABLES
variable "app_service_plan_variables" {
  type = map(object({
    app_service_plan_name                          = string      #(Required) The name which should be used for this Service Plan. Changing this forces a new AppService to be created.
    app_service_plan_location                      = string      #(Required) The Azure Region where the Service Plan should exist. Changing this forces a new AppService to be created.
    app_service_plan_os_type                       = string      #(Required) The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer.
    app_service_plan_resource_group_name           = string      #(Required) The name of the Resource Group where the AppService should exist. Changing this forces a new AppService to be created.
    app_service_plan_sku_name                      = string      #(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1.#Isolated SKUs (I1, I2, I3, I1v2, I2v2, and I3v2) can only be used with App Service Environments #Elastic and Consumption SKUs (Y1, EP1, EP2, and EP3) are for use with Function Apps.
  }))
}

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


#Storage Account
variable "storage_account_variables" {
  type = map(object({
    storage_account_name                                               = string #(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed.This must be unique across the entire Azure service, not just within the resource group.
    storage_account_resource_group_name                                = string #(Required) The name of the resource group in which to create the storage account.
    storage_account_location                                           = string #(Required) Specifies the supported Azure location where the resource exists. 
    storage_account_account_kind                                       = string #(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2.
    storage_account_account_tier                                       = string #(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    storage_account_account_replication_type                           = string #(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa.
  }))
}

# LINUX FUNCTION APP VARIABLES
variable "linux_function_app_variables" {
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

#MSSQL Server
variable "mssql_server_variables" {
  type = map(object({
    mssql_server_name                = string # (Required) The name of the Microsoft SQL Server. This needs to be globally unique within Azure.
    mssql_server_location            = string # (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    mssql_server_resource_group_name = string # (Required) The name of the resource group in which to create the Microsoft SQL Server.
    mssql_server_version             = string # (Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)

    # (Optional)
    mssql_server_azuread_administrator = object({
      azuread_administrator_login_email                 = string # (Required)  login username of the Azure AD Administrator
      azuread_administrator_object_id = string   # (Optional)  Specifies whether only AD Users and administrators can be used to login, or also local database users
    })

    mssql_server_administrator_login         = string # (Optional) The administrator login name for the new server. Required if azuread_administrator_azuread_authentication_only = false
    
    # (Optional) Required if it uses admin_login.
    
    mssql_server_generate_new_admin_password                         = bool   # Specify if new password need to be generated for login
    mssql_server_admin_credentials_key_vault_name                    = string # Key vault name in which admin credentials are stored
    mssql_server_admin_credentials_key_vault_resource_group_name     = string # Key vault resource group name
    mssql_server_generated_admin_password_key_vault_secret_name      = string # Specify if mssql_server_generate_new_admin_password = true. Secret key name to which generated password to be stored
  }))
}

#Mssql server virtual network rule
variable "mssql_virtual_network_rule_variables" {
  type = map(object({
    mssql_virtual_network_rule_name                                 = string #(Required)The name of the SQL virtual network rule. Changing this forces a new resource to be created.
    mssql_virtual_network_rule_mssqlserver_name                     = string #(Required)The resource ID of the SQL Server to which this SQL virtual network rule will be applied. Changing this forces a new resource to be created.
    mssql_virtual_network_rule_mssqlserver_resource_group_name      = string #(Required)The name of the resource group in which to create the mysql server virual network.
    mssql_virtual_network_rule_virtual_network_name                 = string #(Required)The vnet from which the SQL server will accept communications.
    mssql_virtual_network_rule_subnet_name                          = string #(Required)The ID of the subnet from which the SQL server will accept communications.
    mssql_virtual_network_rule_subnet_resource_group_name           = string #(Optional)The name of the resource group in which to create the subnet rg.   
  }))
}

# MSSQL Database
variable "mssql_database_variables" {
  type = map(object({
    mssql_database_name                                    = string #(Required) The name of the MS SQL Database. Changing this forces a new resource to be created.
    mssql_database_collation                               = string #(Optional) Specifies the collation of the database. Changing this forces a new resource to be created.
    mssql_database_license_type                            = string #(Optional) Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice.
    mssql_database_max_size_gb                             = number #(Optional) The max size of the database in gigabytes.
    mssql_database_read_scale                              = bool   #(Optional) If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases.
    mssql_database_sku_name                                = string #(Optional) Specifies the name of the SKU used by the database. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100. Changing this from the HyperScale service tier to another service tier will force a new resource to be created.
    mssql_database_zone_redundant                          = bool   #(Optional) Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases.
    mssql_database_mssql_server_name                       = string #(Required) The name of mssql server on which to create the database.
    mssql_database_mssql_server_resource_group_name        = string #(Required) The name of the resource group in which the mssql_server resides in.
    mssql_database_key_vault_name = string
    mssql_database_key_vault_resource_group_name = string
    mssql_database_admin_password_key_vault_secret_name = string
  }))
}