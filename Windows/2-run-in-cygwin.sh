cd C:\cygwin64

./cygwinsetup.exe --quiet-mode --packages git,pip

#python3,python3-devel,python3-setuptools,gcc,make,python-pip-wheel 


/usr/bin/python3.9.exe -m pip install --upgrade pip

python3 -m pip install --user ansible



#ansible-galaxy collection install ansible.windows
#ansible-galaxy collection install chocolatey.chocolatey