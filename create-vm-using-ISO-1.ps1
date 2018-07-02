# Specify vCenter Server, vCenter Server username and vCenter Server user password
$vCenter=”192.168.10.14“
$vCenterUser=”administrator@vsphere.local“
$vCenterUserPassword=”Root@1234“
#
# Specify number of VMs you want to create
$vm_count = “1“
#
# Specify number of VM CPUs
$numcpu = “1“
#
# Specify number of VM MB RAM
$MBram = “512“
#
# Specify VM disk size (in MB)
$MBguestdisk = “8000“
#
# Specify VM disk type, available options are Thin, Thick, EagerZeroedThick
$Typeguestdisk =”Thin“
#
# Specify VM guest OS
$guestOS = “winNetStandardGuest“
#
# Specify vCenter Server datastore
$ds = “datastore1“
#
# Specify the vSphere Cluster
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
1..$vm_count | foreach {
$y=”{0:D2}” -f $_
$VM_name= $VM_prefix + $y
$ESXi=Get-VMHost -state connected | Get-Random
write-host “Creation of VM $VM_name initiated”  -foreground green
New-VM -Name $VM_Name -VMHost $ESXi -numcpu $numcpu -MemoryMB $MBram -DiskMB $MBguestdisk -DiskStorageFormat $Typeguestdisk -Datastore $ds -GuestId $guestOS
write-host “Power On of the  VM $VM_name initiated”  -foreground green
Start-VM -VM $VM_name -confirm:$false -RunAsync
}