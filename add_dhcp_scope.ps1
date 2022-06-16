
$scopes = Import-Csv -Path dhcp.csv -Delimiter ";"
foreach ($scope in $scopes)
{
    $name = $scope.name
    $description = $scope.description
    Write-Output "Creating scope  $name"
    Add-DhcpServerv4Scope -Name "$name" -Description "$description" -StartRange $scope.startrange -EndRange $scope.endrange -SubnetMask $scope.subnetmask -State Active -LeaseDuration 1.00:00:00
    Set-DhcpServerv4OptionValue -Router $scope.router -ScopeId $scope.scopeid -ComputerName $dhcpserver
}