
################################################################
##                  Sections To Incorporate                   ##
################################################################


### Apps Sections

- Restart
- Update

### Advanced Options Section

- right click menu + steal more from titus and internet
- hotkeys

### Directories Section

- Home Folder to remove and add My default directories (gitgub, megasync etc(
    - put here `C:\Users\rocket`
- Copy Read Me so I can follow along build on each machine

### Module Section

- Windows Update Module (titus)
- Install-Module Steam and then I could install wallpaper engine and maybe stardew
- Ive got other modules bookmarked in mozilla

### Dock/Taskbar Section

- Use chatgpt do add icons to taskbar
- other taskbar options?
- File Explorer Quick Access Paths


################################################################
##               Make a ultimate commands that runs everything  ##
################################################################


################################################################
##               Hotkeys                                   ##
################################################################




################################################################
##               Directories                        ##
################################################################
    
- As Admin open the Newest Version of PowerShell and create new profile
    - `New-Item $PROFILE.CurrentUserAllHosts -ItemType File -Force`
    - `Notepad $PROFILE.CurrentUserAllHosts`



################################################################
##               Update                           ##
################################################################
# How to string together? 
winget upgrade --all
Get-WindowsUpdate -install -MicrosoftUpdate -AcceptAll | Out-File -FilePath "$($env:USERPROFILE)\Desktop\MSUpdates.log" -Force
#update Profile
Invoke-WebRequest -Uri https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Windows/PowerShell_profile.ps1 -OutFile $PROFILE.CurrentUserAllHosts

################################################################
##               Restart                               ##
################################################################

Write-Output "Restart computer !!!"
Restart-Computer


################################################################
##               change the user account control (UAC)                             ##
################################################################

# TO hardcord disables normal mode all together allways in power shell
 Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin' -Value 0 # 0 is off 3 is Always notify but nothing in between seems to work

  
