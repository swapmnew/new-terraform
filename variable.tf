variable "tenant_username" {}
variable "tenant_password" {}
variable "tenant_name" {}
variable "openstack_auth_url" {}

variable "security_group_names" {
 type = list(string)
 default = [ "default" ] 
}

#variable "instance_count" {
#  type = number
#  default = 1
#}

#variable "security_group_names" {}
variable "INSTANCE_NAME" {}
variable "VOLUME_NAME" {}
variable "image_id" {}
variable "flavor_id" {}
variable "network_name" {}
#variable "ext-network" {}
variable "my_pool" {}
variable "volume_type" {}
variable "volume_size" {}
variable "availability_zone" {}
variable "floating_ip_address" {}

#output "Floating_IP_Of_MY_INSTANCE" {
#  value = openstack_compute_instance_v2.example_instance.floating_ip
#}

