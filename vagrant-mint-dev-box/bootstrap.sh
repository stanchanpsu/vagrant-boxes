#!/usr/bin/env bash

# get vscode repo
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# get node repo
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -

# update packages
apt-get update

# packages to install
packagelist=(

    # virtualbox guest edition
    virtualbox-guest-dkms
    virtualbox-guest-utils
    virtualbox

    # git
    git

    # vscode
    code

    # pip3
    python3-pip

    # nodejs
    nodejs
)

# install
apt-get install -y ${packagelist[@]}

# start virtualbox client
VBoxClient --clipboard
VBoxClient --draganddrop
VBoxClient --display
VBoxClient --checkhostversion
VBoxClient --seamless

# pgrade pip3
pip3 install --upgrade pip

# install virtualenv and wrapper
pip3 install setuptools
pip3 install virtualenv
pip3 install virtualenvwrapper

# echo configurations
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> /home/vagrant/.bashrc
echo "export WORKON_HOME=~/Envs" >> /home/vagrant/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/vagrant/.bashrc
echo "alias pip='pip3'" >> /home/vagrant/.bash_aliases