#!/bin/bash
# Prompt for GitHub username and password
read -p "Enter your GitHub username: " username
read -s -p "Enter your GitHub password: " password
echo
# Install Docker
sudo apt-get update
sudo apt-get install -y docker.io
# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# Clone the GitHub repository
read -p "Enter the full GitHub repository link: " repo_link
git clone $repo_link
# Prompt for the repository password
read -s -p "Enter your GitHub repository password: " repo_password
echo
# Authenticate with GitHub
echo $repo_password | docker login https://docker.pkg.github.com -u $username --password-stdin
# Build and run the Docker Compose
cd Ecommerce-Business-Onepager
docker-compose up -d

