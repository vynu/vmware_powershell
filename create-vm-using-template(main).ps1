# Specify vCenter Server, vCenter Server username and vCenter Server user password
$vCenter=”192.168.10.14“
$vCenterUser=”administrator@vsphere.local“
$vCenterUserPassword=”Root@1234“
#
# Specify number of VMs you want to create
$vm_count = “5“
# Specify vCenter Server datastore
$ds = “datastore“

$Cluster = “192.168.10.6“
#
# Specify the VM name to the left of the – sign
$VM_prefix = “centOS-“
#
# End of user input parameters
#_______________________________________________________
#
write-host “Connecting to vCenter Server $vCenter” -foreground green
Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0
$VM_Template = GET-Template -Name "centos-temp1"
1..$vm_count | foreach {
$y=”{0:D2}” -f $_
$VM_name= $VM_prefix + $y
$ESXi=Get-VMHost -state connected | Get-Random
write-host “Creation of VM $VM_name initiated”  -foreground green
New-VM -Name $VM_Name -VMHost $ESXi  -Datastore $ds -Template $VM_Template
write-host “Power On of the  VM $VM_name initiated”  -foreground green
Start-VM -VM $VM_name -confirm:$false -RunAsync
}