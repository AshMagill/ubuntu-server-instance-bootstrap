#!/bin/bash
# Prompt for GitHub username and password
read -p "Enter your GitHub username: " username
read -s -p "Enter your GitHub password: " password
echo
# Prompt for the repository link
read -p "Enter the full GitHub repository link: " repo_link
# Prompt for the repository password
read -s -p "Enter your GitHub repository password: " repo_password
# Check if running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
# Install Docker
apt-get update
apt-get install -y docker.io
# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
# Add current user to docker group
usermod -aG docker $USER
# Clone the GitHub repository
git clone $repo_link
# Authenticate with GitHub
echo $repo_password | docker login https://docker.pkg.github.com -u $username --password-stdin
# Build and run the Docker Compose
cd Ecommerce-Business-Onepager
docker-compose up -d
