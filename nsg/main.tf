resource "azurerm_network_security_group" "myNSG" {
    for_each = var.rg
        resource_group_name = "${each.value}"
        name                = var.name
        location            = var.location
        tags                = var.tags
}