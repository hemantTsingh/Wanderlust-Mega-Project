#!/bin/bash

# Set the Instance ID and path to the .env file

# Retrieve the public IP address of the specified EC2 instance
ipv4_address=$(curl -s ifconfig.me)

# Path to the .env file
file_to_find="../frontend/.env.docker"

# Check the current VITE_API_PATH in the .env file
current_url=$(cat $file_to_find)

# Update the .env file if the IP address has changed
if [[ "$current_url" != "VITE_API_PATH=\"http://${ipv4_address}:31100\"" ]]; then
    if [ -f $file_to_find ]; then
        sed -i -e "s|VITE_API_PATH.*|VITE_API_PATH=\"http://${ipv4_address}:31100\"|g" $file_to_find
    else
        echo "ERROR: File not found."
    fi
fi
