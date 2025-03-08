echo "Downloading the VirtIO drivers to ~/Downloads"
mkdir -p ~/Downloads/
# The virtio-win package extracts the ISO, so let's just "build" (ie. retrieve)
# the source ISO from fedora through nixpkgs (which helps us use a up-to-date version)
nix build --out-link ~/Downloads/virtio-win.iso nixpkgs#virtio-win.src

echo "Download the Windows 11 ISO..."
open https://www.microsoft.com/software-download/windows11
gum confirm "Have you finished downloading?"

echo "Follow instructions in..."
open https://sysguides.com/install-a-windows-11-virtual-machine-on-kvm
