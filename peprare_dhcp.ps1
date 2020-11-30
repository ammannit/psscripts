## Install the bits on the server for DHCP
Install-WindowsFeature 'DHCP' -IncludeAllSubFeature -IncludeManagementTools

## Authorize the DHCP server in Active Directory
Add-DhcpServerInDC -DnsName srvdc01.daniel.local -IPAddress 192.168.10.20

## Create an IPv4 DHCP scope
Add-DhcpServerv4Scope -Name 'Client' -StartRange '192.168.1.50' -EndRange '192.168.1.250' -SubnetMask '255.255.255.0'

## Add Exclusion Range
Add-DhcpServerv4ExclusionRange -EndRange 192.168.1.1 -ScopeId 192.168.1.0 -StartRange 192.168.1.49

## Set the DNS server to use for all clients to use on the DHCP server
Set-DhcpServerv4OptionValue -DnsDomain daniel.local -DnsServer 192.168.1.10

## Set the Gateway to use for all clients to use on the DHCP server
Set-DhcpServerv4OptionValue -Router 192.168.1.1  