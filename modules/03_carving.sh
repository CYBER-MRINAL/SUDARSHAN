#!/bin/bash
# File Carving

module_03_carving() {
  echo ""
  echo " File Carving"
  echo "1) Foremost"
  echo "2) Scalpel"
  echo "3) PhotoRec"
  echo "4) Bulk Extractor"
  echo "5) Back"
  echo ""
  read -p " (SUDARSHAN)> " opt

  case $opt in
    1) read -p "Image file: " img; foremost -i $img -o "$BASE_DIR/cases/$CURRENT_CASE/foremost";;
    2) read -p "Image file: " img; scalpel $img -o "$BASE_DIR/cases/$CURRENT_CASE/scalpel";;
    3) read -p "Image file: " img; photorec /log /d "$BASE_DIR/cases/$CURRENT_CASE/photorec" $img;;
    4) read -p "Image file: " img; bulk_extractor -o "$BASE_DIR/cases/$CURRENT_CASE/bulk" $img;;
    5) return;;
    *) echo "Invalid option";;
  esac
}

