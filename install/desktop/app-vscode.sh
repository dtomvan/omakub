export NIXPKGS_ALLOW_UNFREE=1
nix profile install nixpkgs#vscode --impure

mkdir -p ~/.config/Code/User
cp ~/.local/share/omakub/configs/vscode.json ~/.config/Code/User/settings.json

# Install default supported themes
code --install-extension enkia.tokyo-night
