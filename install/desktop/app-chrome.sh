# Browse the web with the most popular browser. See https://www.google.com/chrome/
export NIXPKGS_ALLOW_UNFREE=1
nix profile install nixpkgs#google-chrome --impure
