Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install check-mk -f
choco install python -f
choco install sysinternals -f

Enable-PSRemoting –force

Set-Service WinRM -StartMode Automatic

Get-WmiObject -Class win32_service | Where-Object {$_.name -like "WinRM"}

Set all remote hosts to trusted. Note: You may want to unset this later.

Set-Item WSMan:localhost\client\trustedhosts -value *

Get-Item WSMan:\localhost\Client\TrustedHosts

$Password = Read-Host -AsSecureString

New-LocalUser "tmask" -Password $Password -FullName "Service TMask User" -Description "Service User TMask.pl"

$x = Get-WinSystemLocale | Where-Object {$_.name -like "en-EN"}
if ( $x ) {
    Add-LocalGroupMember -Group "Administrators" -Member "tmask"
}
else {
    Add-LocalGroupMember -Group "Administratorzy" -Member "tmask"
}
