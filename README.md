# terraform-azurerm-dxnsg

Module to create a network security group in Microsoft Azure.
This module implements a hierarchical structure for network security group rules and is designed to pair with [terraform-azurerm-dxvnet](https://github.com/dustindortch/terraform-azurerm-dxvnet), which leads to fewer errors or misassociations of one list to another list incorrectly.

Associating network security groups is optionally supported within the module or can be facilitated separately.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.30.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_subnet_network_security_group_association.assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Location to deploy network security group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Network security group name. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name to deploy network security group. | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | Set of rules to include in network security group. | <pre>map(object({<br>    access                                     = string<br>    description                                = optional(string)<br>    destination_address_prefixes               = list(string)<br>    destination_application_security_group_ids = optional(list(string), [])<br>    destination_port_ranges                    = optional(list(string), ["*"])<br>    direction                                  = string<br>    priority                                   = number<br>    protocol                                   = optional(string, "*")<br>    source_address_prefixes                    = optional(list(string), ["*"])<br>    source_application_security_group_ids      = optional(list(string), ["*"])<br>    source_port_ranges                         = optional(list(string), ["*"])<br>  }))</pre> | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet IDs to attach network security group. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to network security group. | `map` | <pre>{<br>  "CreatedBy": "Terraform",<br>  "Module": "terraform-azurerm-dxnsg"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Network security group id |
| <a name="output_location"></a> [location](#output\_location) | Network security group location |
| <a name="output_name"></a> [name](#output\_name) | Network security group name |
| <a name="output_rules"></a> [rules](#output\_rules) | Network security group rules |
<!-- END_TF_DOCS -->