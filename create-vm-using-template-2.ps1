function New-MDTVM {
 
param
(
    [Parameter(Mandatory=$true)]
    [string]$Computername = 'CentOS-7-temp',
    [string]$CPU = '1',
    [string]$Memory = '0.5',
    [string]$DiskSpace = '50',
    [string]$DataStore = 'datastore',
    [string]$NetworkName = 'VM Network',
    [string]$VMHost = '192.168.10.6',
    # Specify vCenter Server, vCenter Server username and vCenter Server user password
    [string]$vCenter=”192.168.10.14“,
    [string]$vCenterUser=”administrator@vsphere.local“,
    [string]$vCenterUserPassword=”Root@1234“
)
    
    Connect-VIServer $VCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0 
    $VM_Template = GET-Template -Name "centos-temp1"
    New-VM -Name $ComputerName  -Template $VM_Template -VMHost $VMHost -Datastore $Datastore  
   # Get-VM -Name $ComputerName | Get-CDDrive | Set-CDDrive -IsoPath "[$Datastore] $LiteTouchPath" -Confirm:$false -StartConnected:$true 
    Start-VM -VM $ComputerName -Confirm:$False 
    Start-Sleep -Seconds 60
   # Get-CDDrive -VM $ComputerName | Set-CDDrive -NoMedia -Confirm:$False
}