#!/bin/bash

LOG_DIR="$BASE_DIR/cases"

log_event() {
  local msg="$1"
  local case_dir="$LOG_DIR/$CURRENT_CASE"
  mkdir -p "$case_dir"
  echo "$(date '+%Y-%m-%d %H:%M:%S') | $msg" >> "$case_dir/logs.txt"
  echo "{\"time\": \"$(date '+%Y-%m-%d %H:%M:%S')\", \"event\": \"$msg\"}" >> "$case_dir/logs.json"
}

