#!/bin/bash
# Memory Forensics

module_09_memory() {
  echo ""
  echo " Memory Forensics"
  echo "1) Volatility2 - Process List"
  echo "2) Volatility2 - Network Connections"
  echo "3) Volatility3 - Automatic Detection"
  echo "4) Rekall Analysis"
  echo "5) Back"
  echo ""
  read -p " (SUDARSHAN)> " opt

  case $opt in
    1) read -p "Memory Dump: " mem; volatility -f $mem --profile=WinXPSP2x86 pslist | tee -a "$BASE_DIR/cases/$CURRENT_CASE/memory.txt";;
    2) read -p "Memory Dump: " mem; volatility -f $mem --profile=WinXPSP2x86 netscan | tee -a "$BASE_DIR/cases/$CURRENT_CASE/memory.txt";;
    3) read -p "Memory Dump: " mem; vol.py -f $mem windows.pslist | tee -a "$BASE_DIR/cases/$CURRENT_CASE/memory_v3.txt";;
    4) read -p "Memory Dump: " mem; rekall -f $mem pslist | tee -a "$BASE_DIR/cases/$CURRENT_CASE/rekall.txt";;
    5) return;;
    *) echo "Invalid option";;
  esac
}

