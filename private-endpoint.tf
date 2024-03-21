# database
resource "azurerm_private_endpoint" "example_db" {
  name                = "example-db"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example_privateendpoint.id

  private_service_connection {
    name                           = "example-db-privateserviceconnection"
    private_connection_resource_id = azurerm_mysql_flexible_server.example.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "example-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.example_db.id]
  }
}

resource "azurerm_private_dns_zone" "example_db" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example_db" {
  name                  = "example-db"
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.example_db.name
  virtual_network_id    = azurerm_virtual_network.example.id
}

# blob storage
resource "azurerm_private_endpoint" "example_bs" {
  name                = "example-bs"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example_privateendpoint.id

  private_service_connection {
    name                           = "example-bs-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.example.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "example-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.example_bs.id]
  }
}

resource "azurerm_private_dns_zone" "example_bs" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example_bs" {
  name                  = "example-bs"
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.example_bs.name
  virtual_network_id    = azurerm_virtual_network.example.id
}
