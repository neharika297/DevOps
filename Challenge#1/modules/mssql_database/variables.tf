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