cd C:\cygwin64

./cygwinsetup.exe --quiet-mode --packages git,python3

/usr/bin/python3.9.exe -m pip install --upgrade pip

pip install ansible



#ansible-galaxy collection install ansible.windows
#ansible-galaxy collection install chocolatey.chocolatey