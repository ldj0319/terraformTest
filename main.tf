provider "azurerm" {
  
}
module "my_rg_set" {
    source = "./rg"

    resource_groups   = var.rg_list
    prefix            = var.prefix
    location          = var.location
    tags              = var.tags
  
}

module "my_nsg_module" {
    source = "./nsg"

    name                = var.nsg_name
    location            = var.location
    rg                  = module.my_rg_set.names
    tags                = var.tags
}

module "my_network" {
    source = "./network"

    Vnet_name               = var.Vnet_name
    subnet_prefix           = var.subnet_prefix
    subnet_name             = var.subnet_name
    route_table_name        = var.route_table_name
    network_interface_name  = var.network_interface_name
    virtual_machine_name    = var.virtual_machine_name
    location                = var.location  
    tags                    = var.tags
    rg                      = module.my_rg_set.names["rg1"]
}