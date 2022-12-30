# Based on https://gist.github.com/timsneath/19867b12eee7fd5af2ba

#### Alias's

########################################################
##           Basic Alias's & Functions                ##
########################################################

# view net-adapter
Set-Alias -Name eth -Value get-netadapter


#View and Edit profile
#function pro {Notepad $PROFILE.AllUsersAllHosts}
function editpro {Notepad $PROFILE.CurrentUserAllHosts}
function updatepro {Invoke-WebRequest -Uri https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Windows/PowerShell_profile.ps1 -OutFile $PROFILE.CurrentUserAllHosts && Notepad $PROFILE.CurrentUserAllHosts}

# Chris titus Debloat script
function wintitus {irm christitus.com/win | iex}
}

# Update windows with PSWindowsUpdate Module
# Refer to https://www.youtube.com/watch?v=M2mMQfPGZsE&list=WL&index=13&t=2s
### The next command is the original
#function winup {Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot | Out-File "C:\($env.computername-Get-Date -f yyyy-MM-dd)-MSUpdates.log" -Force}
### the next command would not run in powershell 7
#function winup {Install-WindowsUpdate -MicrosoftUpdate -AcceptAll | Out-File -FilePath "$($env:USERPROFILE)\Desktop\MSUpdates.log" -Force}
### the next command works in powershell 7
function winup {Get-WindowsUpdate -install -MicrosoftUpdate -AcceptAll | Out-File -FilePath "$($env:USERPROFILE)\Desktop\MSUpdates.log" -Force} 


#Run ultimate-win-bootstrap.ps1
function winult {$ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Windows/ultimate-win-bootstrap.ps1
Invoke-Expression $($ScriptFromGithHub.Content)} 


# Tab Cycle = Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Useful shortcuts for traversing directories
function cd...  { cd ..\.. }
function cd.... { cd ..\..\.. }

# Compute file hashes - useful for checking successful downloads 
function md5    { Get-FileHash -Algorithm MD5 $args }
function sha1   { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }


########################################################
##                  Admin/become Sudo Stuff           ##
########################################################


# Variables to Find out if the current user identity is elevated (has admin rights)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# If so and the current host is a command line, then change to red color 
# as warning to user that they are operating in an elevated context
if (($host.Name -match "ConsoleHost") -and ($isAdmin))
{
     $host.UI.RawUI.BackgroundColor = "DarkRed"
     $host.PrivateData.ErrorBackgroundColor = "White"
     $host.PrivateData.ErrorForegroundColor = "DarkRed"
     Clear-Host
}




# Set up command prompt and window title. Use UNIX-style convention for identifying 
# whether user is elevated (root) or not. Window title shows current version of PowerShell
# and appends [ADMIN] if appropriate for easy taskbar identification
function prompt 
{ 
    if ($isAdmin) 
    {
        "[" + (Get-Location) + "] # " 
    }
    else 
    {
        "[" + (Get-Location) + "] $ "
    }
}

$Host.UI.RawUI.WindowTitle = "PowerShell {0}" -f $PSVersionTable.PSVersion.ToString()
if ($isAdmin)
{
    $Host.UI.RawUI.WindowTitle += " [ADMIN - Be Careful]"
}


# Simple function to start a new elevated process. If arguments are supplied then 
# a single command is started with admin rights; if not then a new admin instance
# of PowerShell is started.
function admin
{
    if ($args.Count -gt 0)
    {   
       $argList = "& '" + $args + "'"
       #Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList #(old powershell 5 way)
       Start-Process "$psHome\pwsh.exe" -Verb runAs -ArgumentList $argList
    }
    else
    {
       #Start-Process "$psHome\powershell.exe" -Verb runAs #(old powershell 5 way)
       Start-Process "$psHome\pwsh.exe" -Verb runAs
    }
}

# Set UNIX-like aliases for the admin command, so sudo <command> will run the command
# with elevated rights. 
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin



# We don't need these variables any more; they were just temporary variables to get to $isAdmin. 
# Delete them to prevent cluttering up the user profile. 
Remove-Variable identity
Remove-Variable principal