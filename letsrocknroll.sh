#!/bin/bash
# Prompt for the GitHub repository link
read -p "Enter the GitHub repository link: " repo_link
# Check if the repository link is private
if echo "$repo_link" | grep -q "github.com"; then
    read -p "Is the repository private? (y/n): " is_private
    if [[ $is_private == "y" ]]; then
        # Prompt for the username and private user key
        read -p "Enter your GitHub username: " username
        read -s -p "Enter your private user key: " private_key
        echo
        # Clone the private repository using the provided credentials
        git clone https://$username:$private_key@${repo_link#https://github.com/}
    else
        # Clone the public repository
        git clone $repo_link
    fi
else
    echo "Invalid GitHub repository link!"
fi
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
