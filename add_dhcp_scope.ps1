
$scopes = Import-Csv -Path dhcpserver.csv -Delimiter ";"
foreach ($scope in $scopes)
{
    $name = $scope.name
    $description = $scope.description
    Write-Output "Creating scope  $name"
    Add-DhcpServerv4Scope -Name "$name" -Description "$description" -StartRange $scope.startrange -EndRange $scope.endrange -SubnetMask $scope.subnetmask -State Active -LeaseDuration $scope.leaseduration
    Add-DhcpServerv4ExclusionRange -ScopeId $scope.scopeid  -StartRange  $scope.exclusionstartrange -EndRange $scope.exclusionendrange
    Add-DhcpServerv4ExclusionRange -ScopeId $scope.scopeid  -StartRange  $scope.exclusionstartrange2 -EndRange $scope.exclusionendrange2
    Set-DhcpServerv4OptionValue -Router $scope.router -ScopeId $scope.scopeid
    Remove-DhcpServerv4OptionValue -DnsServer $scope.removednsserver -ScopeId $scope.scopeid
    Add-DhcpServerv4OptionValue -DnsDomain $scope.dnsdomain -ScopeId $scope.scopeid
    Add-DhcpServerv4OptionValue -DnsServer $scope.dnsserver -ScopeId $scope.scopeid
}