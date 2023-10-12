#RG
resource_group_variables = {
  "resource_group_1" = {
    resource_group_name     = "devopsRG"      
    resource_group_location = "westus"      
    resource_group_tags     = {
        CreatedBy = "DevOps Team"
        Department = "Cloud"
    }
  }
}

#VNET
virtual_network_variables = {
  "virtual_network_1" = {
    virtual_network_name                    = "vnet01"       
    virtual_network_location                = "westus"       
    virtual_network_resource_group_name     = "devopsRG"       
    virtual_network_address_space           = ["10.0.0.0/16"]
      }
}

#Subent
subnet_variables = {
  "subnet_frontend" = {
    subnet_name                                           = "frontend-subnet"      
    subnet_resource_group_name                            = "devopsRG"       
    subnet_virtual_network_name                           = "vnet01"       
    subnet_address_prefixes                               = ["10.0.1.0/26"]
    subnet_service_endpoints = ["Microsoft.Web"] 
    delegation = [{
      delegation_name            = "subnet_delegation"       
      service_delegation_name    = "Microsoft.Web/serverFarms"       
      service_delegation_actions = ["Microsoft.Network/publicIPAddresses/read","Microsoft.Network/virtualNetworks/read","Microsoft.Network/networkinterfaces/*","Microsoft.Network/virtualNetworks/subnets/action","Microsoft.Network/virtualNetworks/subnets/join/action","Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action","Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] 
    }]
  }
  "subnet_backend" = {
    subnet_name                                           = "backend-subnet"      
    subnet_resource_group_name                            = "devopsRG"       
    subnet_virtual_network_name                           = "vnet01"       
    subnet_address_prefixes                               = ["10.0.2.0/26"] 
    subnet_service_endpoints                              = ["Microsoft.Sql"]
    delegation = [{
      delegation_name            = "subnet_delegation"       
      service_delegation_name    = "Microsoft.Web/serverFarms"       
      service_delegation_actions = ["Microsoft.Network/publicIPAddresses/read","Microsoft.Network/virtualNetworks/read","Microsoft.Network/networkinterfaces/*","Microsoft.Network/virtualNetworks/subnets/action","Microsoft.Network/virtualNetworks/subnets/join/action","Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action","Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] 
    }]
  }
}

#ASP
app_service_plan_variables = {
  "app_service_plan_frontend" = {
    app_service_plan_name                          = "asp_frontend"      
    app_service_plan_location                      = "westus"      
    app_service_plan_os_type                       = "Linux"      
    app_service_plan_resource_group_name           = "devopsRG"      
    app_service_plan_sku_name                      = "B1"      
  }
  "app_service_plan_backend" = {
    app_service_plan_name                          = "asp_backend"      
    app_service_plan_location                      = "westus"      
    app_service_plan_os_type                       = "Linux"      
    app_service_plan_resource_group_name           = "devopsRG"      
    app_service_plan_sku_name                      = "B1"      
  }
}

#Linux web app
linux_web_app_variables = {
  "frontend_webapp" = {
    linux_web_app_name                       = "frontend-linux-webapp"      
    linux_web_app_location                   = "westus"     
    linux_web_app_resource_group_name        = "devopsRG"
    app_service_plan_name                    = "asp_frontend" 
    app_service_plan_resource_group_name     = "devopsRG"  
    linux_web_app_enabled                    = true        
    linux_web_app_https_only                 = true        #(Optional) Should the Linux Web App require HTTPS connections. 
    linux_web_app_site_config = [{                                  
      site_config_always_on                                     = true         # (Optional) If this Linux Web App is Always On enabled. Defaults to true.
      site_config_minimum_tls_version                           = "1.2"       # (Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2. 
    }]
  }
}

#SA
storage_account_variables = {
  "storage_account" = {
    storage_account_name                                               = "storageaccount0015996" 
    storage_account_resource_group_name                                = "devopsRG" 
    storage_account_location                                           = "westus"  
    storage_account_account_kind                                       = "StorageV2" 
    storage_account_account_tier                                       = "Standard" 
    storage_account_account_replication_type                           = "LRS"   
  }
}

#Linux function app
linux_function_app_variables = {
  "linux_function_app_backend" = {
    linux_function_app_service_plan_name                = "asp_backend" 
    linux_function_app_service_plan_resource_group_name = "devopsRG" 
    linux_function_app_storage_account_name                = "storageaccount0015996" 
    linux_function_app_storage_account_resource_group_name = "devopsRG" 
    linux_function_app_location                           = "westus" 
    linux_function_app_name                               = "backend-linux-fucntionapp" 
    linux_function_app_resource_group_name                = "devopsRG"  
    linux_function_app_enabled                       = true   
    linux_function_app_ip_restriction_subnet_name = "frontend-subnet"
    linux_function_app_ip_restriction_virtual_network_name = "vnet01"
    linux_function_app_ip_restriction_virtual_network_resource_group_name = "devopsRG"

    linux_function_app_identity = {                          
      linux_function_app_identity_type = "SystemAssigned"                     
    }
    linux_function_app_site_config = {                            
      site_config_always_on                               = true         

      application_stack_enabled = true                         
      application_stack = {                             
        application_stack_python_version              = 3.8 
      }
      ip_restriction_enabled = true                               
      ip_restriction = {                               
        ip_restriction_name                              = "Frontend Access" 
        ip_restriction_priority                          = "100" 
        ip_restriction_virtual_network_subnet_id_enabled = true

  }
  }
}
  }

#VNET Connection
app_service_virtual_network_swift_connection_variables = {
  "frontend_vnet_integration" = {
    app_service_virtual_network_swift_connection_subnet_name                         = "frontend-subnet" 
    app_service_virtual_network_swift_connection_virtual_network_name                = "vnet01" 
    app_service_virtual_network_swift_connection_subnet_resource_group_name          = "devopsRG" 
    app_service_virtual_network_swift_connection_target_resource_name                = "frontend-linux-webapp" 
    app_service_virtual_network_swift_connection_target_resource_resource_group_name = "devopsRG" 
  }
  "backend_vnet_integration" = {
    app_service_virtual_network_swift_connection_subnet_name                         = "backend-subnet" 
    app_service_virtual_network_swift_connection_virtual_network_name                = "vnet01" 
    app_service_virtual_network_swift_connection_subnet_resource_group_name          = "devopsRG" 
    app_service_virtual_network_swift_connection_target_resource_name                = "backend-linux-fucntionapp" 
    app_service_virtual_network_swift_connection_target_resource_resource_group_name = "devopsRG" 
  }
}

key_vault_variables = {
  "key_vault" = {
    key_vault_name                                  = "keyvault1015891"       
    key_vault_resource_group_name                   = "devopsRG"       
    key_vault_location                              = "westus"       
    key_vault_enabled_for_disk_encryption           = false         
    key_vault_enabled_for_deployment                = true         
    key_vault_enabled_for_template_deployment       = true
    key_vault_soft_delete_retention_days            = "7"       
    key_vault_purge_protection_enabled              = false         
    key_vault_sku_name                              = "standard"  
    key_vault_enable_rbac_authorization = false  
    key_vault_object_id                  = "c6e3fd41-2ccf-43f9-ac0e-8ca8772d496a" 
    key_vault_access_policy_key_permissions = ["Get","List"]
    key_vault_access_policy_secret_permissions = ["Get", "Set", "List", "Delete", "Recover", "Backup", "Restore", "Purge"]  
  }        
}

mssql_server_variables = {
  "mssql_server" = {
    mssql_server_name                = "mssqlserver23658" 
    mssql_server_location            = "westus" 
    mssql_server_resource_group_name = "devopsRG" 
    mssql_server_version             = "12.0" 

    # (Optional)
    mssql_server_azuread_administrator = {
      azuread_administrator_login_email                 = "AzureAD Admin" 
      azuread_administrator_object_id = "1bf6a4dd-db22-4ead-96b6-b9d849ed8166"   
    }

    mssql_server_administrator_login         = "mssqladmin"   

    # (Optional) Required if it uses admin_login.
    
    mssql_server_generate_new_admin_password                         = true   
    mssql_server_admin_credentials_key_vault_name                    = "keyvault1015891" 
    mssql_server_admin_credentials_key_vault_resource_group_name     = "devopsRG" 
    mssql_server_generated_admin_password_key_vault_secret_name      = "mssqlpassword" 
  }
}

#SQL VNET Rule
mssql_virtual_network_rule_variables = {
  "Allow_backend" = {
    mssql_virtual_network_rule_name                                 = "backend_sql_vnet_rule"
    mssql_virtual_network_rule_mssqlserver_name                     = "mssqlserver23658" 
    mssql_virtual_network_rule_mssqlserver_resource_group_name      = "devopsRG" 
    mssql_virtual_network_rule_virtual_network_name                 = "vnet01" 
    mssql_virtual_network_rule_subnet_name                          = "backend-subnet" 
    mssql_virtual_network_rule_subnet_resource_group_name           = "devopsRG"    
  }
}

#MSSQL DB
mssql_database_variables = {
  "mssql_database" = {
    mssql_database_name                                    = "mssqldb01" 
    mssql_database_collation                               = "SQL_Latin1_General_CP1_CI_AS" 
    mssql_database_license_type                            = "LicenseIncluded" 
    mssql_database_max_size_gb                             = null
    mssql_database_read_scale                              = false    
    mssql_database_zone_redundant                          = false
    mssql_database_sku_name                                = "S0"   
    mssql_database_mssql_server_name                       = "mssqlserver23658"
    mssql_database_mssql_server_resource_group_name        = "devopsRG" 
    mssql_database_key_vault_name                          = "keyvault1015891"
    mssql_database_key_vault_resource_group_name           = "devopsRG"
    mssql_database_admin_password_key_vault_secret_name    = "mssqlpassword"
  }
}