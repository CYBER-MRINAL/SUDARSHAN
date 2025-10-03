#!/bin/bash
# ================================================
# Case Manager - Futuristic CLI Version
# Author: Bro
# ================================================

# ===============================
# Colors & formatting
# ===============================
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
CYAN="\e[36m"
YELLOW="\e[33m"
MAGENTA="\e[35m"
BOLD="\e[1m"
RESET="\e[0m"

# ===============================
# Base directory (assume main.sh is in BASE_DIR)
# ===============================
BASE_DIR=$(dirname "$0")

# ===============================
# Current Case Variable
# ===============================
CURRENT_CASE=""

# ===============================
# Logging Function (per case)
# ===============================
log_event() {
    local message="$1"
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    if [[ -n "$CURRENT_CASE" ]]; then
        local log_file="$BASE_DIR/cases/$CURRENT_CASE/logs.json"
        mkdir -p "$(dirname "$log_file")"
        echo "{\"time\": \"$timestamp\", \"event\": \"$message\"}" >> "$log_file"
    fi

    # Optional console output
    echo -e "${CYAN}[LOG ${timestamp}]${RESET} $message"
}

# ===============================
# Create a New Case
# ===============================
create_case() {
    clear
    echo ""
    echo -e "${MAGENTA}${BOLD}  ]=======[CREATE-NEW-CASE]=======[${RESET}"
    echo -e "${MAGENTA}            BOSS DO IT ${RESET}"
    echo ""

    # Loop until a valid Case ID is entered
    while true; do
        read -p "  > NEW CASE ID: " caseid
        [[ -n "$caseid" ]] && break
        echo -e "${RED}  [!] Case ID cannot be empty!${RESET}"
    done

    while true; do
        read -p "  > INVESTIGATOR NAME: " inv
        [[ -n "$inv" ]] && break
        echo -e "${RED}  [!] Investigator Name cannot be empty!${RESET}"
    done

    CURRENT_CASE="$caseid"
    local case_dir="$BASE_DIR/cases/$caseid"
    mkdir -p "$case_dir"

    # Create metadata JSON inside the case folder
    echo "{\"case_id\": \"$caseid\", \"investigator\": \"$inv\", \"created\": \"$(date)\"}" > "$case_dir/case.json"

    echo -e "${GREEN} [✔] CASE $caseid CREATED BY $inv${RESET}"
    log_event "CASE $caseid CREATED BY $inv"
}

# ===============================
# Load an Existing Case
# ===============================
load_case() {
    clear
    echo ""
    echo -e "${MAGENTA}${BOLD}  ]======[LOAD-EXISTING-CASE]======[${RESET}"

    # Check if there are any cases
    if [[ -z "$(ls -A $BASE_DIR/cases)" ]]; then
        echo -e "${RED} [x] BOSS NOTHING FOUND. CREATE A CASE FIRST!${RESET}"
        return
    fi

    echo -e "${CYAN} > AVAILABLE CASES:${RESET}"
    ls "$BASE_DIR/cases" | nl -w2 -s'. '

    echo ""
    read -p " $(echo -e ${YELLOW}BOSS ENTER ID: ${RESET})" caseid

    if [[ -d "$BASE_DIR/cases/$caseid" ]]; then
        CURRENT_CASE="$caseid"
        echo -e "${GREEN} [✔] Case $caseid loaded successfully!${RESET}"
        log_event "Case $caseid loaded"
    else
        echo -e "${RED} [x] Case not found: $caseid${RESET}"
    fi
}

# ===============================
# Optional: Display Current Case
# ===============================
show_current_case() {
    if [[ -z "$CURRENT_CASE" ]]; then
        echo -e "${RED}No case currently loaded.${RESET}"
    else
        echo -e "${BLUE}Current Case: ${BOLD}$CURRENT_CASE${RESET}"
    fi
}

# ===============================
# Sample Menu
# ===============================
case_menu() {
    while true; do
    	clear
        echo -e "\n${MAGENTA}${BOLD}  ]=======[CASE-MANAGER-MENU]=======[${RESET}"
        echo -e " >  ${CYAN}1.${RESET} Create New Case"
        echo -e " >  ${CYAN}2.${RESET} Load Existing Case"
        echo -e " >  ${CYAN}3.${RESET} Show Current Case"
        echo -e " >  ${CYAN}4.${RESET} Exit"
        echo ""

        read -p "$(echo -e ${YELLOW} CHOOSE WHAT YOU WANT: ${RESET})" choice
        case "$choice" in
            1) create_case ;;
            2) load_case ;;
            3) show_current_case ;;
            4) echo -e "${GREEN} (^_^) Exiting Case Manager. Stay secure!${RESET}"; break ;;
            *) echo -e "${RED} Are you lost your brain screw...?${RESET}" ;;
        esac
    done
}

# ===============================
# Run Menu
# ===============================
case_menu

