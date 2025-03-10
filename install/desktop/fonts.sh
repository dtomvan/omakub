nix profile install nixpkgs#nerd-fonts.{caskaydia-mono,fira-mono,jetbrains-mono,meslo-lg,im-writing}

# This will be done by nix but let's frontload it for a better experience
export XDG_DATA_DIRS="$HOME/.nix-profile/share/:$XDG_DATA_DIRS"
fc-cache -frv
