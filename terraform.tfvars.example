### Commons
quemu_conn               = "qemu+ssh://root@172.16.56.14/system"                              # KVM Connection string
base_os                  = "http://reposrv.lab.k8/openSUSE-Leap-15.3-JeOS.x86_64-cloud.qcow2" # URI to the cloud image to be used
remote_repo              = "http://reposrv.lab.k8/"                                           # Repository for install.sh and k3s binary 
domain_net               = "lab_network"                                                      # Name of the Bridged KVM network that will be created. Must not exist.  
domain_search            = "lab.k8"                                                           # DNS search suffix 
domain_node_ns           = "'172.16.56.4','172.16.56.2'"                                      # DNS to be used for the infrastructure each address between single quotes and comma-separated
domain_node_gw           = "172.16.56.2"                                                      # Default Gateway for the Bridged KVM Network
domain_cidr              = "172.16.56.0/24"                                                   # not currently implemented until qemuagent IP discovery fix
domain_user              = "kubeadmin"                                                        # User to be created with sudo ALL perimission
user_ssh_key             = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtMn7OIOJiQUF19vuLI5ZIaz4ogZZP+N22QlhWAfTkUJMhShv7Deute0CRcSqWHb5dqcf8s8Ll2IWF93AmHIGAQNe1w10vEO8eNOj3Kg3XAnrEM1eNZfxtjw1H2WFRQGvc2MBmTjsOMVQi2Nq0s8sMFZnfOiEg0kk8sn78bDOWOmT7wWCxfQEYzKXjKfeXy9eC6OuRpUVQ8HW62dZSFYm5ZMGray+a/JAcGuIeux2Zo8jOLXUfC7vQvacUA05+h0T6igu+AsomO7BiAkmySauf/1l11cWWDRmae5KJR8pEPKyHJgGJzdU8PjsaXtltmEeX9hdq3j5zmIJq/019lUbEjaiBWXF8ez24cR/kOcxB04dIJo/iTrx4JH67RYApS0ZRcy7ZckAvQ7NHsjYGSAtJCeuEs5nPmQ+jtjxsmBisl3E8o2TGiMJredIAby57pgTtTt5anCuo+DY/1E/fPg2bxz/Cf0TxcAqRNxgiJUvW0HE4jAM4oiELfR+LybZ1eFk=" # pub SSH key added for $domain_user

### Load Balancer VM
domain_lb_hostname       = "kubelb"             # Load Balancer VM name/hostname
domain_lb_ip             = "172.16.56.155"      # Load balancer desired IP address
lb_disk                  = "loadbalancer.qcow2" # Load balancer VM disk
domain_lb_mem            = 2048                 # Memory (in MB) to be assigned to the Load Balancer VMs
domain_lb_cpu            = 2                    # number of virtual CPU to be assigned to the Load Balancer VMs

### Controlplane and Worker VMs
domain_hostname          = "node"         # base name/hostname for the VMs
domain_mem               = 4096           # Memory (in MB) to be assigned to Controlplane and Worker VMs
domain_cpu               = 2              # number of virtual CPU to be assigned to Controlplane and Worker VMs
domain_disk              = "volume.qcow2" # Suffix for domains/VMs volumes
domain_count             = 5              # number of VMs to be created, Controlplane + Workers.
domain_node_ip           = "172.16.56.15" # the base network for Node IP index in last octect will be computed in libvirt_domain{} This needs to be improved

### K3s deployment basics Not currently Implemented
k3s_version              = "v1.21.5+k3s2" # K3s version to be installed. - Not Implemented
k3s_token                = "agoodtoken"   # the desired token for of the K3s cluster - Not Implemented
provisioning_user        = "root"         # User created for remote provisioning of K3s - Not Implemented
provisioning_password    = "@strongP@ssw0rd!"      # Password for the priviledged user for remote provisioning of K3s - Not Implemented