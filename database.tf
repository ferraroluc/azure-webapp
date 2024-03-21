resource "random_password" "example" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_mysql_flexible_server" "example" {
  name                = "example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  administrator_login    = "exampleadmin"
  administrator_password = random_password.example.result

  backup_retention_days = 7
  sku_name              = "GP_Standard_D2ads_v5"
  version               = "5.7"

  storage {
    size_gb = 20
  }
}

resource "azurerm_mysql_flexible_server_configuration" "example_tls_version" {
  name                = "tls_version"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_flexible_server.example.name
  value               = "TLSv1,TLSv1.1,TLSv1.2"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "example" {
  name                = "Azure"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_flexible_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mysql_flexible_database" "example" {
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_flexible_server.example.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"

  lifecycle {
    prevent_destroy = true
  }
}
