#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Professional banner
print_banner() {
    printf "${CYAN}===============================================\n"
    printf "         MTProto Proxy Setup Utility\n"
    printf "===============================================${NC}\n"
}

# Show menu if no arguments provided
if [ $# -eq 0 ]; then
    print_banner
    printf "${YELLOW}Please select an option:${NC}\n"
    printf "  1) Install MTProto Proxy\n"
    printf "  2) Uninstall MTProto Proxy\n"
    printf "  3) Exit\n"
    echo
    read -p "Enter your choice [1-3]: " choice
    case $choice in
        1)
            set -- "install"
            ;;
        2)
            set -- "uninstall"
            ;;
        3)
            printf "${GREEN}Exiting.${NC}\n"
            exit 0
            ;;
        *)
            printf "${RED}Invalid option. Exiting.${NC}\n"
            exit 1
            ;;
    esac
fi

# Uninstall option
if [ "$1" = "uninstall" ]; then
    print_banner
    printf "${YELLOW}Uninstalling MTProto Proxy...${NC}\n"
    docker stop mtproto-proxy 2>/dev/null
    docker rm mtproto-proxy 2>/dev/null
    printf "${YELLOW}Removing MTProto proxy Docker image...${NC}\n"
    docker rmi telegrammessenger/proxy:latest 2>/dev/null
    printf "${GREEN}MTProto proxy uninstalled successfully.${NC}\n"
    exit 0
fi

# Distro checker and dependency installer
install_deps() {
    if command -v apt-get &> /dev/null; then
        echo "Detected package manager: apt-get"
        apt-get update
        apt-get install -y curl openssl grep
    elif command -v yum &> /dev/null; then
        echo "Detected package manager: yum"
        yum install -y curl openssl grep
    elif command -v dnf &> /dev/null; then
        echo "Detected package manager: dnf"
        dnf install -y curl openssl grep
    elif command -v apk &> /dev/null; then
        echo "Detected package manager: apk"
        apk add --no-cache curl openssl grep
    else
        printf "${RED}No supported package manager found. Please install curl, openssl, and grep manually.${NC}\n"
        exit 1
    fi
}

# Ensure required dependencies are installed
if ! command -v curl &> /dev/null || ! command -v openssl &> /dev/null || ! command -v grep &> /dev/null; then
    print_banner
    install_deps
fi

print_banner
echo "Starting MTProto Proxy installation..."

# Variables
PROXY_PORT=443
# Generate secret key with OpenSSL instead of xxd
if ! SECRET_KEY=$(openssl rand -hex 16); then
    echo "Error generating secret key"
    exit 1
fi

if [ -z "$SECRET_KEY" ]; then
    echo "Error: Empty secret key generated"
    exit 1
fi

TAG=$(curl -s https://api.github.com/repos/TelegramMessenger/MTProxy/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')

# Install Docker if not installed
if ! command -v docker &> /dev/null; then
    echo "Docker not found, installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
    systemctl start docker
    systemctl enable docker
fi

# Pull the latest MTProto proxy image
echo "Pulling the latest MTProto proxy image..."
docker pull telegrammessenger/proxy:latest

# Remove existing container if it exists
if docker ps -a --format '{{.Names}}' | grep -Eq '^mtproto-proxy$'; then
    echo "Removing existing MTProto proxy container..."
    docker stop mtproto-proxy 2>/dev/null
    docker rm mtproto-proxy 2>/dev/null
fi

# Run the MTProto proxy container
echo "Setting up MTProto proxy..."
docker run -d \
    --name mtproto-proxy \
    --restart always \
    -p $PROXY_PORT:443 \
    -e SECRET=$SECRET_KEY \
    telegrammessenger/proxy:latest

# Save and display the proxy information
CONFIG_FILE="mtproto_config.txt"
{
    echo "==============================================="
    echo " MTProto Proxy Configuration"
    echo "-----------------------------------------------"
    echo " Proxy IP    : $(curl -s https://api.ipify.org)"
    echo " Port        : $PROXY_PORT"
    echo " Secret Key  : $SECRET_KEY"
    echo " Tag         : $TAG"
    echo "==============================================="
    echo
    echo "Configuration saved to $CONFIG_FILE"
} | tee "$CONFIG_FILE"

echo "You can now use the above details to connect to your MTProto proxy on Telegram."