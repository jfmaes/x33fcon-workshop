$Logfile = "C:\bootstrap.log"
Function LogWrite {
  Param ([string]$logstring)
  $mytime = Get-Date
  Add-content $Logfile -value "$mytime $logstring"
  Write-Host("$mytime $logstring")
}

LogWrite("Disable Host Based Firewall For Domain Network")
# Note: this is set to False not $false per the docs
# https://docs.microsoft.com/en-us/powershell/module/netsecurity/set-netfirewallprofile?view=windowsserver2022-ps
Set-NetFirewallProfile -Profile Domain -Enabled False 

LogWrite("Installing AD Certificate Services")
Install-WindowsFeature Adcs-Cert-Authority -IncludeManagementTools
Install-AdcsCertificationAuthority -CAType EnterpriseRootCa -Force

LogWrite("Installing AD CS Template Module")
Install-PackageProvider NuGet -Force
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module ADCSTemplate -Force

LogWrite("Installing AD Certificate Services Web Enrollment")
add-WindowsFeature Adcs-Web-Enrollment
Install-AdcsWebEnrollment -Force
