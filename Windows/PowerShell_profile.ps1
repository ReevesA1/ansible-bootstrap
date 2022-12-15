#### Alias's

# view net-adapter
Set-Alias -Name eth -Value get-netadapter

# Set UNIX-like aliases for the admin command, so sudo <command> will run the command
# with elevated rights. 
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin

#View and Edit profile
function pro {Notepad $PROFILE.CurrentUserAllHosts}

# Update windows with PSWindowsUpdate Module
function winup {Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot | Out-File "C:\($env.computername-Get-Date -f yyyy-MM-dd)-MSUpdates.log" -Force}

#Run ultimate-win-bootstrap.ps1
function winult {$ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Windows/ultimate-win-bootstrap.ps1
Invoke-Expression $($ScriptFromGithHub.Content)}



# Find out if the current user identity is elevated (has admin rights)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

##### Advanced Settings


# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete