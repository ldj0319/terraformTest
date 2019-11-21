variable "location" {
    description = "Where to deploy my resources"
    default = "Australia East"
}

variable "resource_group_name" {
    description = "Name of the resource group"
    type = string
  
}

variable "tags" {
    description = "Map of the tags to be applied"
}

variable "Vnet_name" {
    description = "Name of the Vnet"
}

variable "nsg_name" {
    description = "Name of the network_security_group"
}

variable "rg_list" {
  
}

variable "prefix" {
  
}

variable "subnet_prefix" {
  
}

variable "subnet_name" {
  
}

variable "route_table_name" {
  
}

variable "network_interface_name" {
  
}

variable "virtual_machine_name" {
  
}

