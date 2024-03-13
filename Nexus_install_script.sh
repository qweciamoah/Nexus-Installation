#!/bin/bash

#Author:PAUL AMOAH
#Date Created:13th march 2024

echo "Changing The Hostname of The EC2"
sudo hostnamectl set-hostname nexus
 
echo "Update and Upgrade the Ubuntu EC2"
sudo apt update -y >/dev/null 2>&1
sudo apt upgrade -y >/dev/null 2>&1
 
echo "Create user nexus"
# A new user called nexus and grant sudo access to manage nexus services as it is not advisable to run nexus as a root user
sudo adduser nexus
 sudo echo "nexus ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/nexus
  
  echo "Switching to nexus user and executing commands"
# Switch user context and execute subsequent commands as the nexus user
  su -c '
  echo "Installing Java and Nexus"
  (
  # Installation of Java and Verifying Java installation
  cd /opt || exit 1
  sudo apt install openjdk-8-jdk -y
   
# Installing and Extracting Nexus Repository

sudo wget https://download.sonatype.com/nexus/3/nexus-3.65.0-02-unix.tar.gz
sudo tar -xzvf nexus-3.65.0-02-unix.tar.gz 
 
 Remove The Zip File and Rename the Extracted File
 sudo rm -rf nexus-3.65.0-02-unix.tar.gz
 sudo mv nexus-3.65.0-02 nexus
  
  # Change the ownership of nexus and sonatype-work directories.
  sudo chown -R nexus:nexus /opt/nexus
  sudo chown -R nexus:nexus /opt/sonatype-work
  )
   
   echo "Configuring Nexus"
# Adding the nexus user to the nexus.rc file
 nexus='run_as_user="nexus"'
 nexusrc_path="/opt/nexus/bin/nexus.rc"
 echo "${nexus}" | sudo tee "${nexusrc_path}"
    
nexus_service_path="/etc/systemd/system/nexus.service"
content="[Unit]
Description=nexus service
After=network.target
 
[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort
 
[Install]
WantedBy=multi-user.target"
 
echo "${content}" | sudo tee -a "${nexus_service_path}"
 
echo "Starting Nexus"
# Reload the systemd daemon
 sudo systemctl daemon-reload
  
  # Start and Enable Nexus
  sudo systemctl start nexus.service
  sudo systemctl enable nexus.service
   
 echo "Nexus successfully installed. Please use the ip-address of your server and port 8081 to check your Nexus dashboard"
   ' nexus

















































