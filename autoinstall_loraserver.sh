#!/bin/sh

######################################################################################
#
#     INSTALACIÓN AUTOMATICA DE LORASERVER EN UN SERVIDOR BASADO EN DISTRIBUCIÓN UBUNTU 
#     BAREMETAL SIN DOCKER https://www.chirpstack.io/
#######################################################################################


 sudo apt-get update 

# instalación dependencias:

sudo apt-get install mosquitto
sudo apt-get install postgresql
sudo apt-get install redis-server
sudo apt-get install git 

# configurar base de loraserver network server 

sudo -i -u postgres psql -c "create role chirpstack_ns with login password 'dbpassword';"
sudo -i -u postgres psql -c "create database chirpstack_ns with owner chirpstack_ns;"

# configurar base de datos loraserver application server 

sudo -i -u postgres psql -c "create role chirpstack_as with login password 'dbpassword';"
sudo -i -u postgres psql -c "create database chirpstack_as with owner chirpstack_as;"
sudo -i -u postgres psql -d chirpstack_as -c "create extension hstore;"
sudo -i -u postgres psql -d chirpstack_as -c "create extension pg_trgm;"

# añadir repositorio loraserver 

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1CE2AFD36DBCCA00

sudo echo "deb https://artifacts.chirpstack.io/packages/3.x/deb stable main" | sudo tee /etc/apt/sources.list.d/chirpstack.list
sudo apt-get update  


# instalación application server y network server 

sudo apt-get install chirpstack-network-server
sudo apt-get install chirpstack-application-server

# bajar configuracuibes de loraserver 

mkdir -p /home/alexgm/loraserver-cfg
cd /home/alexgm/loraserver-cfg
git clone https://github.com/alexgonzalezmad/loraserver-ubuntu-autoinstall.git



