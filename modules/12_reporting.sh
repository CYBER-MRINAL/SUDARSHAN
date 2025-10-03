#!/bin/bash
# Report Generation

module_12_reporting() {
  echo ""
  echo " Reporting"
  echo "1) Consolidate Logs into Markdown"
  echo "2) Convert Markdown → PDF"
  echo "3) Convert Markdown → HTML"
  echo "4) Back"
  echo ""
  read -p " (SUDHARSHAN)> " opt

  case $opt in
    1) report="$BASE_DIR/reports/${CURRENT_CASE}_report.md"
       echo "# Forensic Report: $CURRENT_CASE" > $report
       echo "Generated on: $(date)" >> $report
       echo "---------------------------------" >> $report
       for f in $BASE_DIR/cases/$CURRENT_CASE/*.txt; do
         echo -e "\n## $(basename $f)\n" >> $report
         cat $f >> $report
       done
       echo "Report created at $report"
       ;;
    2) md="$BASE_DIR/reports/${CURRENT_CASE}_report.md"; pdf="$BASE_DIR/reports/${CURRENT_CASE}_report.pdf"
       pandoc $md -o $pdf; echo "PDF report created: $pdf";;
    3) md="$BASE_DIR/reports/${CURRENT_CASE}_report.md"; html="$BASE_DIR/reports/${CURRENT_CASE}_report.html"
       pandoc $md -o $html; echo "HTML report created: $html";;
    4) return;;
    *) echo "Invalid option";;
  esac
}

