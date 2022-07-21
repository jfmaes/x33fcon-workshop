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
