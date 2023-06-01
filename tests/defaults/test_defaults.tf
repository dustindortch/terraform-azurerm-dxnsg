terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.21.0"
    }
  }
}

provider "azurerm" {
  use_oidc = true
  features {}
}

locals {
  network_security_group_name = "nsg-test-network-security-group"
  resource_group_name         = "rg-test-network-security-group"
  location                    = "eastus"
  virtual_network_name        = "vnet-test-virtual-network"
  address_space               = ["10.0.1.0/24"]
}

module "vnet" {
  source = "github.com/dustindortch/terraform-azurerm-dxvnet"

  name                = local.virtual_network_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = local.address_space

  subnets = {
    "default" = {
      address_prefixes  = ["10.0.1.0/26"]
      service_endpoints = ["Microsoft.Sql", "Microsoft.Web"]

      enforce_private_link_service_network_policies = true
    }
    "GatewaySubnet" = {
      address_prefixes = ["10.0.1.64/26"]
    }
    "AzureFirewallSubnet" = {
      address_prefixes = ["10.0.1.128/26"]
    }
  }
}

locals {
  nsg_subnet_ids = { for k, v in module.vnet.subnets : k => v.id }
}

module "main" {
  source = "../.."

  name                = local.network_security_group_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  rules = {
    "DenySSH" = {
      access                     = "Deny"
      destination_address_prefix = "*"
      destination_port_ranges    = ["22"]
      direction                  = "Inbound"
      priority                   = 100
      protocol                   = "Tcp"
    }
  }

  subnets = local.nsg_subnet_ids # module.vnet.subnets.*.id
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.location
}