#!/bin/bash
# SUDARSHAN: Next-Gen Modular Forensic Framework
# Author: CYBER-MRINAL

# Colors & formatting
RESET="\e[0m"
BOLD="\e[1m"
UNDERLINE="\e[4m"

CYAN="\e[96m"
GREEN="\e[92m"
YELLOW="\e[93m"
MAGENTA="\e[95m"
RED="\e[91m"
WHITE="\e[97m"
BLUE="\e[94m"

# Typing animation
type_out() {
    local str="$1"
    local delay="${2:-0.01}"
    for ((i=0; i<${#str}; i++)); do
        echo -ne "${str:$i:1}"
        sleep "$delay"
    done
    echo
}

# Animated banner
banner() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════╗"
    echo -e "║${BOLD}        SUDARSHAN FRAMEWORK v1.0            ${RESET}${CYAN}║"
    echo -e "╠════════════════════════════════════════════╣"
    echo -e "║ DEVLOPED BY: ${YELLOW}CYBER-MRINAL${CYAN}                  ║"
    echo -e "╚════════════════════════════════════════════╝${RESET}"
    echo
}

# Animated loading bar
loading_bar() {
    echo -n " ->> INTIALIZING: ["
    for i in {1..30}; do
        echo -n ">"
        sleep 0.03
    done
    echo "] (DONE)!!"
    sleep 0.3
}

# Main startup UI
start_ui() {
    banner
    type_out " ->> WELCOME, BOSS (^_^)" 0.03
    echo
    loading_bar
}

# Call the UI
start_ui

