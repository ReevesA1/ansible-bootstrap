# Got some stuff from here https://gist.github.com/timsneath/19867b12eee7fd5af2ba



########################################################
##           "PRO" Prefix Alias's                       ##
########################################################

# Update Profile
function proupdate {Invoke-WebRequest -Uri https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Windows/PowerShell_profile.ps1 -OutFile $PROFILE.CurrentUserAllHosts && Notepad $PROFILE.CurrentUserAllHosts}


#View and Edit profile
function proedit {Invoke-Item $PROFILE.CurrentUserAllHosts} # will launch in the default $EDITOR
#Other lInes I could use
###All Users
#function proedit {Notepad $PROFILE.AllUsersAllHosts}
### Open in notepadd++
#start notepad++ $PROFILE.CurrentUserAllHosts 
### Open in notepad
#function proedit {Notepad $PROFILE.CurrentUserAllHosts}
#function proedit {code $PROFILE.CurrentUserAllHosts} #uses vs code

########################################################
##           "Win" Prefix Alias's                       ##
########################################################

# Chris titus Debloat script
function wintitus {Start-Process Pwsh -Verb runAs -ArgumentList "-Command irm christitus.com/win | iex"}
#without admin rights
#function wintitus {irm christitus.com/win | iex}


function winup {
  # Check if the current user is an administrator
  $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

  # If the current user is not an administrator, output a message and return
  if (-not $isAdmin) {
    Write-Host -ForegroundColor Magenta "This function requires administrator privileges. Please run it with the runAs verb."
    return
  }

  # If the current user is an administrator, run the upgrading commands
  choco upgrade all -y
  winget upgrade --all
  Get-WindowsUpdate -install -MicrosoftUpdate -AcceptAll
}



function winult {
  # Check if the current user is an administrator
  $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

  # If the current user is not an administrator, output a message and return
  if (-not $isAdmin) {
    Write-Host -ForegroundColor Magenta "This function requires administrator privileges. Please run it with the runAs verb."
    return
  }

  # If the current user is an administrator, run the upgrading commands
  $ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Windows/ultimate-win-bootstrap.ps1
  Invoke-Expression $($ScriptFromGithHub.Content)
}

########################################################
##           Basic Alias's & Functions                ##
########################################################

# Sourcing $Prifile

function softsource {. $PROFILE.CurrentUserAllHosts}
function hardsource {Start-Process "wt.exe" -ArgumentList "-p", "PowerShell"}


# Tab Cycle = Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Useful shortcuts for traversing directories
function cd...  { cd ..\.. }
function cd.... { cd ..\..\.. }

# Compute file hashes - useful for checking successful downloads 
function md5    { Get-FileHash -Algorithm MD5 $args }
function sha1   { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

# view net-adapter
Set-Alias -Name eth -Value get-netadapter





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
       #Start-Process "$psHome\pwsh.exe" -Verb runAs -ArgumentList $argList #(opens powershell 7 but not in windows terminal)
       Start-Process "wt.exe" -ArgumentList "-p", "PowerShell" -Verb runAs
    }
    else
    {
       #Start-Process "$psHome\powershell.exe" -Verb runAs #(old powershell 5 way)
       #Start-Process "$psHome\pwsh.exe" -Verb runAs #(opens powershell 7 but not in windows terminal)
       Start-Process "wt.exe" -ArgumentList "-p", "PowerShell" -Verb runAs
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


########################################################
##        Starship Cross shell Prompt                         ##
########################################################

#Must be at the end of $PROFILE to work
Invoke-Expression (&starship init powershell)
