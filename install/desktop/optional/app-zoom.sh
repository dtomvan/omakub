# Make video calls using https://zoom.us/
export NIXPKGS_ALLOW_UNFREE=1
nix profile install nixpkgs#zoom-us --impure
