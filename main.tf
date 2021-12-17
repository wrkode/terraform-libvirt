provider "libvirt" {
  uri = var.quemu_conn
}

module "domain" {

source = "./modules/domain"
  quemu_conn            = var.quemu_conn
  base_os               = var.base_os
  remote_repo           = var.remote_repo
  lb_disk               = var.lb_disk
  domain_count          = var.domain_count
  domain_disk           = var.domain_disk
  domain_mem            = var.domain_mem
  domain_cpu            = var.domain_cpu
  domain_lb_mem         = var.domain_lb_mem
  domain_lb_cpu         = var.domain_lb_cpu
  domain_net            = var.domain_net
  domain_node_ns        = var.domain_node_ns
  domain_search         = var.domain_search
  domain_node_gw        = var.domain_node_gw
  domain_hostname       = var.domain_hostname
  domain_cidr           = var.domain_cidr
  domain_user           = var.domain_user
  user_ssh_key          = var.user_ssh_key
  domain_lb_ip          = var.domain_lb_ip
  domain_node_ip        = var.domain_node_ip
  domain_lb_hostname    = var.domain_lb_hostname
  k3s_version           = var.k3s_version
  k3s_exec              = var.k3s_exec
  k3s_token             = var.k3s_token
  provisioning_user     = var.provisioning_user
  provisioning_password = var.provisioning_password
  public_key_path       = var.public_key_path
}
