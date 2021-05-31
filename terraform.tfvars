#===============================================================================
# VMware vSphere configuration
#===============================================================================

# vCenter IP or FQDN #
vsphere_vcenter = "192.168.3.171"

# vSphere username used to deploy the infrastructure #
vsphere_user = "administrator@vsphere.local"

# Skip the verification of the vCenter SSL certificate (true/false) #
vsphere_unverified_ssl = "true"

# vSphere datacenter name where the infrastructure will be deployed #
vsphere_datacenter = "Datacenter"

# vSphere cluster name where the infrastructure will be deployed #
vsphere_cluster = "Cluster1"

vsphere_password = "P@ssw0rd"

# The datastore name used to store the files of the virtual machine #
vm_datastore = "storage1"

# The vSphere network name used by the virtual machine #
vm_network = "VM Network"

#===============================================================================
# Windows Virtual machine parameters
#===============================================================================

# The name of the virtual machine #
win_vm_name = "WinTer"

# The netmask used to configure the network card of the virtual machine (example: 24) #
win_vm_netmask = "255.255.255.0"

# The network gateway used by the virtual machine #
win_vm_gateway = "10.10.10.250"

# The DNS server used by the virtual machine #
win_vm_dns = ""

# The domain name used by the virtual machine #
win_vm_domain      = "test.lab"
win_vm_domain_user = "Administrator"
win_vm_domain_pass = "P@ssw0rd"

# The vSphere template the virtual machine is based on #
win_vm_template = "WinCli"

# Use linked clone (true/false)
win_vm_linked_clone = "false"

# The number of vCPU allocated to the virtual machine #
win_vm_cpu = "1"

# The amount of RAM allocated to the virtual machine #
win_vm_ram = "2048"

# The IP address of the virtual machine #
win_vm_ip = "10.10.10.1"

#===============================================================================
# Linux Virtual machine parameters
#===============================================================================

# The name of the virtual machine #
lin_vm_name = "CentOS7Ter"

# The netmask used to configure the network card of the virtual machine (example: 24) #
lin_vm_netmask = "24"

# The network gateway used by the virtual machine #
lin_vm_gateway = "10.10.10.250"

# The DNS server used by the virtual machine #
lin_vm_dns = ""

# The domain name used by the virtual machine #
lin_vm_domain = "test.lab"

# The vSphere template the virtual machine is based on #
lin_vm_template = "CentOS7"

# Use linked clone (true/false)
lin_vm_linked_clone = "false"

# The number of vCPU allocated to the virtual machine #
lin_vm_cpu = "1"

# The amount of RAM allocated to the virtual machine #
lin_vm_ram = "1024"

# The IP address of the virtual machine #
lin_vm_ip = "10.10.10.1"
