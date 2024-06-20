#! /bin/bash

# set -x
which code >/dev/null 2>&1
IS_CODE=$?
which codium >/dev/null 2>&1
IS_CODIUM=$?
IS_CODE_ALIAS=$(alias code 2>/dev/null | grep -q "alias code='codium'" && echo 0 || echo 1)
BIN_TO_USE=""
if [ $IS_CODE -ne 0 ] && [ $IS_CODIUM -ne 0 ] && [ $IS_CODE_ALIAS -ne 0 ]; then
    echo "Please install Visual Studio Code or Codium first"
    exit 1
elif [ $IS_CODE -eq 0 ] || [ $IS_CODE_ALIAS -eq 0 ]; then
    echo "VSCode found (or aliased to Codium)"
    BIN_TO_USE="code"
elif [ $IS_CODIUM -eq 0 ]; then
    echo "Codium found"
    BIN_TO_USE="codium"
fi

install_extensions() {
    clear
    EXTENSIONS_SET=$1
    STRING_TO_PRINT=$2" "$3
    echo "Installing $STRING_TO_PRINT..."
    for extension in $(cat ./extensions.json | jq -r "map(select(.\"$EXTENSIONS_SET\" != null)) | .[].\"$EXTENSIONS_SET\"[]"); do
        $BIN_TO_USE --install-extension $extension >/dev/null 2>&1
    done
    printf "\nDone! Press any key to continue..."
    read
}

reformat_set_name() {
    local input=$1
    temp=$(echo $input | sed -r 's/([a-z])([A-Z])/\1 \2/g')
    output=$(echo "$temp" | awk '{print toupper(substr($2,1,1))substr($2,2) " " toupper(substr($1,1,1))substr($1,2)}')
    echo $output
}

print_menu() {
    clear
    EXTENSIONS_SETS=$(cat ./extensions.json | jq -r 'del(.[0]) | .[] | keys[]')
    STAY_IN_MENU=true
    while [ $STAY_IN_MENU = true ]; do
        MENU_INDEX=1
        clear
        printf "Additional Extensions Selection Menu\n\n"
        for extensionsSet in $EXTENSIONS_SETS; do
            echo $MENU_INDEX $(reformat_set_name $extensionsSet)
            ((MENU_INDEX++))
        done
        echo $MENU_INDEX "Exit"
        printf "\nPlease enter your choice: "
        read choice
        if ! [[ $choice =~ ^[0-9]+$ ]] || [ $choice -lt 1 ] || [ $choice -gt $MENU_INDEX ]; then
            clear
            echo "Incorrect input. Press any key to continue..."
            read -n 1 -s
        elif [ $choice -eq $MENU_INDEX ]; then
            STAY_IN_MENU=false
        else
            SELECTED_EXTENSIONS_SET=$(cat ./extensions.json | jq -r ".[$choice] | keys[]")
            STRING_TO_PRINT=$(reformat_set_name $SELECTED_EXTENSIONS_SET)
            echo $SELECTED_EXTENSIONS_SET
            install_extensions $SELECTED_EXTENSIONS_SET $STRING_TO_PRINT

        fi
    done
}

STRING_TO_PRINT="Core Extensions"
echo "Do you want to install the $STRING_TO_PRINT? (y/n)"
read answer
case $answer in
[yY]*)
    install_extensions "extensionsCore" $STRING_TO_PRINT
    ;;
[nN]*)
    print_menu
    ;;
*) echo "Invalid input" ;;
esac
print_menu
