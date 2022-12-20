################################################
##                   FYI's                    ##
################################################

# Based on https://github.com/Kugane/winget


################################################
##              Shared Functions              ##
################################################

# ____  _                        _              _       _           _       
#/ ___|| |__   __ _ _ __ ___  __| |            / \   __| |_ __ ___ (_)_ __  
#\___ \| '_ \ / _` | '__/ _ \/ _` |  _____    / _ \ / _` | '_ ` _ \| | '_ \ 
# ___) | | | | (_| | | |  __/ (_| | |_____|  / ___ \ (_| | | | | | | | | | |
#|____/|_| |_|\__,_|_|  \___|\__,_|         /_/   \_\__,_|_| |_| |_|_|_| |_|
#


function Check-RunAsAdministrator {
  # Check if the current process has elevated privileges
  $currentPrincipal = [System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $isElevated = $currentPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
  $ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Windows/ultimate-win-bootstrap.ps1
  # If the current process is not elevated, create a new elevated process (notice I use Pwsh for powershell 7 and up instead of using just the word powershell (for old powershell 5)
    if (-not $isElevated) { 
      Start-Process Pwsh -Verb runAs -ArgumentList "-Command winult" 
    exit
  }
}

#Just add `Check-RunAsAdministrator` at the start of any function

###################################################
# ____  _                        _   ___           _        _ _ 
#/ ___|| |__   __ _ _ __ ___  __| | |_ _|_ __  ___| |_ __ _| | |
#\___ \| '_ \ / _` | '__/ _ \/ _` |  | || '_ \/ __| __/ _` | | |
# ___) | | | | (_| | | |  __/ (_| |  | || | | \__ \ || (_| | | |
#|____/|_| |_|\__,_|_|  \___|\__,_| |___|_| |_|___/\__\__,_|_|_|
#                                                               
#  ____ _                     _       _             
# / ___| |__   ___   ___ ___ | | __ _| |_ ___ _   _ 
#| |   | '_ \ / _ \ / __/ _ \| |/ _` | __/ _ \ | | |
#| |___| | | | (_) | (_| (_) | | (_| | ||  __/ |_| |
# \____|_| |_|\___/ \___\___/|_|\__,_|\__\___|\__, |
#

function install_chocolatey {
  Check-RunAsAdministrator
  if ([bool](Get-Command -Name 'choco' -ErrorAction SilentlyContinue)) {
    Write-Verbose "Chocolatey is already installed, skip installation." -Verbose
  }
  else {
    Write-Verbose "Installing Chocolatey..." -Verbose
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  }
}


###################################################
# ____  _                        _           ___           _        _ _ 
#/ ___|| |__   __ _ _ __ ___  __| |         |_ _|_ __  ___| |_ __ _| | |
#\___ \| '_ \ / _` | '__/ _ \/ _` |  _____   | || '_ \/ __| __/ _` | | |
# ___) | | | | (_| | | |  __/ (_| | |_____|  | || | | \__ \ || (_| | | |
#|____/|_| |_|\__,_|_|  \___|\__,_|         |___|_| |_|___/\__\__,_|_|_|
#                                                                       
#__        ___                  _   
#\ \      / (_)_ __   __ _  ___| |_ 
# \ \ /\ / /| | '_ \ / _` |/ _ \ __|
#  \ V  V / | | | | | (_| |  __/ |_ 
#   \_/\_/  |_|_| |_|\__, |\___|\__|



function install-winget {
  # Check if Winget is installed
  $wingetInstalled = Get-Command winget -ErrorAction SilentlyContinue

  # If Winget is not installed, install it
  if (-not $wingetInstalled) {
    # Download the latest version of Winget from GitHub
    Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v0.3.3254-preview/Microsoft.DesktopAppInstaller_4.2021.3254.0_x64__8wekyb3d8bbwe.msixbundle -OutFile winget.msixbundle

    # Install the downloaded MSIX bundle
    Add-AppxPackage .\winget.msixbundle

    # Delete the downloaded file
    Remove-Item .\winget.msixbundle
  } else {
    # Winget is already installed, check for updates
    $updateAvailable = winget update check
    if ($updateAvailable) {
      # Update is available, upgrade to the latest version
      winget upgrade
    }
  }
}



######################################

# ____  _                        _           _____ _       _     _     
#/ ___|| |__   __ _ _ __ ___  __| |         |  ___(_)_ __ (_)___| |__  
#\___ \| '_ \ / _` | '__/ _ \/ _` |  _____  | |_  | | '_ \| / __| '_ \ 
# ___) | | | | (_| | | |  __/ (_| | |_____| |  _| | | | | | \__ \ | | |
#|____/|_| |_|\__,_|_|  \___|\__,_|         |_|   |_|_| |_|_|___/_| |_|
#

function finish {
  Write-Host
  Write-Host -ForegroundColor DarkGreen  "Processes Has finished"
  Write-Host
  Pause
}


##################################################################################################################################################################
##################################################################################################################################################################
##################################################################################################################################################################
##################################################################################################################################################################

################################################
##      1 ---->    Reload This Script         ##
################################################
#____      _                 _                 _       _   
#|  _ \ ___| | ___   __ _  __| |  ___  ___ _ __(_)_ __ | |_ 
#| |_) / _ \ |/ _ \ / _` |/ _` | / __|/ __| '__| | '_ \| __|
#|  _ <  __/ | (_) | (_| | (_| | \__ \ (__| |  | | |_) | |_ 
#|_| \_\___|_|\___/ \__,_|\__,_| |___/\___|_|  |_| .__/ \__|



function winult {$ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Windows/ultimate-win-bootstrap.ps1
  Invoke-Expression $($ScriptFromGithHub.Content)}


#########################################################################################################
##      2 ---->    Ensure PowerShell execution policy is set to RemoteSigned for the current user      ##
#########################################################################################################
#                          _   _                           _ _            
#  _____  _____  ___ _   _| |_(_) ___  _ __    _ __   ___ | (_) ___ _   _ 
# / _ \ \/ / _ \/ __| | | | __| |/ _ \| '_ \  | '_ \ / _ \| | |/ __| | | |
#|  __/>  <  __/ (__| |_| | |_| | (_) | | | | | |_) | (_) | | | (__| |_| |
# \___/_/\_\___|\___|\__,_|\__|_|\___/|_| |_| | .__/ \___/|_|_|\___|\__, |
#                                             |_|                   |___/ 

function execution_policy {
    $ExecutionPolicy = Get-ExecutionPolicy -Scope CurrentUser
    if ($ExecutionPolicy -eq "RemoteSigned") {
        Write-Verbose "Execution policy is already set to RemoteSigned for the current user, skipping..." -Verbose
    }
    else {
        Write-Verbose "Setting execution policy to RemoteSigned for the current user..." -Verbose
        Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
    }
}


################################################################
##        3 ---->     X86&Arm64 Choco  Packages               ##
################################################################


 
#  ____ _                       _     _     _       
# / ___| |__   ___   ___ ___   | |   (_)___| |_   _ 
#| |   | '_ \ / _ \ / __/ _ \  | |   | / __| __| (_)
#| |___| | | | (_) | (_| (_) | | |___| \__ \ |_   _ 
# \____|_| |_|\___/ \___\___/  |_____|_|___/\__| (_)
#                                                   
#      ___   __                               __   _  _   
#__  _( _ ) / /_    _    __ _ _ __ _ __ ___  / /_ | || |  
#\ \/ / _ \| '_ \ _| |_ / _` | '__| '_ ` _ \| '_ \| || |_ 
# >  < (_) | (_) |_   _| (_| | |  | | | | | | (_) |__   _|
#/_/\_\___/ \___/  |_|  \__,_|_|  |_| |_| |_|\___/   |_|  
                                                                               

function chocolatey_X86Arm64_list {
  Check-RunAsAdministrator
  Write-Host "Update Choco -all"  
  choco upgrade all -y
  Write-Host "Installing ChocoX86+arm64 Apps"
  $AddChocoList = @(
      "bat"
      "ripgrep"
      "hackfont"
      "7zip"
      "onecommander"
      "winaero-tweaker.install"
      "object-desktop"
      "files"
      "godot"
    )
  ForEach ($AddChocoApp in $AddChocoList){
    # Check if the package is already installed
    $installed = choco list --local-only | Select-String $AddChocoApp
    if ($installed -eq $null) {
      # Install the package if it is not already installed
      choco install $AddChocoApp -y
    }
  }
}

#################
function chocolatey_X86_list {
  Check-RunAsAdministrator
  Write-Host "Update Choco -all"  
  choco upgrade all -y
  Write-Host "Installing ChocoX86 Apps"
  $AddChocoList = @(
      "virtualbox"
      "virtualbox-guest-additions-guest.install"
      "icloud"
      "utorrent"
    )
  ForEach ($AddChocoApp in $AddChocoList){
    # Check if the package is already installed
    $installed = choco list --local-only | Select-String $AddChocoApp
    if ($installed -eq $null) {
      # Install the package if it is not already installed
      choco install $AddChocoApp -y
    }
  }
}


#################

#  ____ _                       _     _     _       
# / ___| |__   ___   ___ ___   | |   (_)___| |_   _ 
#| |   | '_ \ / _ \ / __/ _ \  | |   | / __| __| (_)
#| |___| | | | (_) | (_| (_) | | |___| \__ \ |_   _ 
# \____|_| |_|\___/ \___\___/  |_____|_|___/\__| (_)
#                                                   
# ____  _____ __  __  _____     _______ 
#|  _ \| ____|  \/  |/ _ \ \   / / ____|
#| |_) |  _| | |\/| | | | \ \ / /|  _|  
#|  _ <| |___| |  | | |_| |\ V / | |___ 
#|_| \_\_____|_|  |_|\___/  \_/  |_____|
#

function uninstall_chocolatey_list {
  Write-Host "Uninstalling Choco Apps"
  $RemoveChocoList = @(
      "streamdeck"
      "logseq"
      "translucenttb"
      "tinymediamanager"
      "freefilesync"
      "airexplorer " #Closed sourse program I thought about using to sync megasync on a schedule 
      "obsidian"
      "qttabbar"
    )  
# Loop through the array and try to uninstall each package
  foreach ($RemoveChocoApp in $RemoveChocoList) {
  choco uninstall $RemoveChocoApp -y 
  }
}

#############################
# ____            _    _                 ____ _                     
#|  _ \  ___  ___| | _| |_ ___  _ __    / ___| |__   ___   ___ ___  
#| | | |/ _ \/ __| |/ / __/ _ \| '_ \  | |   | '_ \ / _ \ / __/ _ \ 
#| |_| |  __/\__ \   <| || (_) | |_) | | |___| | | | (_) | (_| (_) |
#|____/ \___||___/_|\_\\__\___/| .__/   \____|_| |_|\___/ \___\___/ 
#                              |_|                                  
# _     _     _   
#| |   (_)___| |_ 
#| |   | / __| __|
#| |___| \__ \ |_ 
#|_____|_|___/\__|
#                 


function get_choco_x86arm64_list {
  $timestamp = get-date -Format dd_MM_yyyy
  $newPath = "$DesktopPath\" + "choco_x86arm64_"+ $env:computername + "_$timestamp" + ".txt"
  Write-Host -ForegroundColor Yellow "Generating Applist..."
  choco list -localonly > $newPath
  Write-Host -ForegroundColor Magenta "List saved on $newPath"
  Pause
}

function get_choco_x86only_list {
  $timestamp = get-date -Format dd_MM_yyyy
  $newPath = "$DesktopPath\" + "choco_x86only_"+ $env:computername + "_$timestamp" + ".txt"
  Write-Host -ForegroundColor Yellow "Generating Applist..."
  choco list -localonly > $newPath
  Write-Host -ForegroundColor Magenta "List saved on $newPath"
  Pause
}
################################################################
##        4 ---->     X86&Arm64 Winget  Packages               ##
################################################################



############################################################################################
### These Winget apps are installed silently for all users ###
# _     _     _                  _                  _   
#| |   (_)___| |_   _  __      _(_)_ __   __ _  ___| |_ 
#| |   | / __| __| (_) \ \ /\ / / | '_ \ / _` |/ _ \ __|
#| |___| \__ \ |_   _   \ V  V /| | | | | (_| |  __/ |_ 
#|_____|_|___/\__| (_)   \_/\_/ |_|_| |_|\__, |\___|\__|
#                                        |___/          
#      ___   __                               __   _  _   
#__  _( _ ) / /_         __ _ _ __ _ __ ___  / /_ | || |  
#\ \/ / _ \| '_ \ _____ / _` | '__| '_ ` _ \| '_ \| || |_ 
# >  < (_) | (_) |_____| (_| | |  | | | | | | (_) |__   _|
#/_/\_\___/ \___/       \__,_|_|  |_| |_| |_|\___/   |_|  


function install_winget_x86arm64_list {
        Check-RunAsAdministrator
        Write-Host "Update Winget -all" 
        winget upgrade --all
        Write-Host "Installing WingetX86+arm64 Apps"
        $AddWingetList = @(

            # Windows Power User
            "Microsoft.VisualStudioCode"
            "GitHub.GitHubDesktop"
            "Microsoft.PowerAutomateDesktop"
            "Microsoft.PowerToys"
            "GitHub.cli"
            "GitHub.GitHubDesktop"
            "Microsoft.PowerShell" #Newest Powershell but I can't make a AllUserALlHost Profile since Path is locked down AF but choco can't install modules
            "Python.Python.3.11" #not sure how to make it the latest version everytime
            "Cygwin.Cygwin"
          

            #Browsers
            "Mozilla.Firefox"
            "LibreWolf.LibreWolf"


            #Utilities
            "Lexikos.AutoHotkey"
            "REALiX.HWiNFO"
            "Flameshot.Flameshot"
            "VideoLAN.VLC"
            "Sejda.PDFDesktop" #pdf viewer
            #Productivity
            "Notion.Notion"
            "MarkText.MarkText"
            "Doist.Todoist"
            "RustemMussabekov.Raindrop"

            #Utilities
            "File-New-Project.EarTrumpet"
            "QL-Win.QuickLook"
            "BleachBit.BleachBit"
            "angryziber.AngryIPScanner"
                    

            #Work together (look in Notion espanso page for video)
            "Espanso.Espanso"
            "voidtools.Everything"
            "Flow-Launcher.Flow-Launcher"

            #Terminal
            "Starship.Starship"
            #Social
            "Discord.Discord"
      )
      ForEach ($AddWingetApp in $AddWingetList){
        # Check if the package is already installed
        $installed = winget list | Select-String $AddWingetApp
        if ($installed -eq $null) {
          # Install the package if it is not already installed
          winget install $AddWingetApp --accept-package-agreements --accept-source-agreements
    }
  }
}


###################################################################################

# _     _     _                  _                  _          ___   __   
#| |   (_)___| |_   _  __      _(_)_ __   __ _  ___| |_  __  _( _ ) / /_  
#| |   | / __| __| (_) \ \ /\ / / | '_ \ / _` |/ _ \ __| \ \/ / _ \| '_ \ 
#| |___| \__ \ |_   _   \ V  V /| | | | | (_| |  __/ |_   >  < (_) | (_) |
#|_____|_|___/\__| (_)   \_/\_/ |_|_| |_|\__, |\___|\__| /_/\_\___/ \___/ 
#                                        |___/                            
#                         ___        _       
#                        / _ \ _ __ | |_   _ 
#                       | | | | '_ \| | | | |
#                       | |_| | | | | | |_| |
#                        \___/|_| |_|_|\__, |
#                                      |___/ 
#                       
function install_winget_x86_list { 
      Check-RunAsAdministrator
      Write-Host "Update Winget -all" 
      winget upgrade --all
      Write-Host "Installing WingetX86+arm64 Apps"
      $AddWingetList = @(  
        #####Networking 
        "DebaucheeOpenSourceGroup.Barrier"
        "ZeroTier.ZeroTierOne"
        "Mega.MEGASync"
        "Google.Drive" #Im paying 25/year for 100gb might as well use it, this app will mount it as a drive
        ####Social
        "Oxen.Session"
        ####Gaming
        "Valve.Steam"
        "Nvidia.GeForceExperience"
        "EpicGames.EpicGamesLauncher"
        "ElectronicArts.EADesktop"
        "Amazon.Games"
        "GOG.Galaxy"
        #####Privacy and Security Focused
        "IDRIX.VeraCrypt"
        "ProtonTechnologies.ProtonVPN"
        #### Utilities
        "Balena.Etcher"
        "RaspberryPiFoundation.RaspberryPiImager"
        "MiniTool.PartitionWizard.Free"
        "ElaborateBytes.VirtualCloneDrive"
        ##Media SERVER 
        "Plex.PlexMediaServer"
        ##Torrent Server
        "AppWork.JDownloader"

    )
    ForEach ($AddWingetApp in $AddWingetList){
      # Check if the package is already installed
      $installed = winget list | Select-String $AddWingetApp
      if ($installed -eq $null) {
        # Install the package if it is not already installed
        winget install $AddWingetApp --accept-package-agreements --accept-source-agreements
    }
  }
}

#
#################################################################################
#__        ___                  _     _     _     _   
#\ \      / (_)_ __   __ _  ___| |_  | |   (_)___| |_ 
# \ \ /\ / /| | '_ \ / _` |/ _ \ __| | |   | / __| __|
#  \ V  V / | | | | | (_| |  __/ |_  | |___| \__ \ |_ 
#   \_/\_/  |_|_| |_|\__, |\___|\__| |_____|_|___/\__|
#                    |___/                            
# ____                               
#|  _ \ ___ _ __ ___   _____   _____ 
#| |_) / _ \ '_ ` _ \ / _ \ \ / / _ \
#|  _ <  __/ | | | | | (_) \ V /  __/
#|_| \_\___|_| |_| |_|\___/ \_/ \___|
#


function uninstall_winget_list {
  


Write-Host "Uninstalling Winget Apps"
$RemoveWingetList = @(

  # Replaced On MAc
  "Twilio.Authy" #Only using on mac now
  "Ferdium.Ferdium" # only using mail app on mac now but this app could be usefull for something else other then mail

  # Future Power User Stuff
  "Git.Git"
  "Microsoft.OpenSSH"
  "Docker.DockerDesktop"

  ####Gaming/Emulation
  "Nvidia.GeForceNow"
  "Libretro.RetroArch"
  "Emulationstation.Emulationstation"
  "BlueStack.BlueStacks"

  #Media
  "XBMCFoundation.Kodi"
  "Stremio.Stremio"
  "Amazon.Kindle"
  "Plex.PlexMediaPlayer"


  #Productivity
  "ransome1.sleek"
  "ONLYOFFICE.DesktopEditors"
  "KDE.Krita"
  "Joplin.Joplin"

  #Social
  "Telegram.TelegramDesktop"
  "OpenWhisperSystems.Signal"
  "Caprine.Caprine"


  #Privacy and Security Focused
  "PrestonN.FreeTube"
  "OO-Software.ShutUp10"
  "Bitwarden.Bitwarden"

  #Browser 
  "TorProject.TorBrowser"

  #Linux Focused
  "GNU.Emacs"
  "Neovim.Neovim"


  #Mega has replaced these (has the most gb $ plan)
  "extcloud.NextcloudDesktop"
  "Insynchq.Insync"

  #Terminals
  "Eugeny.Tabby" #good for multiple ssh clients 


  #Misc
  "eTeks.SweetHome3D"
  "VSCodium.VSCodium" # I Use Vs code way better for plugins
  "ShareX.ShareX"
  "NathanOsman.NitroShare"
  "RustDesk.RustDesk"

  # Replaced with choco object-desktop
  "Stardock.Fences" 
  "Stardock.Start11" 

  #Server
  "Jellyfin.Server"

  #Logitech 
  "Logitech.GHUB" #if running speakers
  "Logitech.Options" #if runnin Mx Mouse 
  
  )

# Loop through the array and try to uninstall each package
  foreach ($RemoveWingetApp in $RemoveWingetList) {
  winget uninstall $RemoveWingetApp 
  }
}

######################################### 
# ____            _    _               __        ___                  _   
#|  _ \  ___  ___| | _| |_ ___  _ __   \ \      / (_)_ __   __ _  ___| |_ 
#| | | |/ _ \/ __| |/ / __/ _ \| '_ \   \ \ /\ / /| | '_ \ / _` |/ _ \ __|
#| |_| |  __/\__ \   <| || (_) | |_) |   \ V  V / | | | | | (_| |  __/ |_ 
#|____/ \___||___/_|\_\\__\___/| .__/     \_/\_/  |_|_| |_|\__, |\___|\__|
#                              |_|                         |___/          
# _     _     _   
#| |   (_)___| |_ 
#| |   | / __| __|
#| |___| \__ \ |_ 
#|_____|_|___/\__|
#
  
function get_winget_x86arm64_list {
  $timestamp = get-date -Format dd_MM_yyyy
  $newPath = "$DesktopPath\" + "winget_X86amr64_"+ $env:computername + "_$timestamp" + ".txt"
  Write-Host -ForegroundColor Yellow "Generating Applist..."
  winget list > $newPath
  Write-Host -ForegroundColor Magenta "List saved on $newPath"
  Pause
}

function get_winget_x86only_list {
  $timestamp = get-date -Format dd_MM_yyyy
  $newPath = "$DesktopPath\" + "winget_x86only_"+ $env:computername + "_$timestamp" + ".txt"
  Write-Host -ForegroundColor Yellow "Generating Applist..."
  winget list > $newPath
  Write-Host -ForegroundColor Magenta "List saved on $newPath"
  Pause
}


################################################################
#7 ->  Install Microsoft Store Packages ETC         ##
################################################################

#
# __  __ _                           __ _     ____  _                 
#|  \/  (_) ___ _ __ ___  ___  ___  / _| |_  / ___|| |_ ___  _ __ ___ 
#| |\/| | |/ __| '__/ _ \/ __|/ _ \| |_| __| \___ \| __/ _ \| '__/ _ \
#| |  | | | (__| | | (_) \__ \ (_) |  _| |_   ___) | || (_) | | |  __/
#|_|  |_|_|\___|_|  \___/|___/\___/|_|  \__| |____/ \__\___/|_|  \___|
#                                                                     
# ____            _                         
#|  _ \ __ _  ___| | ____ _  __ _  ___  ___ 
#| |_) / _` |/ __| |/ / _` |/ _` |/ _ \/ __|
#|  __/ (_| | (__|   < (_| | (_| |  __/\__ \
#|_|   \__,_|\___|_|\_\__,_|\__, |\___||___/
#                           |___/           


###############
#function install_microsoft_store_list {
#  $MSstoreList = @(
#    #"9WZDNCRFJ3TJ", #Netflix
#    "9P6RC76MSMMJ", #PrimeVideo
#    "9n0dx20hk701", # Windows Terminal
#    "SpotifyAB.SpotifyMusic",
#    "4DF9E0F8.Netflix",
#    "Facebook.Facebook"
#  )
#
#  ForEach ($MSstoreApp in $MSstoreList){
#    # Check if the app is already installed
#    $installed = Get-AppxPackage -Name $MSstoreApp -ErrorAction SilentlyContinue
#    if (!$installed) {
#      # If the app is not installed, install it
#      Add-AppxPackage -Name $MSstoreApp
#    }
#  }
#}
###############

function install_microsoft_store_list{ 
      Check-RunAsAdministrator
      Write-Host "Update Winget -all" 
      winget upgrade --all
      Write-Host "Installing MSstore Apps"
      $AddWingetList = @(  
        #####Networking 
        "9WZDNCRFJ3TJ", #Netflix
        "9P6RC76MSMMJ", #PrimeVideo
        "9n0dx20hk701", # Windows Terminal
        "Facebook.Messenger"
        "Spotify.Spotify"
    )
    ForEach ($AddMSstoreApp in $AddMSstoreList){
      # Check if the package is already installed
      $installed = winget list | Select-String $AddWingetApp
      if ($installed -eq $null) {
        # Install the package if it is not already installed
        winget install $AddWingetApp --accept-package-agreements --accept-source-agreements
    }
  }
}


#################

### These apps are installed silently for all users ###
# for msstore apps you need to specify the source like below
#microsoft_store_list = @(
#    @{name = "Microsoft.VC++2015-2022Redist-x86" }
#    @{name = "Microsoft.VC++2015-2022Redist-x64" }      
#    @{name = "Microsoft.VC++2015-2022Redist-arm64" }    # THought it could maybe fix my parallels issue but it does not have a candidate
#    @{name = "9WZDNCRFJ3TJ"; source = "msstore" }        # Netflix
#    @{name = "9P6RC76MSMMJ"; source = "msstore" }        # Prime Video
#    @{name = "9n0dx20hk701"; source = "msstore" }        # Windows Terminal
#);
#
#
#############################################################################################
#function install_microsoft_store_list {
#  Write-Host -ForegroundColor Cyan "Installing new apps in microsoft_store_list"
#  Foreach ($microsoft_store_app in $microsoft_store_list) {
#      $list_microsoft_store_app = winget list --exact -q $microsoft_store_app.name
#      if (![String]::Join("", $list_microsoft_store_app).Contains($microsoft_store_app.name)) {
#          Write-Host -ForegroundColor Yellow  "Install:" $microsoft_store_app.name
#          # MS Store apps
#          if ($microsoft_store_app.source -ne $null) {
#              winget install --exact --silent --accept-package-agreements --accept-source-agreements $microsoft_store_app.name --source $microsoft_store_app.source
#              if ($LASTEXITCODE -eq 0) {
#                  Write-Host -ForegroundColor Green $microsoft_store_app.name "successfully installed."
#              }
#              else {
#                  $microsoft_store_app.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
#                  Write-Host
#                  Write-Host -ForegroundColor Red $microsoft_store_app.name"couldn't be installed."
#                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
#                  Write-Host
#                  Pause
#              }    
#          }
#          # All other Apps
#          else {
#              winget install --exact --silent --scope machine --accept-package-agreements --accept-source-agreements $microsoft_store_app.name
#              if ($LASTEXITCODE -eq 0) {
#                  Write-Host -ForegroundColor Green $microsoft_store_app.name "successfully installed."
#              }
#              else {
#                  $microsoft_store_app.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
#                  Write-Host
#                  Write-Host -ForegroundColor Red $microsoft_store_app.name "couldn't be installed."
#                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
#                  Write-Host
#                  Pause
#              }  
#          }
#      }
#      else {
#          Write-Host -ForegroundColor Yellow "Skip installation of" $microsoft_store_app.name
#      }
#  }
#  Pause
#  Clear-Host
#}
#
#
#
#
#################################################################
##           8 ---->             Remove Bloatware            ##
################################################################
# ____                               
#|  _ \ ___ _ __ ___   _____   _____ 
#| |_) / _ \ '_ ` _ \ / _ \ \ / / _ \
#|  _ <  __/ | | | | | (_) \ V /  __/
#|_| \_\___|_| |_| |_|\___/ \_/ \___|
#                                    
# ____  _             _                          
#| __ )| | ___   __ _| |___      ____ _ _ __ ___ 
#|  _ \| |/ _ \ / _` | __\ \ /\ / / _` | '__/ _ \
#| |_) | | (_) | (_| | |_ \ V  V / (_| | | |  __/
#|____/|_|\___/ \__,_|\__| \_/\_/ \__,_|_|  \___|
#


$bloatware = @(
    # default Windows 11 apps
    "MicrosoftTeams"
    "Microsoft.Todos"
    #"Microsoft.PowerAutomateDesktop" # Is it native with windows 11 if yes remove from here if not install with winget

    # default Windows 10 apps
    "Microsoft.549981C3F5F10"        # Cortana Offline
    "Microsoft.OneDriveSync"         # Onedrive
    "Microsoft.3DBuilder"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingTranslator"
    "Microsoft.BingWeather"
    "Microsoft.FreshPaint"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftPowerBIForWindows"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MinecraftUWP"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.Office.OneNote"
    "Microsoft.People"
    "Microsoft.Print3D"    
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"        # Mail and Calender     
    "Microsoft.WindowsMaps"
    "Microsoft.SkypeApp"
    "Microsoft.Wallet"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.ZuneVideo"
    "Microsoft.YourPhone"
    "Microsoft.MSPaint"          # Paint & Paint3D
    "Microsoft.ZuneMusic"        # New Media Player in Windows

    # Xbox Apps
    # "Microsoft.Xbox.TCUI"
    # "Microsoft.XboxApp"
    # "Microsoft.XboxGameOverlay"
    # "Microsoft.XboxGamingOverlay"
    # "Microsoft.XboxIdentityProvider"
    # "Microsoft.XboxSpeechToTextOverlay"

    # Threshold 2 apps
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.WindowsFeedbackHub"

    # Creators Update apps
    "Microsoft.Microsoft3DViewer"

    #Redstone apps
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.BingTravel"
    "Microsoft.WindowsReadingList"

    # Redstone 5 apps
    "Microsoft.MixedReality.Portal"
    "Microsoft.Whiteboard"

    # non-Microsoft
    "2FE3CB00.PicsArt-PhotoStudio"
    "46928bounde.EclipseManager"
    "613EBCEA.PolarrPhotoEditorAcademicEdition"
    "6Wunderkinder.Wunderlist"
    "7EE7776C.LinkedInforWindows"
    "89006A2E.AutodeskSketchBook"
    "9E2F88E3.Twitter"
    "A278AB0D.DisneyMagicKingdoms"
    "A278AB0D.MarchofEmpires"
    "ActiproSoftwareLLC.562882FEEB491"
    "CAF9E577.Plex"
    "ClearChannelRadioDigital.iHeartRadio"
    "D52A8D61.FarmVille2CountryEscape"
    "D5EA27B7.Duolingo-LearnLanguagesforFree"
    "DB6EA5DB.CyberLinkMediaSuiteEssentials"
    "DolbyLaboratories.DolbyAccess"
    "DolbyLaboratories.DolbyAccess"
    "Drawboard.DrawboardPDF"
    "Fitbit.FitbitCoach"
    "Flipboard.Flipboard"
    "GAMELOFTSA.Asphalt8Airborne"
    "KeeperSecurityInc.Keeper"
    "NORDCURRENT.COOKINGFEVER"
    "PandoraMediaInc.29680B314EFC2"
    "Playtika.CaesarsSlotsFreeCasino"
    "ShazamEntertainmentLtd.Shazam"
    "SlingTVLLC.SlingTV"
    "TheNewYorkTimes.NYTCrossword"
    "ThumbmunkeysLtd.PhototasticCollage"
    "TuneIn.TuneInRadio"
    "WinZipComputing.WinZipUniversal"
    "XINGAG.XING"
    "flaregamesGmbH.RoyalRevolt2"
    "king.com.*"
    "king.com.BubbleWitch3Saga"
    "king.com.CandyCrushSaga"
    "king.com.CandyCrushSodaSaga"
);


############################################################################################
### Debloating ###
# Based on this gist: https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-default-apps.ps1
function debloating {
  Check-RunAsAdministrator
  Write-Host -ForegroundColor Cyan "Remove bloatware"
  Foreach ($blt in $bloatware) {
      Write-Host -ForegroundColor Red "Removing:" $blt
      Get-AppxPackage -AllUsers $blt | Remove-AppxPackage
  }
  Pause
  Clear-Host
}






#############################################################################################
################################      Backend of Menu        ################################
#############################################################################################
# ____             _                  _          __   __  __                  
#| __ )  __ _  ___| | _____ _ __   __| |   ___  / _| |  \/  | ___ _ __  _   _ 
#|  _ \ / _` |/ __| |/ / _ \ '_ \ / _` |  / _ \| |_  | |\/| |/ _ \ '_ \| | | |
#| |_) | (_| | (__|   <  __/ | | | (_| | | (_) |  _| | |  | |  __/ | | | |_| |
#|____/ \__,_|\___|_|\_\___|_| |_|\__,_|  \___/|_|   |_|  |_|\___|_| |_|\__,_|
#


# Variables
$hasPackageManager = Get-AppxPackage -Name 'Microsoft.Winget.Source' | Select Name, Version
$hasVCLibs = Get-AppxPackage -Name 'Microsoft.VCLibs.140.00.UWPDesktop' | Select Name, Version
$hasXAML = Get-AppxPackage -Name 'Microsoft.UI.Xaml.2.7*' | Select Name, Version
$hasAppInstaller = Get-AppxPackage -Name 'Microsoft.DesktopAppInstaller' | Select Name, Version
$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$errorlog = "winget_error.log"




### Choose Number for what to do ###
function menu {
  [string]$Title = 'Ultimate Menu'
  Clear-Host
  Write-Host -ForegroundColor DarkGray "================ $Title ================"
  Write-Host
  Write-Host -ForegroundColor Blue "       Prerequisites           "
  Write-Host -ForegroundColor Blue "_______________________________"
  Write-Host "1: Reload This Script"
  Write-Host "2: Ensure PowerShell Execution Policy is set to RemoteSigned for the Current User "
  Write-Host
  Write-Host -ForegroundColor Blue "       Install/Remove Packages    "
  Write-Host -ForegroundColor Blue "__________________________________"
  Write-Host "3: Sync Choco x86 + arm64 Apps"
  Write-Host "4: Sync Choco x86 Only Apps"
  Write-Host "5: Sync Winget x86 + arm64 Apps "
  Write-Host "6: Sync Winget x86 Only Apps "
  Write-Host "7: Install Universal Microsoft Store Apps"
  Write-Host "8: Remove Bloatware"
  Write-Host
  Write-Host -ForegroundColor Blue "       Advanced Settings          "
  Write-Host -ForegroundColor Blue "__________________________________"
  Write-Host
  Write-Host
  Write-Host
  Write-Host -ForegroundColor Blue "                Admin             "
  Write-Host -ForegroundColor Blue "__________________________________"
  Write-Host -ForegroundColor Magenta "0: Quit"
  Write-Host -ForegroundColor DarkYellow "99: Test if Script is reloaded" 
  Write-Host
  
  $actions = "0"
  while ($actions -notin "0..99") {
  $actions = Read-Host -Prompt 'What you want to do?'
      if ($actions -in 0..99) {
          if ($actions -eq 0) {
              exit
          }
          if ($actions -eq 1) {
              winult
              finish
          }
          if ($actions -eq 2) {
              execution_policy 
              finish
          }
          if ($actions -eq 3) {
              install_chocolatey
              chocolatey_X86Arm64_list
              uninstall_chocolatey_list 
              get_choco_x86arm64_list
              finish
          }
          if ($actions -eq 4) {
              install_chocolatey
              chocolatey_X86_list
              uninstall_chocolatey_list 
              get_choco_x86only_list
              finish
          }
          if ($actions -eq 5) {
              install-winget
              install_winget_x86arm64_list 
              uninstall_winget_list
              get_winget_x86arm64_list
              finish
          }
          if ($actions -eq 6) {
              install-winget
              install_winget_x86_list 
              uninstall_winget_list
              get_winget_x86only_list
              finish
          }
          if ($actions -eq 7) {
              install_microsoft_store_list
              finish
          }
          if ($actions -eq 8) {
              debloating
              finish
          }
          if ($actions -eq 99) {
              Write-Host "test - netflix" 
              finish
          }
          menu
      }
      else {
          menu
      }
  }
}
menu
