#--------------------------------------------------------------
# Network
#--------------------------------------------------------------
variable "external_network_id" {}

variable "router_name" {
  default = "border-router"
}

variable "network_name" {
  default = "private-net"
}

variable "admin_state_up" {
  default = "true"
}

variable "subnet_name" {
  default = "private-subnet"
}

variable "pool_start" {
  default = "10.0.0.10"
}

variable "pool_end" {
  default = "10.0.0.200"
}

variable "enable_dchp" {
  default = "true"
}

variable "cidr" {
  default = "10.0.0.0/24"
}

variable "ip_version" {
  default = "4"
}

variable "public_key_name" {}
variable "public_key_value" {}

#--------------------------------------------------------------
# Instances
#--------------------------------------------------------------
variable "name" {}
variable "image" {}
variable "flavor" {}

#--------------------------------------------------------------
# Volume
#--------------------------------------------------------------
variable "volume_size" {}
variable "volume_device" {}
