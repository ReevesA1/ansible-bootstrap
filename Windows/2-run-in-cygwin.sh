cd C:\cygwin64

./cygwinsetup.exe --quiet-mode --packages git,pip

pip3 install ansible

/usr/bin/python3.7 -m pip install --upgrade pip

#ansible-galaxy collection install ansible.windows
#ansible-galaxy collection install chocolatey.chocolatey