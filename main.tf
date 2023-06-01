terraform {
  required_version = ">= 1.3.0"
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

resource "azurerm_network_security_rule" "rules" {
  for_each = var.rules

  name                                       = each.key
  access                                     = each.value.access
  description                                = each.value.description
  destination_address_prefix                 = length(each.value.destination_address_prefixes) == 0 ? each.value.destination_address_prefix : null
  destination_address_prefixes               = length(each.value.destination_address_prefixes) == 0 ? null : each.value.destination_address_prefixes
  destination_application_security_group_ids = each.value.destination_application_security_group_ids
  destination_port_range                     = length(each.value.destination_port_ranges) == 0 ? each.value.destination_port_range : null
  destination_port_ranges                    = length(each.value.destination_port_ranges) == 0 ? null : each.value.destination_port_ranges
  direction                                  = each.value.direction
  network_security_group_name                = azurerm_network_security_group.nsg.name
  priority                                   = each.value.priority
  protocol                                   = each.value.protocol
  resource_group_name                        = azurerm_network_security_group.nsg.resource_group_name
  source_address_prefix                      = length(each.value.source_address_prefixes) == 0 ? each.value.source_address_prefix : null
  source_address_prefixes                    = length(each.value.source_address_prefixes) == 0 ? null : each.value.source_address_prefixes
  source_application_security_group_ids      = each.value.source_application_security_group_ids
  source_port_range                          = length(each.value.source_port_ranges) == 0 ? each.value.source_port_range : null
  source_port_ranges                         = length(each.value.source_port_ranges) == 0 ? null : each.value.source_port_ranges
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each = var.subnets

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.nsg.id
}