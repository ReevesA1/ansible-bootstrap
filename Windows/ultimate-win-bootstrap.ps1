# Base on https://github.com/Kugane/winget



################################################################
##        1 ---->     WINGET GRAPHICAL INSTALL                ##
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
      $listGUI = winget list --exact -q $gui.name
      if (![String]::Join("", $listGUI).Contains($gui.name)) {
          Write-Host -ForegroundColor Yellow "Install:" $gui.name
          if ($gui.source -ne $null) {
              winget install --exact --interactive --accept-package-agreements --accept-source-agreements $gui.name --source $gui.source
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $gui.name "successfully installed."
              }
              else {
                  $gui.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $gui.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }
          }
          else {
              winget install --exact --interactive --accept-package-agreements --accept-source-agreements $gui.name
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $gui.name "successfully installed."
              }
              else {
                  $gui.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $gui.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }            
          }
      }
      else {
          Write-Host -ForegroundColor Yellow "Skip installation of" $gui.name
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
  Foreach ($winget_app in $winget_silent_list) {
      $listApp = winget list --exact -q $app.name
      if (![String]::Join("", $listApp).Contains($app.name)) {
          Write-Host -ForegroundColor Yellow  "Install:" $app.name
          # MS Store apps
          if ($app.source -ne $null) {
              winget install --exact --silent --accept-package-agreements --accept-source-agreements $app.name --source $app.source
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $app.name "successfully installed."
              }
              else {
                  $app.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $app.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }    
          }
          # All other Apps
          else {
              winget install --exact --silent --scope machine --accept-package-agreements --accept-source-agreements $app.name
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $app.name "successfully installed."
              }
              else {
                  $app.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $app.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }  
          }
      }
      else {
          Write-Host -ForegroundColor Yellow "Skip installation of" $app.name
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
    @{name = "Microsoft.VC++2015-2022Redist-x86" }
    @{name = "Microsoft.VC++2015-2022Redist-x64" }       # Package contains both ARM64 and X64 binaries. Does it fix parralles issue?
    @{name = "9WZDNCRFJ3TJ"; source = "msstore" }        # Netflix
    @{name = "9P6RC76MSMMJ"; source = "msstore" }        # Prime Video
);


############################################################################################
function install_microsoft_store_list {
  Write-Host -ForegroundColor Cyan "Installing new apps in microsoft_store_list"
  Foreach ($microsoft_store_app in $microsoft_store_list) {
      $listApp = winget list --exact -q $app.name
      if (![String]::Join("", $listApp).Contains($app.name)) {
          Write-Host -ForegroundColor Yellow  "Install:" $app.name
          # MS Store apps
          if ($app.source -ne $null) {
              winget install --exact --silent --accept-package-agreements --accept-source-agreements $app.name --source $app.source
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $app.name "successfully installed."
              }
              else {
                  $app.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $app.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }    
          }
          # All other Apps
          else {
              winget install --exact --silent --scope machine --accept-package-agreements --accept-source-agreements $app.name
              if ($LASTEXITCODE -eq 0) {
                  Write-Host -ForegroundColor Green $app.name "successfully installed."
              }
              else {
                  $app.name + " couldn't be installed." | Add-Content "$DesktopPath\$errorlog"
                  Write-Host
                  Write-Host -ForegroundColor Red $app.name "couldn't be installed."
                  Write-Host -ForegroundColor Yellow "Write in $DesktopPath\$errorlog"
                  Write-Host
                  Pause
              }  
          }
      }
      else {
          Write-Host -ForegroundColor Yellow "Skip installation of" $app.name
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
##                      Finished                              ##
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




### Question what to do ###
function menu {
  [string]$Title = 'Ultimate Menu'
  Clear-Host
  Write-Host "================ $Title ================"
  Write-Host
  Write-Host "1: Do all steps below"
  Write-Host "2: Install winget_gui_list" 
  Write-Host "3: Install winget_silent_list" 
  Write-Host "4: Install microsoft_store_list" 
  Write-Host "5: Remove bloatware"
  Write-Host "6: Get List of all winget installed Apps"
  Write-Host
  Write-Host -ForegroundColor Magenta "0: Quit"
  Write-Host
  
  $actions = "0"
  while ($actions -notin "0..7") {
  $actions = Read-Host -Prompt 'What you want to do?'
      if ($actions -in 0..7) {
          if ($actions -eq 0) {
              exit
          }
          if ($actions -eq 1) {
              install_winget_gui_list
              install_winget_silent_list
              install_microsoft_store_list
              debloating
              finish
          }
          if ($actions -eq 2) {
              install_winget_gui_list
              finish
          }
          if ($actions -eq 3) {
              install_winget_silent_list
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
          if ($actions -eq 7) {
              install_winget
              get_list
          }
          menu
      }
      else {
          menu
      }
  }
}
menu
