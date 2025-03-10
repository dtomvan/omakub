set_font() {
	local font_name=$1
	local file_name="${font_name/ Nerd Font/}"

	gsettings set org.gnome.desktop.interface monospace-font-name "$font_name 10"
	cp "$OMAKUB_PATH/configs/alacritty/fonts/$file_name.toml" ~/.config/alacritty/font.toml
	sed -i "s/\"editor.fontFamily\": \".*\"/\"editor.fontFamily\": \"$font_name\"/g" ~/.config/Code/User/settings.json
}

if [ "$#" -gt 1 ]; then
	choice=${!#}
else
	choice=$(gum choose "Cascadia Mono" "Fira Mono" "JetBrains Mono" "Meslo" "> Change size" "<< Back" --height 8 --header "Choose your programming font")
fi

case $choice in
"Cascadia Mono")
	set_font "CaskaydiaMono Nerd Font"
	;;
"Fira Mono")
	set_font "FiraMono Nerd Font"
	;;
"JetBrains Mono")
	set_font "JetBrainsMono Nerd Font"
	;;
"Meslo")
	set_font "MesloLGS Nerd Font"
	;;
"> Change size")
	source $OMAKUB_PATH/bin/omakub-sub/font-size.sh
	exit
	;;
esac

source $OMAKUB_PATH/bin/omakub-sub/menu.sh
