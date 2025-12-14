#!/bin/bash

VERSION="1.0.0"


# Colors
CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
MAGENTA='\033[1;35m'
UNDERLINE='\033[4m'
RESET='\033[0m'

if [[ "$1" == "--version" ]]; then
    echo -e "${GREEN} Bit Leaker ${YELLOW}v$VERSION ${RESET}"
    exit 0
fi

if [[ "$1" == "--update" ]]; then
    echo -e "${GREEN}[*] Updating Bit Leak...${RESET}"

    UPDATE_URL="https://raw.githubusercontent.com/ABHINAV-321/bit-leaker/master/bitleaker.sh"
    TMP_FILE=$(mktemp)

    if ! curl -fsSL "$UPDATE_URL" -o "$TMP_FILE"; then
        echo -e "${RED}[X] Failed to download update${RESET}"
        rm -f "$TMP_FILE"
        exit 1
    fi

    # Verify it's a bash script (NOT HTML)
    if ! head -n 1 "$TMP_FILE" | grep -q "bash"; then
        echo -e "${RED}[X] Update file is invalid (HTML detected)${RESET}"
        rm -f "$TMP_FILE"
        exit 1
    fi

    chmod +x "$TMP_FILE"
    mv "$TMP_FILE" "$0"

    echo -e "${GREEN}[✓] Update successful! Restart the tool.${RESET}"
    exit 0
fi

# ------------------ Dependency Check ------------------

REQUIRED_TOOLS=(wget curl stat  awk)

install_tool() {
    tool=$1
    echo -e "\e[1;33m[!] Installing missing dependency: $tool\e[0m"

    if command -v apt >/dev/null 2>&1; then
        sudo apt update -y >/dev/null 2>&1
        sudo apt install -y "$tool"
    elif command -v pkg >/dev/null 2>&1; then
        pkg install -y "$tool"
    else
        echo -e "\e[1;31m[X] Unsupported package manager. Install $tool manually.\e[0m"
        exit 1
    fi
}

echo -e "\e[1;36m[*] Checking required tools...\e[0m"

for tool in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        install_tool "$tool"
    else
        echo -e "\e[1;32m[✓] $tool is installed\e[0m"
    fi
done

echo -e "\e[1;32m[✓] All required tools are ready!\e[0m"
sleep 2

# ------------------------------------------------------

clear



# Info
echo -e "${CYAN}====================================${RESET}"
echo -e "${GREEN}BIT LEAK${RESET}"
echo -e "${CYAN}====================================${RESET}"
echo
echo -e "${YELLOW}This tool generates continuous network traffic"
echo -e "for testing and bandwidth usage purposes.${RESET}"
echo
echo -e "${RED}To stop the tool at any time, press CTRL + C${RESET}"
echo
echo -e "${GREEN}GitHub:${RESET} ${UNDERLINE}https://github.com/ABHINAV-321${RESET}"
echo

# Y/N prompt
while true; do
    read -rp "Do you want to continue? (y/n): " choice
    case "$choice" in
        y|Y)
            
    echo
    echo
    echo "============================================"
    echo -e  "${GREEN}STARTED WASTING YOUR BANDWIDTH .........${RESET}"
    echo "============================================"
    echo
            break
            ;;
        n|N)
            echo -e "${RED}Exiting. Goodbye!${RESET}"
            exit 0
            ;;
        *)
            echo "Please enter y or n."
            ;;
    esac
done

# URLs
urls=(
    "https://download.rockylinux.org/pub/rocky/10/isos/x86_64/Rocky-10.1-x86_64-dvd1.iso"
    "https://downloads.sourceforge.net/project/cutefish-ubuntu/ISO/Ubuntu/CutefishOS-22.04.0-YoYo-beta-amd64.iso"
    "https://ash-speed.hetzner.com/10GB.bin"
)

start_time=$(date +%s)
last_check_time=$start_time
last_total=0
total_downloaded=0
loop_count=0
output_file=""
current_file_size=0

# Trap CTRL+C
trap finish_script INT

finish_script() {
    clear

    # Count partial download if exists
    if [ -n "$output_file" ] && [ -f "$output_file" ]; then
        partial_size=$(stat -c%s "$output_file" 2>/dev/null || echo 0)
        total_downloaded=$((total_downloaded + partial_size))
        rm -f "$output_file"
    fi

    mb=$(awk "BEGIN {printf \"%.2f\", $total_downloaded/1024/1024}")
    gb=$(awk "BEGIN {printf \"%.2f\", $total_downloaded/1024/1024/1024}")    


    echo -e "${CYAN}"
cat << "EOF"
██████╗ ██╗████████╗
██╔══██╗██║╚══██╔══╝
██████╔╝██║   ██║   
██╔══██╗██║   ██║   
██████╔╝██║   ██║   
╚═════╝ ╚═╝   ╚═╝   

██╗     ███████╗ █████╗ ██╗  ██╗
██║     ██╔════╝██╔══██╗██║ ██╔╝
██║     █████╗  ███████║█████╔╝ 
██║     ██╔══╝  ██╔══██║██╔═██╗ 
███████╗███████╗██║  ██║██║  ██╗
╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
EOF
    echo -e "${RESET}"

    echo
    echo -e "${RED}>>> created by ${CYAN} ABHINAV ${RED} <<<${RESET}"
    echo
    echo -e "${CYAN}You pressed CTRL + C${RESET}"
    echo
    echo -e "${YELLOW}Total Downloaded:${RESET}"
    echo -e "${MAGENTA}$total_downloaded bytes${RESET}"
    echo -e "${MAGENTA}$mb MB${RESET}"
    echo -e "${MAGENTA}$gb GB${RESET}"
    echo
    echo -e "${GREEN}Thanks for wasting bandwidth responsibly ❤️😂${RESET}"

    exit 0
}
#download 
 download_file() {
    url="$1"
    out="$2"

    # Try curl first (silent)
    if command -v curl >/dev/null 2>&1; then
        curl -L -s --fail "$url" -o "$out"
        if [ $? -eq 0 ] && [ -s "$out" ]; then
            return 0
        fi
    fi

    # Fallback to wget (silent)
    if command -v wget >/dev/null 2>&1; then
        wget -q "$url" -O "$out"
        return $?
    fi

    return 1
}

show_status() {
    now=$(date +%s)
    elapsed=$((now - start_time))
    interval=$((now - last_check_time))
    delta=$((total_downloaded - last_total))

    if [ "$interval" -gt 0 ]; then
        speed=$(awk "BEGIN {printf \"%.2f\", $delta/1024/1024/$interval}")
    else
        speed="0.00"
    fi

    total_mb=$(awk "BEGIN {printf \"%.2f\", $total_downloaded/1024/1024}")
    total_gb=$(awk "BEGIN {printf \"%.2f\", $total_downloaded/1024/1024/1024}")

    printf "\r${GREEN}Used:${RESET} %s MB (%s GB) | ${CYAN}Speed:${RESET} %s MB/s | ${YELLOW}Time:${RESET} %02d:%02d:%02d" \
        "$total_mb" "$total_gb" "$speed" \
        $((elapsed/3600)) $(((elapsed/60)%60)) $((elapsed%60))

    last_check_time=$now
    last_total=$total_downloaded
}


#Main loop 
while true; do
    loop_count=$((loop_count + 1))

    random_index=$((RANDOM % ${#urls[@]}))
    random_url="${urls[$random_index]}"
    output_file="download_$(date +%s)"

    current_file_size=0

    # Start download in background
    download_file "$random_url" "$output_file" &
    dl_pid=$!

    # While download is running
    while kill -0 "$dl_pid" 2>/dev/null; do
        if [ -f "$output_file" ]; then
            new_size=$(stat -c%s "$output_file" 2>/dev/null || echo 0)
            delta=$((new_size - current_file_size))

            if [ "$delta" -gt 0 ]; then
                total_downloaded=$((total_downloaded + delta))
                current_file_size=$new_size
            fi
        fi

        show_status
        sleep 1
    done

    wait "$dl_pid"

    # Final cleanup
    if [ -f "$output_file" ]; then
        rm -f "$output_file"
    fi
done
cleanup
    if [ -f "$output_file" ]; then
        rm -f "$output_file"
    fi
done
]; then
        rm -f "$output_file"
    fi
done
