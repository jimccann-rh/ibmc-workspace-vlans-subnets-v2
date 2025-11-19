variable "ibmcloud_api_key" {
  type      = string
  sensitive = true
}

variable "iaas_classic_username" {
  type      = string
  sensitive = true
}

variable "iaas_classic_api_key" {
  type      = string
  sensitive = true
}

variable "project" {
  description = "Prefix to add to all resources for easier identification."
  type        = string
}

variable "vlan_quantity" {
  type = number
  default = 1
}

variable "vlan_quantity_disconnected" {
  type = number
  default = 0
}

variable "subnet_capacity" {
  type = number
  default = 128
}

variable "gateway_id" {
  type = number
}

variable "datacenter" {
  type = string
}

variable "router" {
  type = string
}

variable "vlan_tags" {
  type = list(string)
}

variable "vlan_tags_disconnected" {
  type = list(string)
}

variable "vlan_offset_name" {
  type = string
  default = "" 
}
