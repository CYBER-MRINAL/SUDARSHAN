#!/bin/bash
# Timeline Analysis

module_05_timeline() {
  echo ""
  echo " Timeline Analysis"
  echo "1) Create Bodyfile (fls)"
  echo "2) Create Timeline (mactime)"
  echo "3) Log2Timeline (Plaso)"
  echo "4) Back"
  echo ""
  read -p " (SUDARSHAN)> " opt

  case $opt in
    1) read -p "Image: " img; fls -r -m / $img > "$BASE_DIR/cases/$CURRENT_CASE/bodyfile";;
    2) read -p "Bodyfile: " bf; mactime -b $bf > "$BASE_DIR/cases/$CURRENT_CASE/timeline.txt";;
    3) read -p "Image: " img; log2timeline.py "$BASE_DIR/cases/$CURRENT_CASE/plaso.dump" $img;;
    4) return;;
    *) echo "Invalid option";;
  esac
}

