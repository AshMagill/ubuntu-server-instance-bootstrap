#!/bin/bash
# Check if docker is installed
if ! command -v docker &> /dev/null; then
    echo "docker is not installed. Installing..."
    # Install docker
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo "docker is already installed."
fi
# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "docker-compose is not installed. Installing..."
    # Install docker-compose
    sudo apt-get update
    sudo apt-get install -y docker-compose
else
    echo "docker-compose is already installed."
fi
echo "Script completed successfully."
