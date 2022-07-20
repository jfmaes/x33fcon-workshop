#bootstrap script for Tegridy DC - x33fcon workshop
#created by jfmaes & SANS SROC Range Builders

$Logfile = "C:\bootstrap.log"
Function LogWrite {
  Param ([string]$logstring)
  $mytime = Get-Date
  Add-content $Logfile -value "$mytime $logstring"
  Write-Host("$mytime $logstring")
}


#variables

$Forest = "Tegridy.Farms"
$AdminUsername = "bootstrapper"
$AdminPassword = "EpicBootStrapPassword123"
$SecureAdminPassword = ConvertTo-SecureString $AdminPassword -AsPlainText -Force
# Create a local administrator on the system
$op = Get-LocalUser | Where-Object { $_.Name -eq $AdminUsername }
if ( -not $op) {
  LogWrite("Creating new local user $AdminUsername")
  & net user $AdminUsername "$AdminPassword" /add /y
  LogWrite("Adding user to local Administrators Group")
  & net localgroup administrators $AdminUsername /add
}


LogWrite("Forest is set to $Forest")
$op = Get-WMIObject Win32_NTDomain | Select-Object -ExpandProperty DnsForestName
if ( $op -NotContains $Forest ) {
  LogWrite("Sleeping one minute and promoting server to DC")
  Write-Host("Sleeping one minute before cmdlet")
  Install-WindowsFeature AD-Domain-Services
  Start-Sleep -s 60
  add-WindowsFeature RSAT-ADDS-Tools
  Install-ADDSForest -DomainName $Forest -InstallDns -force -SafeModeAdministratorPassword $SecureAdminPassword
  Exit 3010
}

