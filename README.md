# Libvirt basic infrastructure deployment with Terraform


This repo creates the following:

* n libvirt domains (VMs) using NoCloud images and Cloud-init.
* 1x NGINX Loadbalancer.
* foundation prep for K3s deployment. 


# Prerequisites

* Prior to running this terraform:
 -  DNS records need to be created to point at the Loadbalancer IP addresse and for the VMs to be created, defined in the variables `domain_lb_ip` & `domain_node_ip[index]`.

 -  The VM template used must have the `cloud-init installed`:

# Instructions

* Copy your ssh key to the KVM/libvirt server authorized_keys `ssh-copy-id root@<KVM FQDN/IP>`
* Copy `terraform.tfvars.example` as `terraform.tfvars`.
* Populate according to your requirements.
* initialize the providers with `terraform init`.
* create a plan with `terraform plan`.
* Apply with `terraform apply`.
* Once complete the ssh_key of the local machine/user will be used to login as `domain_user` in the VMs.

# Information

* The libvirt network created is of type "bridge" and based on static addressing
* the VMs/Domains created will have serialized and ascending IP addresses with starting base address defined in variable `domain_node_ip`


# TODO
* Remove hardcoded values where necessary
* Improve nginx.conf upstream definition
* Create Architecture Diagram