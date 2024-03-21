resource "azurerm_app_service_custom_hostname_binding" "example" {
  hostname            = var.fqdn
  app_service_name    = azurerm_windows_web_app.example.name
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_app_service_managed_certificate" "example" {
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.example.id
}

resource "azurerm_app_service_certificate_binding" "example" {
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.example.id
  certificate_id      = azurerm_app_service_managed_certificate.example.id
  ssl_state           = "SniEnabled"
}
