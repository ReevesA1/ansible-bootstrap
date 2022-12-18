
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

Write-Host "Installing Winget Apps not on Parallels"

$WingetPackages = @(
    
    #####Networking 
    "DebaucheeOpenSourceGroup.Barrier"
    "ZeroTier.ZeroTierOne"
    "Mega.MEGASync"
    "Google.Drive" #Im paying 25/year for 100gb might as well use it, this app will mount it as a drive
   ####Social
    "Oxen.Session"
    "Discord.Discord"
   ####Media
   "Spotify.Spotify"
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
)

############Only if a server make a function ###################

Write-Host "Installing Winget Apps  only on Server"

$WingetPackages = @(
    
  
    ##Media SERVER 
    "Plex.PlexMediaServer"
    ##Torrent Server
    "AppWork.JDownloader"
    "c0re100.qBittorrent-Enhanced-Edition" #if not able to make scedule and to access from other local PC's Use Choco Utorrent
 
)






################################################################
##               Classic Right Click Menu                      ##
################################################################

Write-Host "Restoring Classic Right CLick Menu"
New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Name "InprocServer32" -force -value ""       

Write-Host "Restoring Default Windows 11 Right Click Menu Layout"
Remove-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Recurse -Confirm:$false -Force
 
    



################################################################
##               Final Touches                                ##
################################################################

Write-Output "Restart computer !!!!!!!!!!!!!!"


#####################################################################
##     XXXXXXXXXXXXXX  These dont work yet XXXXXXXXXXXXXXXXXXXXX   ##
#####################################################################

#Restart-Computer

#Install-WindowsUpdate -AcceptEula -GetUpdatesFromMS