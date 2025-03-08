CHOICES=(
	"Omakub        Update Omakub itself and run any migrations"
	"Ollama        Run LLMs, like Meta's Llama3, locally"
    "Nix           Apps installed through the Nix backend"
    "Flatpak       Apps installed through the Flatpak backend"
	"<< Back       "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 10 --header "Update manually-managed applications")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
	# Don't update anything
	echo ""
else
	INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

	case "$INSTALLER" in
	"omakub") INSTALLER_FILE="$OMAKUB_PATH/bin/omakub-sub/migrate.sh" ;;
	"ollama") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/optional/app-ollama.sh" ;;
	"nix") INSTALLER_FILE="$OMAKUB_PATH/bin/omakub-sub/update-nix.sh" ;;
	"flatpak") INSTALLER_FILE="$OMAKUB_PATH/bin/omakub-sub/update-flatpak.sh" ;;
	*) INSTALLER_FILE="$OMAKUB_PATH/install/terminal/app-$INSTALLER.sh" ;;
	esac

	source $INSTALLER_FILE && gum spin --spinner globe --title "Update completed!" -- sleep 3
fi

clear
source $OMAKUB_PATH/bin/omakub
