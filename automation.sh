# #!/bin/bash

# install docker 
echo "Installing Docker-Compose"
apt-get update
apt-get install apt-transport-https \
                ca-certificates \
                curl gnupg \
                lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose

# installing azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#az login --service-principal -u <APP-ID> -p <PASSWORD> --tenant <TENANT-ID>
az login

# add extention to az
az extension add --name azure-iot

# container registry login 
az acr login --name tegfleettrackeracr

#apt-get install mssql-tools
#ln -sfn /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd
#sqlcmd -S testteg-fleet-tracker.database.windows.net –U testtegquest -P Quest@12345678 -i schemaScript.sql -e
#sqlcmd -S testteg-fleet-tracker.database.windows.net –U testtegquest -P Quest@12345678 -i dataScript.sql -e

curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update 
sudo apt-get install mssql-tools unixodbc-dev
sudo apt-get update 
sudo apt-get install mssql-tools
sqlcmd -S testteg-fleet-tracker.database.windows.net –U testtegquest -P Quest@12345678 -i schemaScript.sql -e
sqlcmd -S testteg-fleet-tracker.database.windows.net –U testtegquest -P Quest@12345678 -i dataScript.sql -e

#wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
#sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list)"


docker-compose up -d

