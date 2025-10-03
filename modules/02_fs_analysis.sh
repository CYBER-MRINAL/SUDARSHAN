#!/bin/bash
# File System Analysis - Sleuthkit style

module_02_fs_analysis() {
  echo ""
  echo " File System Analysis"
  echo "1) List Partitions (mmls)"
  echo "2) List Files in Image (fls)"
  echo "3) Extract File (icat)"
  echo "4) File Type Analysis (file/disktype)"
  echo "5) Back"
  echo ""
  read -p " (SUDARSHAN)> " opt

  case $opt in
    1) read -p "Image file: " img; mmls $img | tee -a "$BASE_DIR/cases/$CURRENT_CASE/fs.txt";;
    2) read -p "Image file: " img; fls -r $img | tee -a "$BASE_DIR/cases/$CURRENT_CASE/fs.txt";;
    3) read -p "Image file: " img; read -p "Inode number: " inode; icat $img $inode > "$BASE_DIR/cases/$CURRENT_CASE/extracted_$inode";;
    4) read -p "File: " file; disktype $file | tee -a "$BASE_DIR/cases/$CURRENT_CASE/fs.txt";;
    5) return;;
    *) echo "Invalid option";;
  esac
}

