# scripts/user_interaction.sh

confirm() {
    local prompt="$1"
    local default="$2"
    local ans

    while true; do
        read -p "$prompt [Y/n]: " ans
        case "$ans" in
            [Yy]*|[Yy][Ee][Ss]*) echo "true"; return 0 ;;
            [Nn]*|[Nn][Oo]*) echo "false"; return 0 ;;
            "") 
                if [ "$default" = "Y" ] || [ "$default" = "y" ] || [ "$default" = "Yes" ] || [ "$default" = "yes" ]; then
                    echo "true"; return 0
                else
                    echo "false"; return 0
                fi ;;
            *) echo "Please answer yes or no." ;;
        esac
    done
}

user_input() {
    local prompt="$1"
    local default="$2"
    local ans

    read -p "$prompt [$default]: " ans
    echo "${ans:-$default}"
}