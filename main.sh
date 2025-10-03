#!/usr/bin/env bash
# =====================================================
# SUDARSHAN: Robust Modular Forensic Framework - main.sh
# Author: CYBER-MRINAL
# =====================================================

set -o errexit
set -o pipefail
set -o nounset

# === Colors & Styles ===
RESET="\e[0m"
BOLD="\e[1m"

CYAN="\e[96m"
GREEN="\e[92m"
YELLOW="\e[93m"
MAGENTA="\e[95m"
RED="\e[91m"
WHITE="\e[97m"
BLUE="\e[94m"

# === Resolve base dir correctly (works when script is invoked from any cwd) ===
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# === Sanity: required dirs ===
if [[ ! -d "$BASE_DIR/core" || ! -d "$BASE_DIR/modules" ]]; then
    echo -e "${RED}[!] ERROR:${RESET} required directories missing under ${BASE_DIR}"
    echo "Expected: ${BASE_DIR}/core and ${BASE_DIR}/modules"
    exit 1
fi

# === Source core components if present (optional fallback stubs) ===
if [[ -f "$BASE_DIR/core/ui.sh" ]]; then
    source "$BASE_DIR/core/ui.sh"
fi
if [[ -f "$BASE_DIR/core/logging.sh" ]]; then
    source "$BASE_DIR/core/logging.sh"
fi
if [[ -f "$BASE_DIR/core/case_manager.sh" ]]; then
    source "$BASE_DIR/core/case_manager.sh"
fi

# Provide minimal switch_case stub if not present
if ! declare -f switch_case >/dev/null 2>&1; then
    switch_case() {
        read -rp "Enter new case id: " newcase
        CURRENT_CASE="$newcase"
        echo "Switched to case: $CURRENT_CASE"
        sleep 1
    }
fi

# === Descriptions mapping (canonical keys) ===
declare -A DESCRIPTIONS
DESCRIPTIONS["imaging"]="Acquire forensic disk images"
DESCRIPTIONS["analysis"]="Analyze file system structures & metadata"
DESCRIPTIONS["carving"]="Recover deleted or hidden files"
DESCRIPTIONS["hashing"]="Generate & verify cryptographic hashes"
DESCRIPTIONS["keyword"]="Search keywords, regex, and IOC patterns"
DESCRIPTIONS["timeline"]="Build forensic activity timelines"
DESCRIPTIONS["artifacts"]="Extract OS, user, and browser artifacts"
DESCRIPTIONS["malware"]="Static & dynamic malware triage"
DESCRIPTIONS["memory"]="RAM dump analysis (Volatility, YARA)"
DESCRIPTIONS["network"]="PCAP/network traffic analysis"
DESCRIPTIONS["mobile"]="Mobile & cloud service forensics"
DESCRIPTIONS["reporting"]="Export structured forensic reports"

# === Module discovery ===
shopt -s nullglob
MODULE_FILES=()
MODULE_KEYS=()
MODULE_DISPLAY=()

for module_path in "$BASE_DIR"/modules/*.sh; do
    [[ -f "$module_path" ]] || continue
    MODULE_FILES+=("$module_path")
done
shopt -u nullglob

# If none, bail
if [[ ${#MODULE_FILES[@]} -eq 0 ]]; then
    echo -e "${RED}[!] No modules found in ${BASE_DIR}/modules${RESET}"
    exit 1
fi

# === Helper: produce canonical key from filename ===
canonicalize() {
    local filename="$1"   # e.g. "01_module_imaging.sh" or "imaging.sh" or "fs_analysis.sh"
    # strip .sh
    local base="${filename%.sh}"
    # remove leading numeric prefixes (e.g., 01_, 1-, etc)
    base="$(echo "$base" | sed -E 's/^[0-9]+[_-]*//')"
    # remove common prefixes
    base="$(echo "$base" | sed -E 's/^(module|mod|sudarshan|sudhrshan|sudhrsh|sudhrsh)[_-]*//I')"
    # keep first token before next underscore or dash (so "fs_analysis" -> "fs" if you want first token)
    # BUT we want to preserve multiword canonical names like "fs_analysis" => "fs_analysis"
    # So we'll prefer to take the full remainder but normalize separators to underscore.
    base="$(echo "$base" | sed -E 's/[- ]+/_/g')"
    # Lowercase
    base="$(echo "$base" | tr '[:upper:]' '[:lower:]')"
    # If base contains underscores and the last token is 'sh' remove it (rare).
    echo "$base"
}

# Load (source) all modules so functions are registered, but maintain canonical keys separately
MODULES=()   # indexed by 1..N for menu
idx=1
for p in "${MODULE_FILES[@]}"; do
    # source module so its function is available (module_<name>)
    # wrap in subshell to avoid unexpected side-effects? No - modules may intentionally set variables; we want them sourced.
    source "$p"
    filebase="$(basename "$p")"
    modname="${filebase%.sh}"         # raw filename without .sh
    key="$(canonicalize "$filebase")" # canonical key used for description lookup
    MODULES[$idx]="$modname"
    MODULE_KEYS[$idx]="$key"
    MODULE_DISPLAY[$idx]="$modname"
    ((idx++))
done

TOTAL_MODULES=${#MODULES[@]}
VERSION="v6.0"
USER="${USER:-BOSS}"
CURRENT_CASE="${CURRENT_CASE:-213}"

# DEBUG helper
DEBUG_MODE="${DEBUG:-0}"

print_debug() {
    if [[ "$DEBUG_MODE" -eq 1 ]]; then
        echo -e "${YELLOW}[DEBUG] Module discovery:${RESET}"
        for i in "${!MODULES[@]}"; do
            printf " %2d) file='%s'  key='%s'  display='%s'\n" "$i" "${MODULE_FILES[$((i-1))]}" "${MODULE_KEYS[$i]}" "${MODULE_DISPLAY[$i]}"
        done
        echo ""
    fi
}

# === Draw menu ===
draw_menu() {
    clear
    # header
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════════════╗${RESET}"
    printf "${CYAN}║${RESET}  ${BOLD}%-60s${RESET}    ${CYAN}    ║${RESET}\n" "   🚀 SUDARSHAN FORENSIC FRAMEWORK   $VERSION"
    echo -e "${CYAN}╠════════════════════════════════════════════════════════════════════╣${RESET}"
    printf "${CYAN}   <<-${RESET}  ${YELLOW}${BOLD}CASE: %-8s${RESET}  | ${BLUE}${BOLD}MODULES: %-3d${RESET}  | ${BOLD}USER: %-14s${RESET} ${CYAN}->>${RESET}\n" "$CURRENT_CASE" "$TOTAL_MODULES" "$USER"
    echo -e "${CYAN}╠════════════════════════════════════════════════════════════════════╣${RESET}"
    # list modules with descriptions
    for i in $(seq 1 "$TOTAL_MODULES"); do
        display="${MODULE_DISPLAY[$i]}"
        key="${MODULE_KEYS[$i]}"
        # try full basename first, then canonical key
        desc="${DESCRIPTIONS[$display]:-}"
        if [[ -z "$desc" ]]; then
            desc="${DESCRIPTIONS[$key]:-}"
        fi
        [[ -z "$desc" ]] && desc="No description available"
        printf "${CYAN}║${RESET} [%-2s] %-18s – %-40s ${CYAN}║${RESET}\n" "$i" "$display" "$desc"
    done
    echo -e "${CYAN}╠════════════════════════════════════════════════════════════════════╣${RESET}"
    echo -e "${CYAN}║${RESET}   ${RED}${BOLD}[H] Help   [L] Logs   [C] Switch Case   [99] Exit${RESET}            ${CYAN}    ║${RESET}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    print_debug
}

# === Main loop ===
while true; do
    draw_menu
    read -rp " (SUDARSHAN)> " choice

    # trim
    choice="${choice#"${choice%%[![:space:]]*}"}"
    choice="${choice%"${choice##*[![:space:]]}"}"

    case "$choice" in
        99)
            echo -e "${BLUE}>> SEE YOU TOMORROW, BOSS${RESET}"
            exit 0
            ;;
        [Hh])
            echo -e "${YELLOW}Help: enter the module number to run it. H=Help L=Logs C=Switch Case 99=Exit${RESET}"
            read -rp "Press Enter to continue..."
            ;;
        [Ll])
            echo -e "${GREEN}Logs for case: $CURRENT_CASE${RESET}"
            if [[ -f "$BASE_DIR/logs/${CURRENT_CASE}.log" ]]; then
                tail -n 40 "$BASE_DIR/logs/${CURRENT_CASE}.log"
            else
                echo "No logs available for case $CURRENT_CASE"
            fi
            read -rp "Press Enter to continue..."
            ;;
        [Cc])
            switch_case
            ;;
        "")
            # empty, re-draw
            ;;
        *)
            if [[ "$choice" =~ ^[0-9]+$ ]]; then
                num="$choice"
                if (( num >= 1 && num <= TOTAL_MODULES )); then
                    mod="${MODULES[$num]}"
                    func="module_${mod}"
                    if declare -f "$func" >/dev/null 2>&1; then
                        # call it with case id
                        "$func" "$CURRENT_CASE"
                    else
                        echo -e "${RED}[!] Module function '${func}' not found in ${MODULE_FILES[$((num-1))]}${RESET}"
                        read -rp "Press Enter to continue..."
                    fi
                else
                    echo -e "${RED}[!] Invalid module index${RESET}"
                    sleep 1
                fi
            else
                echo -e "${RED}[!] Invalid input${RESET}"
                sleep 1
            fi
            ;;
    esac
done

