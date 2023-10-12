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