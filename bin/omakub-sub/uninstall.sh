UNINSTALLER=$(gum file $OMAKUB_PATH/uninstall --height 26)

if [[ "$UNINSTALLER" = "" ]]; then
    gum format "# WARNING:"
    gum format "_uninstalling nix will uninstall_ **all** _applications installed through nix_."
    gum format "## List: "

    nix profile list | grep 'Name: ' | awk '{print $2}'
fi

[ -n "$UNINSTALLER" ] && gum confirm "Run uninstaller?" && source $UNINSTALLER && gum spin --spinner globe --title "Uninstall completed!" -- sleep 3
clear
source $OMAKUB_PATH/bin/omakub
