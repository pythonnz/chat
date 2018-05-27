terraform {
  backend "swift" {
    region_name = "nz-hlz-1"

    container = "terraform-state/chat/"
  }
}

provider "openstack" {
  region = "nz-hlz-1"
}

#--------------------------------------------------------------
# Networking
#--------------------------------------------------------------
resource "openstack_networking_router_v2" "router" {
  name                = "${var.router_name}"
  external_network_id = "${var.external_network_id}"
}

resource "openstack_networking_network_v2" "private_net" {
  name           = "${var.network_name}"
  admin_state_up = "${var.admin_state_up}"
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = "${var.subnet_name}"
  network_id = "${openstack_networking_network_v2.private_net.id}"

  allocation_pools {
    start = "${var.pool_start}"
    end   = "${var.pool_end}"
  }

  enable_dhcp = "${var.enable_dchp}"
  cidr        = "${var.cidr}"
  ip_version  = "${var.ip_version}"
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet.id}"
}

#--------------------------------------------------------------
# Security Groups
#--------------------------------------------------------------
resource "openstack_networking_secgroup_v2" "base" {
  name        = "base"
  description = "Allow port 22 ingress and egress to internet"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.base.id}"
}

resource "openstack_networking_secgroup_rule_v2" "egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.base.id}"
}

# Synapes Homeserver Security Group
resource "openstack_networking_secgroup_v2" "synapse_homeserver" {
  name        = "synapse-homeserver"
  description = "Allow ports for synapse homeserver"
}

resource "openstack_networking_secgroup_rule_v2" "http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.synapse_homeserver.id}"
}

resource "openstack_networking_secgroup_rule_v2" "https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.synapse_homeserver.id}"
}

resource "openstack_networking_secgroup_rule_v2" "synapse_federation" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8448
  port_range_max    = 8448
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.synapse_homeserver.id}"
}

resource "openstack_compute_keypair_v2" "erp_deploy" {
  name = "${var.public_key_name}"
  public_key = "${var.public_key_value}"
}

#--------------------------------------------------------------
# Instances
#--------------------------------------------------------------
resource "openstack_compute_instance_v2" "synapse_homeserver" {
  name            = "${var.name}"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${openstack_compute_keypair_v2.erp_deploy.name}"
  security_groups = [
    "${openstack_networking_secgroup_v2.base.name}",
    "${openstack_networking_secgroup_v2.synapse_homeserver.name}"
  ]
}

resource "openstack_networking_floatingip_v2" "floating_ip" {
  pool = "public-net"
}

resource "openstack_compute_floatingip_associate_v2" "floating_ip" {
  floating_ip = "${openstack_networking_floatingip_v2.floating_ip.address}"
  instance_id = "${openstack_compute_instance_v2.synapse_homeserver.id}"
}

resource "openstack_blockstorage_volume_v2" "synapse_homeserver" {
  name = "synapse-homeserver-volume"
  size = "${var.volume_size}"
}

resource "openstack_compute_volume_attach_v2" "synapse_homeserver" {
  instance_id = "${openstack_compute_instance_v2.synapse_homeserver.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.synapse_homeserver.id}"
  device      = "${var.volume_device}"
}
