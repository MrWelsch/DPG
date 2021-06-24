#!/bin/sh

# Checks if the environment variable USER_NAME isn't set
if [ -z "$USER_NAME" ]
# Set default username and password
then
    export USER_NAME='client'
    export USER_PASSWORD='playground'
fi

# Checks if the environment variable USER_PASSWORD isn't set
if [ -z "$USER_PASSWORD" ]
# Set default password
then
    export USER_PASSWORD='playground'
fi

# Start SSH service
service ssh start

# Add a user
useradd -rm -d /home/$USER_NAME -s /bin/bash -g root -G sudo -u 1000 $USER_NAME

# Add a password
echo "$USER_NAME:$USER_PASSWORD" | chpasswd

# Generate host keys
# Without this command a Connection Refused Error is thrown
ssh-keygen -A

# Start sshd server (check if running inside container with ps aux)
/usr/sbin/sshd &



