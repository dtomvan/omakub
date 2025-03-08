# Nix is used for installing software more reliably than a PPA
cd /tmp
NIX_INSTALLER_VERSION="3.0.0"
curl -fsSLo nix-installer "https://github.com/DeterminateSystems/nix-installer/releases/download/v${NIX_INSTALLER_VERSION}/nix-installer-x86_64-linux"
chmod +x ./nix-installer
./nix-installer install linux --no-confirm --init systemd --explain
rm ./nix-installer
cd -

nix profile install nixpkgs#nh
