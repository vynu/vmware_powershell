function New-MDTVM {
 
param
(
    [Parameter(Mandatory=$true)]
    [string]$Computername = 'CentOS-7',
    [string]$CPU = '2',
    [string]$Memory = '1',
    [string]$DiskSpace = '40',
    [string]$DataStore = 'datastore',
    [string]$NetworkName = 'VM Network',
    [string]$LiteTouchPath = 'ISO\centos-7.iso',
    [string]$GuestOS = 'centos64Guest',
    [string]$VMHost = '192.168.10.6',
    # Specify vCenter Server, vCenter Server username and vCenter Server user password
    [string]$vCenter=”192.168.10.14“,
    [string]$vCenterUser=”administrator@vsphere.local“,
    [string]$vCenterUserPassword=”Root@1234“
)
 
    Connect-VIServer $VCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0 
    New-VM -Name $ComputerName -GuestId $GuestOS -VMHost $VMHost -Version v11 -DiskGB $DiskSpace -Datastore $Datastore -MemoryGB $Memory -NumCpu $CPU -NetworkName $NetworkName -CD 
    Get-VM -Name $ComputerName | Get-CDDrive | Set-CDDrive -IsoPath "[$Datastore] $LiteTouchPath" -Confirm:$false -StartConnected:$true 
    Start-VM -VM $ComputerName -Confirm:$False 
    Start-Sleep -Seconds 60
    Get-CDDrive -VM $ComputerName | Set-CDDrive -NoMedia -Confirm:$False
}