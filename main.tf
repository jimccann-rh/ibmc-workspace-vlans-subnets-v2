terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
  }
}

provider "ibm" {
  iaas_classic_username = var.iaas_classic_username
  iaas_classic_api_key  = var.iaas_classic_api_key
}

resource "ibm_network_vlan" "vlans" {
  count = var.vlan_quantity

  name            = "${var.project}_vlan_connect_${var.vlan_offset_name}${count.index}"
  datacenter      = var.datacenter
  router_hostname = var.router
  type            = "PRIVATE"
  tags = var.vlan_tags
}


resource "ibm_network_gateway_vlan_association" "gateway_vlan_association" {
  count = var.vlan_quantity

  gateway_id      = var.gateway_id
  network_vlan_id = ibm_network_vlan.vlans[count.index].id
  bypass          = false
}


resource "ibm_subnet" "portable_subnet" {
  count = var.vlan_quantity

  type       = "Portable"
  private    = true
  ip_version = 4
  capacity   = var.subnet_capacity
  vlan_id    = ibm_network_vlan.vlans[count.index].id
  notes      = "${var.project}_vlan_connected_${var.vlan_offset_name}${count.index}"
  tags = var.vlan_tags

  //User can increase timeouts
  timeouts {
    create = "45m"
  }
}

#disconnected

resource "ibm_network_vlan" "vlans_disconnected" {
  count = var.vlan_quantity_disconnected

  name            = "${var.project}_vlan_disconnect_${count.index}"
  datacenter      = var.datacenter
  router_hostname = var.router
  type            = "PRIVATE"
  tags = var.vlan_tags_disconnected
}


resource "ibm_network_gateway_vlan_association" "gateway_vlan_association_disconnected" {
  count = var.vlan_quantity_disconnected

  gateway_id      = var.gateway_id
  network_vlan_id = ibm_network_vlan.vlans_disconnected[count.index].id
  bypass          = false
}


resource "ibm_subnet" "portable_subnet_disconnected" {
  count = var.vlan_quantity_disconnected

  type       = "Portable"
  private    = true
  ip_version = 4
  capacity   = var.subnet_capacity
  vlan_id    = ibm_network_vlan.vlans_disconnected[count.index].id
  notes      = "${var.project}_vlan_disconnected_${count.index}"
  tags = var.vlan_tags_disconnected

  //User can increase timeouts
  timeouts {
    create = "45m"
  }
}
                                       


