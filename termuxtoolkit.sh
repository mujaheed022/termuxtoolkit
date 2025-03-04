#!/bin/bash

# TermuxToolkit - Multi-functional toolkit for Termux

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
banner() {
    clear
    echo -e "${GREEN}"
    echo " ████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗██╗████████╗"
    echo " ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║╚██╗ ██╔╝██║ ██╔╝██║╚══██╔══╝"
    echo "    ██║   █████╗  ██████╔╝██╔████╔██║ ╚████╔╝ █████╔╝ ██║   ██║   "
    echo "    ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║  ╚██╔╝  ██╔═██╗ ██║   ██║   "
    echo "    ██║   ███████╗██║  ██║██║ ╚═╝ ██║   ██║   ██║  ██╗██║   ██║   "
    echo "    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝   ╚═╝   "
    echo -e "${NC}"
    echo "                            By Phantom Tech"
    echo
}

# Check dependencies
check_dependencies() {
    dependencies=("nmap" "curl" "hydra" "git" "python" "openssl")
    
    for dep in "${dependencies[@]}"; do
        if ! command -v $dep &> /dev/null; then
            echo -e "${YELLOW}[!] Installing $dep...${NC}"
            pkg install -y $dep 2>/dev/null || apt-get install -y $dep
        fi
    done
}

# Network Scanner
network_scan() {
    echo -e "${BLUE}[*] Enter IP range to scan (e.g., 192.168.1.0/24): ${NC}"
    read ip_range
    nmap -sn $ip_range
}

# WiFi Analyzer (Requires root)
wifi_analyzer() {
    if [ $(whoami) != "root" ]; then
        echo -e "${RED}[!] This feature requires root privileges!${NC}"
        return
    fi
    echo -e "${BLUE}[*] Starting WiFi analyzer...${NC}"
    termux-wifi-scaninfo
}

# Password Cracker
password_cracker() {
    echo -e "${BLUE}[*] Enter target IP: ${NC}"
    read target_ip
    echo -e "${BLUE}[*] Enter username: ${NC}"
    read username
    echo -e "${BLUE}[*] Enter path to password list: ${NC}"
    read passlist
    
    hydra -l $username -P $passlist $target_ip ssh
}

# DDoS Tester
ddos_test() {
    echo -e "${BLUE}[*] Enter target URL/IP: ${NC}"
    read target
    echo -e "${BLUE}[*] Enter port number: ${NC}"
    read port
    
    python -c "import socket; s=socket.socket(socket.AF_INET, socket.SOCK_DGRAM); s.connect(('$target', $port)); s.send(b'\xff'*1024)"
    echo -e "${RED}[!] DDoS test started!${NC}"
}

# Vulnerability Scanner
vuln_scan() {
    echo -e "${BLUE}[*] Enter target URL/IP: ${NC}"
    read target
    nikto -h $target
}

# System Info
system_info() {
    echo -e "\n${GREEN}=== System Information ===${NC}"
    neofetch
    echo -e "\n${GREEN}=== Storage Information ===${NC}"
    df -h
}

# Main menu
main_menu() {
    while true; do
        echo -e "\n${GREEN}[ Main Menu ]${NC}"
        echo "1. Network Scanner"
        echo "2. WiFi Analyzer (Root)"
        echo "3. Password Cracker"
        echo "4. DDoS Tester"
        echo "5. Vulnerability Scanner"
        echo "6. System Information"
        echo "7. Exit"
        
        echo -n -e "\n${BLUE}[*] Choose an option: ${NC}"
        read choice
        
        case $choice in
            1) network_scan ;;
            2) wifi_analyzer ;;
            3) password_cracker ;;
            4) ddos_test ;;
            5) vuln_scan ;;
            6) system_info ;;
            7) echo -e "${RED}[+] Exiting...${NC}"; exit 0 ;;
            *) echo -e "${RED}[!] Invalid option!${NC}" ;;
        esac
    done
}

# Initial setup
banner
check_dependencies
main_menu