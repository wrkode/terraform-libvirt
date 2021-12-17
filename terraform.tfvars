### Commons
quemu_conn               = ""      # KVM Connection string qemu+ssh://root@<FQDN or IP>/system
base_os                  = ""      # URI to the cloud image to be used
remote_repo              = ""      # Repository for install.sh and k3s binary 
domain_net               = ""      # Name of the Bridged KVM network that will be created. Must not exist.  
domain_search            = ""      # DNS search suffix 
domain_node_ns           = "'',''" # DNS to be used for the infrastructure each address between single quotes and comma-separated
domain_node_gw           = ""      # Default Gateway for the Bridged KVM Network
domain_cidr              = ""      # Network CIDR not currently implemented until qemuagent IP discovery fix
domain_user              = ""      # User to be created with sudo ALL perimission
user_ssh_key             = ""      # pub SSH key added for $domain_user

### Load Balancer VM
domain_lb_hostname       = ""      # Load Balancer VM name/hostname
domain_lb_ip             = ""      # Load balancer desired IP address
lb_disk                  = ""      # Load balancer VM disk
domain_lb_mem            =         # Memory (in MB) to be assigned to the Load Balancer VMs
domain_lb_cpu            =         # number of virtual CPU to be assigned to the Load Balancer VMs

### Controlplane and Worker VMs
domain_hostname          = ""      # base name/hostname for the VMs
domain_mem               =         # Memory (in MB) to be assigned to Controlplane and Worker VMs
domain_cpu               =         # number of virtual CPU to be assigned to Controlplane and Worker VMs
domain_disk              = ""      # Suffix for domains/VMs volumes
domain_count             =         # number of VMs to be created, Controlplane + Workers.
domain_node_ip           = ""      # the base network for Node IP index in last octect will be computed in libvirt_domain{} This needs to be improved

### K3s deployment basics Not currently Implemented
k3s_version              = ""      # K3s version to be installed. - Not Implemented
k3s_token                = ""      # the desired token for of the K3s cluster - Not Implemented
provisioning_user        = ""      # User created for remote provisioning of K3s - Not Implemented
provisioning_password    = ""      # Password for the priviledged user for remote provisioning of K3s - Not Implemented