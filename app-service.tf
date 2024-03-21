resource "azurerm_service_plan" "example" {
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku_name            = "B2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "example" {
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }
  }

  https_only                = true
  virtual_network_subnet_id = azurerm_subnet.example_webapp.id

  app_settings = {
    WEBSITE_TIME_ZONE = "Argentina Standard Time"
  }

  connection_string {
    name  = "mysql_database"
    type  = "MySql"
    value = "Server=\"${azurerm_mysql_flexible_server.example.name}.${azurerm_private_dns_zone.example_db.name}\";UserID=\"${azurerm_mysql_flexible_server.example.administrator_login}\";Password=\"${azurerm_mysql_flexible_server.example.administrator_password}\";Database=\"${azurerm_mysql_flexible_database.example.name}\";SslMode=Required;"
  }

  connection_string {
    name  = "blob_storage"
    type  = "Custom"
    value = "DefaultEndpointsProtocol=https;AccountName=${azurerm_storage_account.example.name};AccountKey=${azurerm_storage_account.example.primary_access_key};EndpointSuffix=core.windows.net"
  }
}
