# Exit immediately if a command exits with a non-zero status
set -e

# ... except let's not waste the user's hard drive space
cleannixstore () {
    echo "Collecting garbage in the nix store..."
    nh clean all -k 3 --nogcroots
}
trap cleannixstore EXIT

# Check the distribution name and version and abort if incompatible
source ~/.local/share/omakub/install/check-version.sh

# Install nix before starting the choose sequence
source ~/.local/share/omakub/install/terminal/required/app-nix.sh >/dev/null

# Ask for app choices
echo "Get ready to make a few choices..."
source ~/.local/share/omakub/install/terminal/required/app-gum.sh >/dev/null
source ~/.local/share/omakub/install/first-run-choices.sh

# Desktop software and tweaks will only be installed if we're running Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  # Ensure computer doesn't go to sleep or lock while installing
  gsettings set org.gnome.desktop.screensaver lock-enabled false
  gsettings set org.gnome.desktop.session idle-delay 0

  echo "Installing terminal and desktop tools..."

  # Install terminal tools
  source ~/.local/share/omakub/install/terminal.sh

  # Install desktop tools and tweaks
  source ~/.local/share/omakub/install/desktop.sh

  # Revert to normal idle and lock settings
  gsettings set org.gnome.desktop.screensaver lock-enabled true
  gsettings set org.gnome.desktop.session idle-delay 300
else
  echo "Only installing terminal tools..."
  source ~/.local/share/omakub/install/terminal.sh
fi
