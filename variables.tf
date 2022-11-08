variable "name" {
  type        = string
  description = "Network security group name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name to deploy network security group."
}

variable "location" {
  type        = string
  description = "Location to deploy network security group."
}

variable "tags" {
  description = "Tags to assign to network security group."
  default = {
    CreatedBy = "Terraform"
    Module    = "terraform-azurerm-dxnsg"
  }
}

variable "rules" {
  type = map(object({
    access                                     = string
    description                                = optional(string)
    destination_address_prefixes               = list(string)
    destination_application_security_group_ids = optional(list(string), [])
    destination_port_ranges                    = optional(list(string), ["*"])
    direction                                  = string
    priority                                   = number
    protocol                                   = optional(string, "*")
    source_address_prefixes                    = optional(list(string), ["*"])
    source_application_security_group_ids      = optional(list(string), ["*"])
    source_port_ranges                         = optional(list(string), ["*"])
  }))

  description = "Set of rules to include in network security group."
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "Subnet IDs to attach network security group."
}