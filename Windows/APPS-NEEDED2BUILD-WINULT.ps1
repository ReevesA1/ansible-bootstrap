
################################################################
##                       Install Choco Packages               ##
################################################################

Write-Host "Installing Choco Apps not on Parallels"

$ChocoPackages = @(
    "virtualbox"
    "virtualbox-guest-additions-guest.install"
    "icloud"
)


Write-Host "Installing Choco Apps Only on server"

$ChocoPackages = @(
    "utorrent" # may try to use qbitorrent first

)




################################################################
##                       Install Winget Packages               ##
################################################################

Write-Host "Installing Winget Apps"

$WingetPackages = @(
    
    #Windows Power User
    "Microsoft.VisualStudioCode"
    "GitHub.GitHubDesktop"
    "Cygwin.Cygwin" # this actualy installs it where it needs to be C:\cygwin64
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.PowerToys"
    "GitHub.cli"
    "GitHub.GitHubDesktop"
    "Microsoft.PowerShell" #Newest Powershell but I can't make a AllUserALlHost Profile since Path is locked down AF but choco can't install modules
#    "Git.Git"
#    "Microsoft.OpenSSH.Beta"
#    "Python.Python.3.9"
#    "Docker.DockerDesktop"


    #Browsers
    "Mozilla.Firefox"
    "LibreWolf.LibreWolf"



    #Productivity
    "Notion.Notion"
    "MarkText.MarkText"
    "Doist.Todoist"
    "RustemMussabekov.Raindrop"

    

    #Utilities
    "Lexikos.AutoHotkey"
    "File-New-Project.EarTrumpet"
    "REALiX.HWiNFO"
    "QL-Win.QuickLook"
    "Flameshot.Flameshot"
    "VideoLAN.VLC"
    "BleachBit.BleachBit"
    "Sejda.PDFDesktop" #pdf viewer
    "angryziber.AngryIPScanner"
    






    #Work together (look in Notion espanso page for video)
    "Espanso.Espanso"
    "voidtools.Everything"
    "Flow-Launcher.Flow-Launcher"

    #Terminal
    #winget install -e --id Microsoft.WindowsTerminal  #should be there natively now
    "Starship.Starship"



############ not on Parallels make a function for that################
    #####Networking 
#    "DebaucheeOpenSourceGroup.Barrier"
#    "ZeroTier.ZeroTierOne"
#    "Mega.MEGASync"
#    "Google.Drive" #Im paying 25/year for 100gb might as well use it, this app will mount it as a drive
    ####Social
#    "Oxen.Session"
#    "Discord.Discord"
    ####Media
#   "Spotify.Spotify"
    ####Gaming
#    "Valve.Steam"
#    "Nvidia.GeForceExperience"
#    "EpicGames.EpicGamesLauncher"
#    "ElectronicArts.EADesktop"
#    "Amazon.Games"
#    "GOG.Galaxy"
    #####Privacy and Security Focused
#    "IDRIX.VeraCrypt"
#    "ProtonTechnologies.ProtonVPN"
    #### Utilities
#    "Balena.Etcher"
#    "RaspberryPiFoundation.RaspberryPiImager"
#    "MiniTool.PartitionWizard.Free"
#    "ElaborateBytes.VirtualCloneDrive"


############Only if a server make a function ###################
    ##Media SERVER 
#    "Plex.PlexMediaServer"
    ##Torrent Server
#    "AppWork.JDownloader"
#    "c0re100.qBittorrent-Enhanced-Edition" #if not able to make scedule and to access from other local PC's Use Choco Utorrent
 


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

ForEach ($RMWingetApp in $RemoveWingetPackages)
{
    winget uninstall -e --id $RMWingetApp 
}





################################################################
##               Classic Right Click Menu                      ##
################################################################

Write-Host "Restoring Classic Right CLick Menu"
New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Name "InprocServer32" -force -value ""       
 
    



################################################################
##               Final Touches                                ##
################################################################

Write-Output "Restart computer !!!!!!!!!!!!!!"


#####################################################################
##     XXXXXXXXXXXXXX  These dont work yet XXXXXXXXXXXXXXXXXXXXX   ##
#####################################################################

#Restart-Computer

#Install-WindowsUpdate -AcceptEula -GetUpdatesFromMS