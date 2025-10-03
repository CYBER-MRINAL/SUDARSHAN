#!/bin/bash
# Keyword Search

module_06_keyword() {
  echo ""
  echo " Keyword Search"
  echo "1) Grep"
  echo "2) Ripgrep"
  echo "3) Strings"
  echo "4) YARA"
  echo "5) Back"
  echo ""
  read -p " (SUDARSHAN)> " opt

  case $opt in
    1) read -p "Keyword: " k; read -p "Target file/dir: " t; grep -rn "$k" $t | tee -a "$BASE_DIR/cases/$CURRENT_CASE/keywords.txt";;
    2) read -p "Keyword: " k; read -p "Target: " t; rg "$k" $t | tee -a "$BASE_DIR/cases/$CURRENT_CASE/keywords.txt";;
    3) read -p "File: " f; strings $f | tee -a "$BASE_DIR/cases/$CURRENT_CASE/strings.txt";;
    4) read -p "Rules: " r; read -p "Target: " t; yara -r $r $t | tee -a "$BASE_DIR/cases/$CURRENT_CASE/yara.txt";;
    5) return;;
    *) echo "Invalid option";;
  esac
}

