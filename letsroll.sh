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
# Extract the repo owner and name from the link
repo_owner=$(echo "$repo_link" | awk -F'/' '{print $4}')
repo_name=$(echo "$repo_link" | awk -F'/' '{print $5}')
# Check if the repo is private
repo_info=$(curl -s "https://api.github.com/repos/$repo_owner/$repo_name")
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
