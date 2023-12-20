#!/bin/bash
# Prompt for GitHub repo link
read -p "Enter the GitHub repo link: " repo_link
# Check if Docker is already installed
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io
else
    echo "Docker is already installed."
fi
# Check if Docker Compose is already installed
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose not found. Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo "Docker Compose is already installed."
fi
# Clone the GitHub repo
git clone $repo_link
repo_name=$(basename $repo_link .git)
cd $repo_name
# Check if the repo is private
repo_info=$(curl -s -u $username:$github_key "https://api.github.com/repos/$repo_name")
is_private=$(echo $repo_info | jq -r '.private')
if [[ $is_private == "true" ]]; then
    # Prompt for GitHub credentials
    read -p "Enter your GitHub username: " username
    read -p "Enter your GitHub key: " github_key
    # Configure GitHub credentials for cloning private repos
    git config --global credential.helper store
    git config --global user.name $username
    git config --global user.password $github_key
fi
# Pull the latest changes from the repo
git pull
# Run any additional commands or setup steps here
# Reset GitHub credentials
git config --global --unset user.name
git config --global --unset user.password
# Change permissions for docker-compose
sudo chmod +x docker-compose
# Start Docker Compose
sudo docker-compose up -d

