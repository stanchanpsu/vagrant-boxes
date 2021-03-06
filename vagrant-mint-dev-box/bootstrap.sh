#!/usr/bin/env bash

# Install curl
apt install -y curl

# get vscode repo
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# get node repo
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

# update packages
apt update
apt upgrade

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

    # nodejs
    nodejs
)

# install
apt install -y ${packagelist[@]}

# start virtualbox client
VBoxClient --clipboard
VBoxClient --draganddrop
VBoxClient --display
VBoxClient --checkhostversion
VBoxClient --seamless

# install and upgrade pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
rm get-pip.py
pip install --upgrade pip

# install pipenv
pip install pipenv

# aliases
echo "alias ga='git add .'" >> /home/vagrant/.bash_aliases
echo "alias gcm='git commit -m'" >> /home/vagrant/.bash_aliases
echo "alias gp='git push'" >> /home/vagrant/.bash_aliases
echo "alias gs='git status'" >> /home/vagrant/.bash_aliases
echo "alias led='xset led 3'" >> /home/vagrant/.bash_aliases
echo "alias bp='code ~/.bashrc'"  >> /home/vagrant/.bash_aliases
echo "alias sbp='source ~/.bashrc'"  >> /home/vagrant/.bash_aliases

# Configure git
git config --global user.name "Stan Chan"
git config --global user.email stanchanpsu@outlook.com
git config --global credential.helper cache
git config --global credential.helper "cache --timeout=360000"
git config --global push.default matching