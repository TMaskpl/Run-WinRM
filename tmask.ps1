Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install check-mk -y
choco install python -y
choco install sysinternals -y

Enable-PSRemoting –force

Set-Service WinRM -StartMode Automatic

Get-WmiObject -Class win32_service | Where-Object {$_.name -like "WinRM"}

Set all remote hosts to trusted. Note: You may want to unset this later.

Set-Item WSMan:localhost\client\trustedhosts -value *

Get-Item WSMan:\localhost\Client\TrustedHosts
Write-Host "Set password tmask user"
$Password = Read-Host -AsSecureString
$y = Get-LocalUser | Where-Object {$_.name -like "tmask"}
if ( $y )
{
Write-Host $y
}
else
{
New-LocalUser "tmask" -Password $Password -FullName "Service TMask User" -Description "Service User TMask.pl mailto: biuro@tmask.pl"
}

$x = Get-WinSystemLocale | Where-Object {$_.name -like "en-US"}
if ( $x ) {
    Add-LocalGroupMember -Group "Administrators" -Member "tmask"
}
else {
    Add-LocalGroupMember -Group "Administratorzy" -Member "tmask"
}

