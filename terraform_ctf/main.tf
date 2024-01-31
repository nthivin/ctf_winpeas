terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

data "template_file" "server1_user_data" {
  template = file("${path.module}/cloud_init_server1.cfg")

}
data "template_file" "server2_user_data" {
  template = file("${path.module}/cloud_init_server2.cfg")

}


# Use CloudInit ISO to add ssh-key to the instance


resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit.iso"
  user_data      = data.template_file.server1_user_data.rendered
}

resource "libvirt_cloudinit_disk" "server2init" {
  name           = "server2init.iso"
  user_data      = data.template_file.server2_user_data.rendered
}




# Define the disks
resource "libvirt_volume" "ctf-server1-instance" {
  name   = "ctf-server1-instance-${var.instance_id}"
  source = "./ctf-server1.qcow2"
}

resource "libvirt_volume" "ctf-server2-instance" {
  name   = "ctf-server2-instance-${var.instance_id}"
  source = "./ctf-server2.qcow2"
}

# resource "libvirt_volume" "ctf-windows-server-instance" {
#   name   = "ctf-windows-server-instance-${var.instance_id}"
#   source = "./ctf-windows-server.qcow2"
# }



# Define the network
resource "libvirt_network" "ctf-network" {
  name = "ctf-network-${var.instance_id}"
  mode = "nat"
  addresses = ["10.105.${var.instance_id}.0/24"]
}


# Define the virtual machines
resource "libvirt_domain" "ctf-server1-instance" {
  name   = "ctf-server1-instance-${var.instance_id}"
  memory = 2048
  vcpu   = 2

  cloudinit = libvirt_cloudinit_disk.commoninit.id


  network_interface {
    network_name = "ctf-network-${var.instance_id}"
    addresses = ["10.105.${var.instance_id}.5"]
  }

  disk {
    volume_id = "${libvirt_volume.ctf-server1-instance.id}"
  }


  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }


}






resource "libvirt_domain" "ctf-server2-instance" {
  name   = "ctf-server2-instance-${var.instance_id}"
  memory = 2048
  vcpu   = 2

  cloudinit = libvirt_cloudinit_disk.server2init.id

  network_interface {
    network_name = "ctf-network-${var.instance_id}"
    addresses = ["10.105.${var.instance_id}.6"]
  }

  disk {
    volume_id = "${libvirt_volume.ctf-server2-instance.id}"
  }


  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "0"
  }

  graphics {
    type           = "spice"
    listen_type    = "address"
    autoport = true
  }
}


# resource "libvirt_domain" "ctf-windows-server-instance" {
#   name   = "ctf-windows-server-instance-${var.instance_id}"
#   memory = 2048
#   vcpu   = 2


#   network_interface {
#     network_name = "ctf-network-${var.instance_id}"
#     addresses = ["10.105.${var.instance_id}.7"]
#   }

#   disk {
#     volume_id = "${libvirt_volume.ctf-windows-server-instance.id}"
#   }


#   console {
#     type = "pty"
#     target_type = "serial"
#     target_port = "0"
#   }

#   graphics {
#     type = "spice"
#     listen_type = "address"
#     autoport = true
#   }


# }

variable "instance_id" {
  type = number
}

# Output Server IP
output "server1_ip" {
  value = "${libvirt_domain.ctf-server1-instance.network_interface.0.addresses}"
}
output "server2_ip" {
  value = "${libvirt_domain.ctf-server2-instance.network_interface.0.addresses}"
}



# # Define the firewall rules for port 80
# resource "libvirt_domain_firewall_rule" "ctf-server1_firewall" {
#   domain = libvirt_domain.ctf-server1.name

#   rule {
#     type      = "ingress"
#     port_min  = 80
#     port_max  = 80
#     protocol  = "tcp"
#     action    = "accept"
#   }
# }

# resource "libvirt_domain_firewall_rule" "ctf-server2_firewall" {
#   domain = libvirt_domain.ctf-server2.name

#   rule {
#     type      = "ingress"
#     port_min  = 80
#     port_max  = 80
#     protocol  = "tcp"
#     action    = "accept"
#   }
# }

