## Install the bits for Active Directory Domain Services
Install-WindowsFeature 'AD-Domain-Services' -IncludeAllSubFeature -IncludeManagementTools

# Create New Forest, add Domain Controller
$domainname = 'daniel.local'
$netbiosName = 'DANIEL'
Import-Module ADDSDeployment

$ad_params = @{
    CreateDnsDelegation=$false;
    DatabasePath='C:NTDS';
    DomainMode='Default';
    DomainName=$domainname;
    DomainNetbiosName=$netbiosName;
    ForestMode='Default';
    InstallDns=$true;
    NoRebootOnCompletion=$false;
    Force=$true;
    SafeModeAdministratorPassword=(ConvertTo-SecureString 'wunder1234' -AsPlainText -Force);
}

Install-ADDSForest @ad_params