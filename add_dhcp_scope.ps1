
$scopes = Import-Csv -Path C:\Users\amdadm\dhcpserver.csv -Delimiter ";"
foreach ($scope in $scopes)
{
    $name = $scope.name
    $description = $scope.description
    Write-Output "Creating scope  $name"
    Add-DhcpServerv4Scope -Name "$name" -Description "$description" -StartRange $scope.startrange -EndRange $scope.endrange -SubnetMask $scope.subnetmask -State Active -LeaseDuration $scope.leaseduration
    Add-DhcpServerv4ExclusionRange -ScopeId $scope.scopeid  -StartRange  $scope.exclusionstartrange -EndRange $scope.exclusionendrange
    Add-DhcpServerv4ExclusionRange -ScopeId $scope.scopeid  -StartRange  $scope.exclusionstartrange2 -EndRange $scope.exclusionendrange2
    Set-DhcpServerv4OptionValue -ScopeId $scope.scopeid -Router $scope.router
    Set-DhcpServerv4OptionValue -ScopeId $scope.scopeid -DnsDomain $scope.dnsdomain
    Set-DhcpServerv4OptionValue -ScopeId $scope.scopeid -DnsServer $scope.dnsserver.Split(',')
} 
