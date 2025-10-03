#!/bin/bash
# Cloud & Mobile Forensics

module_11_cloud_mobile() {
  echo ""
  echo " Cloud & Mobile"
  echo "1) WhatsApp Database Parser"
  echo "2) Android Forensics (Andriller)"
  echo "3) Google Takeout Parser"
  echo "4) iTunes Backup Extraction"
  echo "5) Back"
  echo ""
  read -p " (SUDARSHAN)> " opt

  case $opt in
    1) read -p "WhatsApp DB (msgstore.db): " db; sqlite3 $db "SELECT key_remote_jid, data, timestamp FROM messages;" | tee -a "$BASE_DIR/cases/$CURRENT_CASE/whatsapp.txt";;
    2) read -p "Device Backup Path: " path; andriller -i $path -o "$BASE_DIR/cases/$CURRENT_CASE/andriller";;
    3) read -p "Google Takeout ZIP: " zip; unzip $zip -d "$BASE_DIR/cases/$CURRENT_CASE/takeout";;
    4) read -p "iTunes Backup Path: " path; idevicebackup2 unback $path "$BASE_DIR/cases/$CURRENT_CASE/itunes";;
    5) return;;
    *) echo "Invalid option";;
  esac
}

