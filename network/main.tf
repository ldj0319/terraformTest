resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = var.Vnet_name
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = var.rg
    tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
    name                 = var.subnet_name
    resource_group_name  = var.rg
    virtual_network_name = var.Vnet_name
    address_prefix       = var.subnet_prefix
}

resource "azurerm_network_interface" "test" {
    name                = var.network_interface_name
    location            = var.location
    resource_group_name = var.rg

    ip_configuration {
        name                          = "testconfiguration1"
        subnet_id                     = "${azurerm_subnet.subnet.id}"
        private_ip_address_allocation = "Dynamic"
    }
    tags = var.tags
}

resource "azurerm_route_table" "test" {
    name                          = var.route_table_name
    location                      = var.location
    resource_group_name           = var.rg
    disable_bgp_route_propagation = false

    route {
        name           = "route1"
        address_prefix = "10.1.0.0/16"
        next_hop_type  = "vnetlocal"
    }
    tags = var.tags
}

resource "azurerm_virtual_machine" "main" {
    name                  = var.virtual_machine_name
    location              = var.location
    resource_group_name   = var.rg
    network_interface_ids = ["${azurerm_network_interface.test.id}"]
    vm_size               = "Standard_DS1_v2"

    #delete the OS & data disks automatically when deleting the VM
    delete_os_disk_on_termination = true
    delete_data_disks_on_termination = true

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
    storage_os_disk {
        name              = "jae_osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    os_profile {
        computer_name  = "hostname"
        admin_username = "jaelee"
        admin_password = "TheInstillerty!"
    }
    os_profile_linux_config {
        disable_password_authentication = false
    }
    tags = var.tags
}
