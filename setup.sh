#!/bin/bash

function setup() {
  sudo dnf install ansible snapd -y
  sudo ln -s /var/lib/snapd/snap /snap

  sudo touch /var/log/workstation/ansible.log
  echo -e  "\n# Start workstation-cfg/setup.sh" >> ~/.bashrc
  echo "ANSIBLE_LOG_PATH=/var/log/workstation/ansible.log" >> ~/.bashrc
  PULL="ansible-pull -o -U ssh://git@github.com/rdong8/workstation-cfg.git |& sudo tee -a /var/log/workstation/workstation-pull.log"
  echo "alias workstation-pull=\"$PULL\"" >> ~/.bashrc
  echo -e "# End workstation-cfg/setup.sh\n" >> ~/.bashrc
  source ~/.bashrc
}

# Exit if there is an error
set -e  

# Errors if directory already exists, preventing script from accidentally being run twice
sudo mkdir /var/log/workstation/ 
sudo touch /var/log/workstation/setup.log

setup |& sudo tee -a /var/log/workstation/setup.log
