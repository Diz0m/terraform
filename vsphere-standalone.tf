#===============================================================================
# vSphere Provider
#===============================================================================

provider "vsphere" {
  version        = "1.11.0"
  vsphere_server = var.vsphere_vcenter
  user           = var.vsphere_user
  password       = var.vsphere_password

  allow_unverified_ssl = var.vsphere_unverified_ssl
}

#===============================================================================
# vSphere Data
#===============================================================================

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vm_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "templateWin" {
  name          = var.win_vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "templateLin" {
  name          = var.lin_vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

#===============================================================================
# vSphere Resources
#===============================================================================

#===============================================================================
# Linux Resource
#===============================================================================

resource "vsphere_virtual_machine" "linux" {
  count = 3

  name             = "${var.lin_vm_name}${count.index + 1}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.lin_vm_cpu
  memory   = var.lin_vm_ram
  guest_id = data.vsphere_virtual_machine.templateLin.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.templateLin.network_interface_types[0]
  }

  disk {
    label            = "${var.lin_vm_name}.vmdk"
    size             = data.vsphere_virtual_machine.templateLin.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.templateLin.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.templateLin.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.templateLin.id
    linked_clone  = var.lin_vm_linked_clone

    customize {
      timeout = "20"

      linux_options {
        host_name = "${var.lin_vm_name}${count.index}"
        domain    = var.lin_vm_domain
      }

      /*network_interface {
        ipv4_address = "10.10.10.${count.index + 1}"
        ipv4_netmask = var.lin_vm_netmask
      }*/

      network_interface {}

      ipv4_gateway    = var.lin_vm_gateway
      dns_server_list = [var.lin_vm_dns]
    }
  }
  /*
  extra_config = {
    "RemoteDisplay.vnc.enabled"  = "TRUE"
    "RemoteDisplay.vnc.password" = "P@ssw0rd"
    "RemoteDisplay.vnc.port"     = "${count.index + 5901}"
  }*/

  /*lifecycle {
    prevent_destroy = true
  }*/

}

#===============================================================================
# Linux Resource
#===============================================================================

resource "vsphere_virtual_machine" "windows_client" {
  count = 0

  name             = "${var.win_vm_name}${count.index + 1}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.win_vm_cpu
  memory   = var.win_vm_ram
  guest_id = data.vsphere_virtual_machine.templateWin.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.templateWin.network_interface_types[0]
  }

  disk {
    label            = "${var.win_vm_name}.vmdk"
    size             = data.vsphere_virtual_machine.templateWin.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.templateWin.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.templateWin.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.templateWin.id
    linked_clone  = var.win_vm_linked_clone

    customize {
      timeout = "20"

      windows_options {
        computer_name     = "${var.win_vm_name}${count.index}"
        organization_name = "TEST"
        /*join_domain           = var.win_vm_domain
        domain_admin_user     = var.win_vm_domain_user
        domain_admin_password = var.win_vm_domain_pass*/
      }

      /*network_interface {
        ipv4_address = "10.10.10.${count.index + 1}"
        ipv4_netmask = var.win_vm_netmask
      }*/

      network_interface {}

      dns_server_list = [var.win_vm_dns]
    }
  }

  /*lifecycle {
    prevent_destroy = true
  }*/

}
