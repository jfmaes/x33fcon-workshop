#bootstrap script for Tegridy DC - x33fcon workshop
#created by jfmaes & SANS SROC Range Builders
New-ADUser `
  -Name "Randy.Marsh" `
  -AccountPassword (ConvertTo-SecureString –AsPlainText -Force -String WheresyourTegridy?) `
  -Enabled $true `
  -ChangePasswordAtLogon $false


  New-ADUser `
  -Name "Towelie" `
  -AccountPassword (ConvertTo-SecureString –AsPlainText -Force -String YouWannaGetHigh?) `
  -Enabled $true `
  -ChangePasswordAtLogon $false

  New-ADUser `
  -Name "Stan.Marsh" `
  -AccountPassword (ConvertTo-SecureString –AsPlainText -Force -String IhateThisStupidFarm!!!) `
  -Enabled $true `
  -ChangePasswordAtLogon $false

  Add-ADGroupMember -Identity "Domain Admins" -Members "Randy.Marsh"
