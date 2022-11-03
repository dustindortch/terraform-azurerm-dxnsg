output "id" {
  description = "Network security group id"
  value       = azurerm_network_security_group.nsg.id
}

output "name" {
  description = "Network security group name"
  value       = azurerm_network_security_group.nsg.name
}

output "location" {
  description = "Network security group location"
  value       = azurerm_network_security_group.nsg.location
}

output "rules" {
  description = "Network security group rules"
  value       = azurerm_network_security_rule.rules
}