
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

# ORIGINAL LINES THAT WORKED
#$Packages = @(
#    "roboform"
#    "7zip"
#)
#
#ForEach ($PackageName in $Packages)
#{
#    choco install $PackageName -y
#}

$Chocolist = @(
    #Unnecessary Windows 10 AppX Apps
    "roboform -y"
    "7zip -y"
    "firefox -y"
)




Write-Host "Installing Choco Apps"

foreach ($ChocoApp in $Chocolist) {
    choco install "*$ChocoApp*"
    Write-Host "Installing $ChocoApp."
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