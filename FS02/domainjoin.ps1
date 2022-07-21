$DAPassword = "WheresyourTegridy?"
$SecureDAAdminPassword = ConvertTo-SecureString $DAPassword -AsPlainText -Force
$DAAdminCredentials = New-Object System.Management.Automation.PSCredential ("Randy.Marsh", $SecureDAAdminPassword)
add-computer –domainname "tegridy.farms" -Credential $DAAdminCredentials -Restart
