#!/bin/bash
# Artifact Extraction

module_07_artifacts() {
  echo ""
  echo " Artifact Extraction"
  echo "1) EXIF Metadata"
  echo "2) Windows Registry (RegRipper)"
  echo "3) Browser History"
  echo "4) PST/OST Email Extract"
  echo "5) Back"
  echo ""
  read -p " (SUDHARSHAN)> " opt

  case $opt in
    1) read -p "File: " f; exiftool $f | tee -a "$BASE_DIR/cases/$CURRENT_CASE/exif.txt";;
    2) read -p "Registry Hive: " hive; rip.pl -r $hive -f all | tee -a "$BASE_DIR/cases/$CURRENT_CASE/registry.txt";;
    3) read -p "Browser Profile Path: " bp; sqlite3 $bp "SELECT * FROM urls;" | tee -a "$BASE_DIR/cases/$CURRENT_CASE/browser.txt";;
    4) read -p "PST/OST file: " p; readpst -o "$BASE_DIR/cases/$CURRENT_CASE/mail" $p;;
    5) return;;
    *) echo "Invalid option";;
  esac
}

