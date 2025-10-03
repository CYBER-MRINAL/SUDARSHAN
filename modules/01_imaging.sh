#!/bin/bash

# === Colors & Styles ===
RESET="\e[0m"
BOLD="\e[1m"

CYAN="\e[96m"
GREEN="\e[92m"
YELLOW="\e[93m"
MAGENTA="\e[95m"
RED="\e[91m"
WHITE="\e[97m"
BLUE="\e[94m"

module_01_imaging() {
  echo ""
  echo -e "${GREEN}${BOLD} DISK IMAGING UTILITY ${RESET}"
  echo -e "${MAGENTA}${BOLD}]=====================[${RESET}"
  echo -e "${YELLOW}${BOLD}  1)> ${RESET} ${WHITE}${BOLD}Create Image with dd${RESET}"
  echo -e "${YELLOW}${BOLD}  2)> ${RESET} ${WHITE}${BOLD}Verify Image Hash${RESET}"
  echo -e "${YELLOW}${BOLD}  3)> ${RESET} ${RED}${BOLD}Back${RESET}"
  echo ""
  read -p " (SUDARSHAN)> " opt

  case $opt in
    1) read -p "Device: " dev; read -p "Output Image: " img;
       dd if=$dev of=$img bs=4M status=progress;
       log_event "Imaged $dev to $img";;
    2) read -p "Image File: " img; sha256sum $img | tee -a "$BASE_DIR/cases/$CURRENT_CASE/hash.txt";
       log_event "Verified hash of $img";;
    3) return;;
    *) echo "Invalid option";;
  esac
}

