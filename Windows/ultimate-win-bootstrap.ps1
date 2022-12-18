# Based on https://github.com/Kugane/winget
################################################################
##                      Shared Function                       ##
################################################################
Function Check-RunAsAdministrator()
{
    #Get current user context
    $CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    
    #Check user is running the script is member of Administrator Group
    if($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
    {
        Write-host "Script is running with Administrator privileges!"
    }
    else
      {
        #Create a new Elevated process to Start PowerShell
        $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";

        # Specify the current script path and name as a parameter
        $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"

        #Set the Process to elevated
        $ElevatedProcess.Verb = "runas"

        #Start the new elevated process
        [System.Diagnostics.Process]::Start($ElevatedProcess)

        #Exit from the current, unelevated, process
        Exit
       
  }
}

#The Commented line below is the line I add to scripts to check if Script is running with Elevated Privileges
#Check-RunAsAdministrator

#Place your script here.
#write-host "Welcome"


################################################
##      1 ---->    Reload This Script         ##
################################################

function winult {$ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Windows/ultimate-win-bootstrap.ps1
  Invoke-Expression $($ScriptFromGithHub.Content)}


#########################################################################################################
##      1 ---->    Ensure PowerShell execution policy is set to RemoteSigned for the current user      ##
#########################################################################################################

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
##                  Ensure chocolatey installed               ##
################################################################

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

################################################################
##        1 ---->     WINGET GUI Packages                     ##
################################################################

### Here can you add apps that you want to configure during installation ###
# just add the app id from winget
$winget_gui_list = @(
    @{name = "Mozilla.Firefox"}
);



############################################################################################
function install_winget_gui_list {
  Write-Host -ForegroundColor Cyan "Installing new Apps in winget_gui_list"
  Foreach ($winget_gui_app in $winget_gui_list) {
      $list_winget_gui_app = winget list --exact -q $winget_gui_app.name
      if (![String]::Join("", $list_winget_gui_app).Contains($winget_gui_app.name)) {
          Write-Host -ForegroundColor Yellow "Install:" $winget_gui_app.name
          if ($winget_gui_app.source -ne $null) {
              winget install --exact --interactive --accept-package-agreements --accept-source-agreements $winget_gui_app.name --source $winget_gui_app.source
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $winget_gui_app.name "successfully installed."
              }
              else {
                  $winget_gui_app.name+ " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $winget_gui_app.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }
          }
          else {
              winget install --exact --interactive --accept-package-agreements --accept-source-agreements $winget_gui_app.name
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $winget_gui_app.name "successfully installed."
              }
              else {
                  $winget_gui_app.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $winget_gui_app.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }            
          }
      }
      else {
          Write-Host -ForegroundColor Yellow "Skip installation of" $winget_gui_app.name
      }
  }
  Pause
  Clear-Host
}


################################################################
##          2 ---->      Winget Silent Packages               ##
################################################################


### Winget apps are installed silently for all users ###
# just add the app id from winget
$winget_silent_list = @(
    @{name = "LibreWolf.LibreWolf" }
);


############################################################################################
function install_winget_silent_list {
  Write-Host -ForegroundColor Cyan "Installing new Apps in winget_silent_list"
  Foreach ($winget_silent_app in $winget_silent_list) {
      $list_winget_silent_app = winget list --exact -q $winget_silent_app.name
      if (![String]::Join("", $list_winget_silent_app).Contains($winget_silent_app.name)) {
          Write-Host -ForegroundColor Yellow  "Install:" $winget_silent_app.name
          # MS Store apps
          if ($winget_silent_app.source -ne $null) {
              winget install --exact --silent --accept-package-agreements --accept-source-agreements $winget_silent_app.name --source $winget_silent_app.source
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $winget_silent_app.name "successfully installed."
              }
              else {
                  $winget_silent_app.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $winget_silent_app.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }    
          }
          # All other Apps
          else {
              winget install --exact --silent --scope machine --accept-package-agreements --accept-source-agreements $winget_silent_app.name
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $winget_silent_app.name "successfully installed."
              }
              else {
                  $winget_silent_app.name+ " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $winget_silent_app.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }  
          }
      }
      else {
          Write-Host -ForegroundColor Yellow "Skip installation of" $winget_silent_app.name
      }
  }
  Pause
  Clear-Host
}



################################################################
##        3 ---->        Microsoft Store Packages ETC         ##
################################################################

### These apps are installed silently for all users ###
# for msstore apps you need to specify the source like below
$microsoft_store_list = @(
#    @{name = "Microsoft.VC++2015-2022Redist-x86" }
#    @{name = "Microsoft.VC++2015-2022Redist-x64" }      
#    @{name = "Microsoft.VC++2015-2022Redist-arm64" }    # THought it could maybe fix my parallels issue but it does not have a candidate
    @{name = "9WZDNCRFJ3TJ"; source = "msstore" }        # Netflix
    @{name = "9P6RC76MSMMJ"; source = "msstore" }        # Prime Video
);


############################################################################################
function install_microsoft_store_list {
  Write-Host -ForegroundColor Cyan "Installing new apps in microsoft_store_list"
  Foreach ($microsoft_store_app in $microsoft_store_list) {
      $list_microsoft_store_app = winget list --exact -q $microsoft_store_app.name
      if (![String]::Join("", $list_microsoft_store_app).Contains($microsoft_store_app.name)) {
          Write-Host -ForegroundColor Yellow  "Install:" $microsoft_store_app.name
          # MS Store apps
          if ($microsoft_store_app.source -ne $null) {
              winget install --exact --silent --accept-package-agreements --accept-source-agreements $microsoft_store_app.name --source $microsoft_store_app.source
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $microsoft_store_app.name "successfully installed."
              }
              else {
                  $microsoft_store_app.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $microsoft_store_app.name"couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }    
          }
          # All other Apps
          else {
              winget install --exact --silent --scope machine --accept-package-agreements --accept-source-agreements $microsoft_store_app.name
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $microsoft_store_app.name "successfully installed."
              }
              else {
                  $microsoft_store_app.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $microsoft_store_app.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }  
          }
      }
      else {
          Write-Host -ForegroundColor Yellow "Skip installation of" $microsoft_store_app.name
      }
  }
  Pause
  Clear-Host
}




################################################################
##                       Remove Bloateware                    ##
################################################################

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
    "4DF9E0F8.Netflix"
    "SpotifyAB.SpotifyMusic"
    "Facebook.Facebook"
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
  Write-Host -ForegroundColor Cyan "Remove bloatware"
  Foreach ($blt in $bloatware) {
      Write-Host -ForegroundColor Red "Removing:" $blt
      Get-AppxPackage -AllUsers $blt | Remove-AppxPackage
  }
  Pause
  Clear-Host
}




################################################################
##                      Get List of installed Apps            ##
################################################################


function get_list {
  $timestamp = get-date -Format dd_MM_yyyy
  $newPath = "$DesktopPath\" + "winget_"+ $env:computername + "_$timestamp" + ".txt"
  Write-Host -ForegroundColor Yellow "Generating Applist..."
  winget list > $newPath
  Write-Host -ForegroundColor Magenta "List saved on $newPath"
  Pause
}

################################################################
##                      Finished   Choices                    ##
################################################################

function finish {
  Write-Host
  Write-Host -ForegroundColor Magenta  "Installation finished"
  Write-Host
  Pause
}




#############################################################################################
################################      Backend of Menu        ################################
#############################################################################################



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
  Write-Host "================ $Title ================"
  Write-Host
  Write-Host "1: Reload This Script"
  Write-Host "2: Ensure PowerShell execution policy is set to RemoteSigned for the current user "
  Write-Host "3: Ensure chocolatey is installed " 
  Write-Host
  Write-Host -ForegroundColor Magenta "0: Quit"
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
              finish
          }
          if ($actions -eq 4) {
              install_microsoft_store_list
              finish
          }
          if ($actions -eq 5) {
              debloating
              finish
          }
          if ($actions -eq 6) {
              get_list
          }
          if ($actions -eq 99) {
            Write-Host "test" 
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
