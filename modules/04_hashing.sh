#!/bin/bash
# Hashing & Integrity

module_04_hashing() {
  echo ""
  echo " Hashing"
  echo "1) MD5"
  echo "2) SHA256"
  echo "3) Fuzzy Hash (ssdeep)"
  echo "4) Verify Known Hashes"
  echo "5) Back"
  echo ""
  read -p " (SUDHARSHAN)> " opt

  case $opt in
    1) read -p "File: " f; md5sum $f | tee -a "$BASE_DIR/cases/$CURRENT_CASE/hashes.txt";;
    2) read -p "File: " f; sha256sum $f | tee -a "$BASE_DIR/cases/$CURRENT_CASE/hashes.txt";;
    3) read -p "File: " f; ssdeep $f | tee -a "$BASE_DIR/cases/$CURRENT_CASE/hashes.txt";;
    4) read -p "File: " f; read -p "Hashlist file: " list; grep -F $(sha256sum $f | cut -d' ' -f1) $list && echo "Match found";;
    5) return;;
    *) echo "Invalid option";;
  esac
}

