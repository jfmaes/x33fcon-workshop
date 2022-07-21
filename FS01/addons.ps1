$Logfile = "C:\bootstrap.log"
Function LogWrite {
  Param ([string]$logstring)
  $mytime = Get-Date
  Add-content $Logfile -value "$mytime $logstring"
  Write-Host("$mytime $logstring")
}

$ShareName = "Tegridy-RND"
$root = "C:\"
LogWrite("Creating SMB share $ShareName for $root")
New-Item -ItemType directory -Path "$root\$ShareName"
echo "top secret tegridy weed recipe" > "C:\Tegridy-RND\recipe.txt"
New-SmbShare -Name $ShareName -Path $root -FullAccess "Domain Users"
$acl = Get-Acl "$root\$share"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("tegridy.farms\$share", "FullControl", "Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl "$root\$share"
LogWrite("Set Acl for $root\$share")

LogWrite("adding towelie as local admin")
net localgroup administrators tegridy\towelie /add

LogWrite("Disable Host Based Firewall For Domain Network")
# Note: this is set to False not $false per the docs
# https://docs.microsoft.com/en-us/powershell/module/netsecurity/set-netfirewallprofile?view=windowsserver2022-ps
Set-NetFirewallProfile -Profile Domain -Enabled False 
