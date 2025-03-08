nix profile install nixpkgs#nerd-fonts.caskaydia-mono nixpkgs#nerd-fonts.im-writing

export XDG_DATA_DIRS="$HOME/.nix-profile/share/:$XDG_DATA_DIRS"
fc-cache -frv
