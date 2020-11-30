## Set a static IP
$ipaddress = '192.168.1.10'
$ipprefix = '24'
$ipgw = '192.168.1.1'
$ipdns = '192.168.1.10'
$ipif = (Get-NetAdapter).ifIndex
New-NetIPAddress -IPAddress $ipaddress -PrefixLength $ipprefix -InterfaceIndex $ipif -DefaultGateway $ipgw 

## Set the NIC to use itself as the DNS server since this is going to be a domain controller
Set-DnsClientServerAddress -InterfaceIndex $ipif -ServerAddresses $ipdns

## Rename the server and restart it to commit the change
$newname = 'srvdc01'
Rename-Computer -NewName $newname -force
Restart-Computer -Force