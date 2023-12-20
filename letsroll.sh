#!/bin/bash
# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "docker-compose is not installed. Installing..."
    # Install docker-compose
    sudo apt-get update
    sudo apt-get install -y docker-compose
fi
# Check if docker is installed
if ! command -v docker &> /dev/null; then
    echo "docker is not installed. Installing..."
    # Install docker
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
fi
# Prompt for GitHub repo link
read -p "Enter the GitHub repo link: " repo_link
# Check if the repo is private
if [[ $repo_link == *"github.com"* ]]; then
    repo_info=$(curl -s "https://api.github.com/repos${repo_link#*github.com}")
    is_private=$(echo "$repo_info" | grep -o '"private":.*' | awk '{print $2}')
    if [[ $is_private == "true," ]]; then
        # Prompt for username and private key
        read -p "Enter your GitHub username: " username
        read -s -p "Enter your private key: " private_key
        echo
        # Download the private repo using curl with authentication
        curl -u "$username:$private_key" -L "$repo_link" -o repo.zip
    else
        # Download the public repo using curl
        curl -L "$repo_link" -o repo.zip
    fi
else
    echo "Invalid GitHub repo link."
    exit 1
fi
# Unzip the downloaded repo
unzip repo.zip
# Clean up the downloaded zip file
rm repo.zip
# Change directory to the downloaded repo
cd repo
# Run any necessary commands on the downloaded repo
# ...
# Finish the script
echo "Script completed successfully."
