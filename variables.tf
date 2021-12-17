variable quemu_conn {
  type        = string
  description = "KVM connection method" # ie quemu+ssh://FQDN/system
}

variable base_os {
  type        = string
  description = "Path to the OS image for all Domains" 
}

variable remote_repo {
  type        = string
  description = "repository for K3s binary and install script"
}
variable domain_count {
  type        = number
  description = "number of Domains to be created" 
    }

variable domain_mem {
  type        = number
  description = "memory in MB for cluster nodes"
}

variable domain_cpu {
  type        = number
  description = "vCPU for cluster nodes"
}

variable domain_lb_mem {
  type        = number
  description = "memory in MB for Load Balancer"
}

variable domain_lb_cpu {
  type        = number
  description = "vCPU count for Load Balancer"
}

variable domain_disk {
  type        = string
  description = "disk to be attached to the Domain"
}

variable domain_net {
  type        = string
  description = "virsh network to be used"
  }

variable domain_lb_ip {
  type        = string
  description = "valid IP address in domain network"
}

variable domain_node_ip {
  type        = string
  description = "valid Node IP address in domain network"
}

variable domain_node_gw {
  type        = string
  description = "IPv4 default gateway for network in domain_net"
}

variable domain_node_ns {
  type        = string
  description = "names servers IPs for domain_net"
}

variable domain_search {
  type        = string
  description = "search dns suffix for domain_net"
}

variable lb_disk {
  type        = string
  description = "Load Balancer Domain disk"
}

variable domain_hostname {
  type        = string
  description = "hostname and domain name"    
}

variable domain_lb_hostname {
  type        = string
  description = "hostname and domain name"    
}

variable domain_cidr {
  type        = string
  description = "CIDR virtual network"
}

variable domain_user {
  type        = string
  description = "OS user for cloud-init"  
}

variable user_ssh_key {
  type        = string
  sensitive   = true
  description = "public key for ssh user"
}

variable k3s_version {
  type        = string
  description = "K3s version to be installed"
}

variable k3s_exec {
  type        = string
  default     = "'server --cluster-init --write-kubeconfig-mode=644'"
  description = "Installation mode default to HA with embedded ETCD"
}

variable k3s_token {
  type        = string
  description = "The desired token that will be used to join nodes to the cluster"
}

variable provisioning_user {
  type        = string
  description = "Priviledged OS user for k3s remote deployment"  
}

variable provisioning_password {
  type        = string
  sensitive   = true
  description = "SSH key for k3s remote deployment"  
}

variable "public_key_path" {
  description = "path of public key for nodes"
  default     = "~/.ssh/id_rsa.pub"
}