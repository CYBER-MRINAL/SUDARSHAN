#!/bin/bash
# Network & PCAP Forensics

module_10_network() {
  echo ""
  echo " Network Analysis"
  echo "1) PCAP Summary (capinfos)"
  echo "2) Extract HTTP/FTP/DNS with tshark"
  echo "3) Zeek Analysis"
  echo "4) Extract Files from PCAP"
  echo "5) Back"
  echo ""
  read -p "Choose: " opt

  case $opt in
    1) read -p "PCAP File: " p; capinfos $p | tee -a "$BASE_DIR/cases/$CURRENT_CASE/network.txt";;
    2) read -p "PCAP File: " p; tshark -r $p -T fields -e ip.src -e ip.dst -e http.host | tee -a "$BASE_DIR/cases/$CURRENT_CASE/http.txt";;
    3) read -p "PCAP File: " p; mkdir -p "$BASE_DIR/cases/$CURRENT_CASE/zeek"; zeek -r $p Log::default_writer=JSON | tee -a "$BASE_DIR/cases/$CURRENT_CASE/zeek/output.json";;
    4) read -p "PCAP File: " p; tshark -r $p --export-objects http,"$BASE_DIR/cases/$CURRENT_CASE/pcap_files";;
    5) return;;
    *) echo "Invalid option";;
  esac
}

