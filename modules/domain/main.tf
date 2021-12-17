terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "0.6.11"
    }
  }
}

resource "libvirt_cloudinit_disk" "lb_cloud-init" {
  name           = "${var.domain_lb_hostname}_cloudinit.iso"
  user_data      = data.template_file.lb_user_data.rendered
  network_config = data.template_file.lb_network_config.rendered
  pool           = libvirt_pool.domain_pool.name
}

data "template_file" "lb_user_data" {
  template = file("${path.module}/templates/lb_cloud_init.cfg")
  vars     = {
    domain_user    = var.domain_user
    user_ssh_key   = var.user_ssh_key
    node_name      = var.domain_lb_hostname
    upstream_ip    = var.domain_node_ip
    ns_search      = var.domain_search
    node_ns        = var.domain_node_ns
  }
}

resource "libvirt_cloudinit_disk" "cloud-init" {
  count          = var.domain_count
  name           = "${var.domain_hostname}${count.index}_cloudinit.iso"
  user_data      = data.template_file.user_data[count.index].rendered
  network_config = data.template_file.network_config[count.index].rendered
  pool           = libvirt_pool.domain_pool.name
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/cloud_init.cfg")
  vars = {
    domain_user          = var.domain_user
    user_ssh_key         = var.user_ssh_key
    node_name            = "${var.domain_hostname}${count.index}"
    ns_search            = var.domain_search
    node_ns              = var.domain_node_ns
    remote_repo          = var.remote_repo
  }
  count = var.domain_count
}

data "template_file" "network_config" {
  template  = file("${path.module}/templates/network_config.cfg")
  vars  = {
    node_ip   = "${var.domain_node_ip}${count.index}"
    node_gw   = var.domain_node_gw
    node_ns   = var.domain_node_ns
    ns_search = var.domain_search
  }
  count = "${var.domain_count}"
}

data "template_file" "lb_network_config" {
  template  = file("${path.module}/templates/lb_network_config.cfg")
  vars = {
    lb_ip     = var.domain_lb_ip
    node_gw   = var.domain_node_gw
    node_ns   = var.domain_node_ns
    ns_search = var.domain_search
  }
}

resource "libvirt_pool" "domain_pool" {
  name = "${var.domain_hostname}_pool"
  type = "dir"
  path = "/repo/artifacts"
}

resource "libvirt_network" "node_network" {
  name      = var.domain_net
  mode      = "bridge"
  bridge    = "br0"
  autostart = true
}

resource "libvirt_volume" "node_volume" {
  count  = var.domain_count
  name   = "${var.domain_hostname}${count.index}_${var.domain_disk}"
  pool   = libvirt_pool.domain_pool.name
  source = var.base_os
  format = "qcow2"
  
}

resource "libvirt_domain" "node_domain" {
  count      = var.domain_count
  name       = "${var.domain_hostname}${count.index}"
  memory     = var.domain_mem
  vcpu       = var.domain_cpu
  cloudinit  = libvirt_cloudinit_disk.cloud-init[count.index].id
  qemu_agent = true
  
  disk {
    volume_id = libvirt_volume.node_volume[count.index].id
  }
  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
  network_interface {
    network_name   = libvirt_network.node_network.name
    network_id     = libvirt_network.node_network.id
    hostname       = "${var.domain_hostname}${count.index}"
    bridge         = "br0"
    wait_for_lease = false
  }
}

resource "libvirt_volume" "lb_volume" {
    name   = var.lb_disk
    pool   = libvirt_pool.domain_pool.name
    source = var.base_os
    format = "qcow2"
}

resource "libvirt_domain" "lb_domain" {
  name       = var.domain_lb_hostname
  memory     = var.domain_lb_mem
  vcpu       = var.domain_lb_cpu
  cloudinit  = libvirt_cloudinit_disk.lb_cloud-init.id
  qemu_agent = true

  disk {
    volume_id = libvirt_volume.lb_volume.id
  }
  network_interface {
    network_name = libvirt_network.node_network.name
    network_id   = libvirt_network.node_network.id
    hostname     = var.domain_lb_hostname
    addresses    = ["${var.domain_lb_ip}"]
    bridge       = "br0"
  }
  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  } 
}

# K3s prep work
resource null_resource "k3s_common" {
  count = var.domain_count
  depends_on = [
    libvirt_domain.node_domain
  ]

  provisioner "remote-exec" {
      connection {
        type     = "ssh"
        user     = var.provisioning_user
        password = var.provisioning_password
        host     = "${var.domain_node_ip}${count.index}"
      }
      inline = [
      "cat > $HOME/.ssh/authorized_keys <<EOF\n${file(var.public_key_path)}\nEOF",
      "mkdir -p /etc/rancher/k3s", 
      "mkdir -p /var/lib/rancher/k3s/server/manifests",
      "mkdir -p /var/lib/rancher/k3s/agent/images",
      "mkdir -p /opt/k3s",
      "curl -O ${var.remote_repo}/k3s && sudo mv k3s /opt/k3s/ && sudo chmod +x /opt/k3s/k3s"
    ]
  }
}