# Used this git repo for reference https://github.com/AlexNabokikh/windows-playbook

# Ensure PowerShell execution policy is set to RemoteSigned for the current user
$ExecutionPolicy = Get-ExecutionPolicy -Scope CurrentUser
if ($ExecutionPolicy -eq "RemoteSigned") {
    Write-Verbose "Execution policy is already set to RemoteSigned for the current user, skipping..." -Verbose
}
else {
    Write-Verbose "Setting execution policy to RemoteSigned for the current user..." -Verbose
    Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
}

# Ensure chocolatey installed
if ([bool](Get-Command -Name 'choco' -ErrorAction SilentlyContinue)) {
    Write-Verbose "Chocolatey is already installed, skip installation." -Verbose
}
else {
    Write-Verbose "Installing Chocolatey..." -Verbose
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

choco install cygwin --params "/InstallDir:C:\cygwin64 /DesktopIcon"

# the rest make a second script and run in cygwin

cd C:\cygwin64

./cygwinsetup.exe --quiet-mode --packages git,pip

pip3 install ansible

/usr/bin/python3.7 -m pip install --upgrade pip

#ansible-galaxy collection install ansible.windows
#ansible-galaxy collection install chocolatey.chocolatey