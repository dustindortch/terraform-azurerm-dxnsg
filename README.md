# terraform-azurerm-dxnsg

Module to create a network security group in Microsoft Azure.
This module implements a hierarchical structure for network security group rules and is designed to pair with [terraform-azurerm-dxvnet](https://github.com/dustindortch/terraform-azurerm-dxvnet), which leads to fewer errors or misassociations of one list to another list incorrectly.

Associating network security groups is optionally supported within the module or can be facilitated separately.
<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->