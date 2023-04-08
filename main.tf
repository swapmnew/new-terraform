resource "openstack_blockstorage_volume_v2" "VOLUME_NAME" {
  name = var.VOLUME_NAME
  size = var.volume_size
  #image_id    = "${var.image_id}"
  volume_type = var.volume_type
  #availability_zone = "${var.availability_zone}"
}

resource "openstack_compute_instance_v2" "INSTANCE_NAME" {
  name      = var.INSTANCE_NAME 
  image_id  = var.image_id
  flavor_id = var.flavor_id
  key_pair  = "cloud"
  security_groups = var.security_group_names

  network {
    name = var.network_name
  }
}

resource "openstack_compute_volume_attach_v2" "attached" {
  instance_id = openstack_compute_instance_v2.INSTANCE_NAME.id
  volume_id   = openstack_blockstorage_volume_v2.VOLUME_NAME.id
}


resource "openstack_compute_floatingip_associate_v2" "my_pool" {
  floating_ip = var.floating_ip_address
  instance_id = openstack_compute_instance_v2.INSTANCE_NAME.id

  provisioner "file" {
    source      = "/tmp/sub_tasks/"
    destination = "/tmp/"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u cloud-user -i '${var.floating_ip_address}', --private-key /tmp/sub_tasks/cloud.pem -e 'pub_key=/tmp/sub_tasks/cloud.pem' main.yml"
  }
  connection {
    type        = "ssh"
    host        = "${var.floating_ip_address}"
    user        = "cloud-user"
    private_key = file("/u02/terraform/anssible-scripts/cloud.pem")
    timeout     = "4m"
  }

}

