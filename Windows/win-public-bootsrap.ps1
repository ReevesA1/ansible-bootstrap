
##################################################################################
# Ensure PowerShell execution policy is set to RemoteSigned for the current user #
##################################################################################
$ExecutionPolicy = Get-ExecutionPolicy -Scope CurrentUser
if ($ExecutionPolicy -eq "RemoteSigned") {
    Write-Verbose "Execution policy is already set to RemoteSigned for the current user, skipping..." -Verbose
}
else {
    Write-Verbose "Setting execution policy to RemoteSigned for the current user..." -Verbose
    Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
}
################################################################
##                  Ensure chocolatey installed               ##
################################################################

if ([bool](Get-Command -Name 'choco' -ErrorAction SilentlyContinue)) {
    Write-Verbose "Chocolatey is already installed, skip installation." -Verbose
}
else {
    Write-Verbose "Installing Chocolatey..." -Verbose
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

################################################################
##                       Install Choco Packages               ##
################################################################

Write-Host "Installing Choco Apps"

$ChocoPackages = @(
    "bat"
    "ripgrep"
    "hackfont"
    "7zip"
    "qttabbar"
    "onecommander"
    "winaero-tweaker.install"
    "tinymediamanager"
    "object-desktop"
    "files"
    "godot"
############ not on Parallesls make a function for that################
#    "virtualbox" 
#    "virtualbox-guest-additions-guest.install
#    "icloud"
)

ForEach ($ChocoApp in $ChocoPackages)
{
    choco install $ChocoApp  -y
}


##########################


Write-Host "Removing Choco Apps"

$RemoveChocoPackages = @(
    "streamdeck"
    "logseq"
    "utorrent"
    "translucenttb"
    "freefilesync"
    "airexplorer " #Closed sourse program I thought about using to sync megasync on a schedule 
    "obsidian"
)

ForEach ($RMChocoApp in $RemoveChocoPackages)
{
    choco uninstall $RMChocoApp  -y
}



################################################################
##                       Install Winget Packages               ##
################################################################

Write-Host "Installing Winget Apps"

$WingetPackages = @(
    
    #Windows Power User
    "Microsoft.VisualStudioCode"
    "Cygwin.Cygwin" # this actualy installs it where it needs to be C:\cygwin64
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.PowerToys"


    #Browsers
    "Mozilla.Firefox"

    #Networking 
    "ZeroTier.ZeroTierOne"
    "Mega.MEGASync"
    "Google.Drive" #Im paying 25/year for 100gb might as well use it, this app will mount it as a drive



    #Privacy and Security Focused
    "IDRIX.VeraCrypt"
    "ProtonTechnologies.ProtonVPN"



    

    #Utilities
    "Lexikos.AutoHotkey"
    "File-New-Project.EarTrumpet"
    "Balena.Etcher"
    "RaspberryPiFoundation.RaspberryPiImager"
    "RustDesk.RustDesk"
    "REALiX.HWiNFO"
    "MiniTool.PartitionWizard.Free"
    "QL-Win.QuickLook"
    "ShareX.ShareX"
    "NathanOsman.NitroShare"
    "Flameshot.Flameshot"
    "Logitech.GHUB"
    "ElaborateBytes.VirtualCloneDrive"
    "VideoLAN.VLC"
    "BleachBit.BleachBit"




    #Social
    "Oxen.Session"


    #Work together (look in Notion espanso page for video)
    "Espanso.Espanso"
    "voidtools.Everything"
    "Flow-Launcher.Flow-Launcher"

    #Terminal
    #winget install -e --id Microsoft.WindowsTerminal  #should be there natively now
    "Starship.Starship"



############ not on Parallesls make a function for that################
#    "DebaucheeOpenSourceGroup.Barrier"
#    "Nvidia.GeForceExperience"
#    "Valve.Steam"

############Only if a server make a function ###################
    ##Media SERVER 
#    "Jellyfin.Server"
#    "Plex.Plex" # not sure what is different then `winget install -e --id Plex.PlexMediaPlayer`, but this install the app
#    "Plex.PlexMediaServer" #also need this for the actual server
    ##Torrent Server
#    "AppWork.JDownloader"
#    "c0re100.qBittorrent-Enhanced-Edition"
    #Gaming Server


)

ForEach ($WingetApp in $WingetPackages)
{
    winget install -e --id $WingetApp 
}


################


Write-Host "Remove Winget Apps"

$RemoveWingetPackages = @(

    # Replaced On MAc
    "Twilio.Authy" #Only using on mac now
    "Ferdium.Ferdium" # only using mail app on mac now but this app could be usefull for something else other then mail

    #Gaming
    "Nvidia.GeForceNow"
    "Libretro.RetroArch"
    "Emulationstation.Emulationstation"
    "EpicGames.EpicGamesLauncher"
    "ElectronicArts.EADesktop"
    "Amazon.Games"
    "GOG.Galaxy"
    "BlueStack.BlueStacks"

    #Media
    "XBMCFoundation.Kodi"
    "Stremio.Stremio"
    "Spotify.Spotify"
    "Amazon.Kindle"
    "Plex.PlexMediaPlayer"

    #Productivity
    "Notion.Notion"
    "MarkText.MarkText"
    "Doist.Todoist"
    "ransome1.sleek"
    "ONLYOFFICE.DesktopEditors"
    "RustemMussabekov.Raindrop"
    "KDE.Krita"
    "Joplin.Joplin"

    #Social
    "Telegram.TelegramDesktop"
    "OpenWhisperSystems.Signal"
    "Discord.Discord"
    "Caprine.Caprine"


    #Privacy and Security Focused
    "PrestonN.FreeTube"
    "OO-Software.ShutUp10"
    "Bitwarden.Bitwarden"

    #Browser 
    "TorProject.TorBrowser"

    #Linux Focused
    "Git.Git"
    "GitHub.GitHubDesktop"
    "GitHub.cli"
    "Microsoft.OpenSSH.Beta"
    "Python.Python.3.9"
    "Docker.DockerDesktop"
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
    "Stardock.Fences" # Replaced with choco object-desktop
    "Stardock.Start11" # Replaced with choco object-desktop


)

ForEach ($RMWingetApp in $RemoveWingetPackages)
{
    winget uninstall -e --id $RMWingetApp 
}


################################################################
##                  Remove Bloat Packages                     ##
################################################################


$Bloatware = @(
    #Unnecessary Windows 10 AppX Apps
    "3DBuilder"
    "Microsoft3DViewer"
    "AppConnector"
    "BingFinance"
    "BingNews"
    "BingSports"
    "BingTranslator"
    "BingWeather"
    "BingFoodAndDrink"
    "BingHealthAndFitness"
    "BingTravel"
    "MinecraftUWP"
    "GamingServices"
    # "WindowsReadingList"
    "GetHelp"
    "Getstarted"
    "Messaging"
    "Microsoft3DViewer"
    "MicrosoftSolitaireCollection"
    "NetworkSpeedTest"
    "News"
    "Lens"
    "Sway"
    "OneNote"
    "OneConnect"
    "People"
    "Print3D"
    "SkypeApp"
    "Todos"
    "Wallet"
    "Whiteboard"
    "WindowsAlarms"
    "windowscommunicationsapps"
    "WindowsFeedbackHub"
    "WindowsMaps"
    "WindowsPhone"
    "WindowsSoundRecorder"
    "ConnectivityStore"
    "CommsPhone"
    "ScreenSketch"
    "Spotify"
    "TCUI"
    #"XboxApp"
    #"XboxGameOverlay"
    #"XboxGameCallableUI"
    #"XboxSpeechToTextOverlay"
    "MixedReality.Portal"
    "ZuneMusic"
    "ZuneVideo"
    #"YourPhone"
    "Getstarted"
    "MicrosoftOfficeHub"

    #Sponsored Windows 10 AppX Apps
    #Add sponsored/featured apps to remove in the "*AppName*" format
    "EclipseManager"
    "ActiproSoftwareLLC"
    "AdobeSystemsIncorporated.AdobePhotoshopExpress"
    "Duolingo-LearnLanguagesforFree"
    "PandoraMediaInc"
    "CandyCrush"
    "BubbleWitch3Saga"
    "Wunderlist"
    "Flipboard"
    "Twitter"
    "Facebook"
    "Royal Revolt"
    "Sway"
    "Speed Test"
    "Dolby"
    "Viber"
    "ACGMediaPlayer"
    "Netflix"
    "OneCalendar"
    "LinkedInforWindows"
    "HiddenCityMysteryofShadows"
    "Hulu"
    "HiddenCity"
    "AdobePhotoshopExpress"
    "HotspotShieldFreeVPN"

    #Optional: Typically not removed but you can if you need to
    "Advertising"
    #"MSPaint"
    #"MicrosoftStickyNotes"
    #"Windows.Photos"
    #"WindowsCalculator"
    #"WindowsStore"

    # HPBloatware Packages
    "HPJumpStarts"
    "HPPCHardwareDiagnosticsWindows"
    "HPPowerManager"
    "HPPrivacySettings"
    "HPSupportAssistant"
    "HPSureShieldAI"
    "HPSystemInformation"
    "HPQuickDrop"
    "HPWorkWell"
    "myHP"
    "HPDesktopSupportUtilities"
    "HPQuickTouch"
    "HPEasyClean"
    "HPSystemInformation"
)

Write-Host "Removing Bloatware"

foreach ($Bloat in $Bloatware) {
    Get-AppxPackage "*$Bloat*" | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like "*$Bloat*" | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    Write-Host "Trying to remove $Bloat."
}


################################################################
##               Classic Right Click Menu                      ##
################################################################

Write-Host "Restoring Classic Right CLick Menu"
New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Name "InprocServer32" -force -value ""       
 
    



################################################################
##               Final Touches                                ##
################################################################

Write-Output "Restart computer "


#####################################################################
##     XXXXXXXXXXXXXX  These dont work yet XXXXXXXXXXXXXXXXXXXXX   ##
#####################################################################

#Restart-Computer

#Install-WindowsUpdate -AcceptEula -GetUpdatesFromMS