




################################################################
##               Classic Right Click Menu                      ##
################################################################

Write-Host "Restoring Classic Right CLick Menu"
New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Name "InprocServer32" -force -value ""       

Write-Host "Restoring Default Windows 11 Right Click Menu Layout"
Remove-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Recurse -Confirm:$false -Force
 


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
 Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value 0
 Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value 1
