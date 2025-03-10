# Migrate to nix and more flatpaks

not() {
    if [[ $1 -eq 0 ]]; then
        return 1
    else
        return 0
    fi
}

optapps=(
    1password
    obs-studio
    steam
    brave
    cursor
    spotify
    zed
    zoom
)

declare -A installed_optapps

for app in ${!installed_optapps[@]}; do
    command -v $app
    not $?
    installed_optapps["$app"]=$?
done

# Remove all old apps
oldapps=(
    1password
    1password-cli
    brave-browser
    code
    fastfetch
    fuse3
    gh
    google-chrome-stable
    gum
    libfuse2t64
    localsend
    obs-studio
    php8.4
    signal-desktop
    steam
    steam-launcher
    ulauncher
    vlc
    xournalpp
    zoom
)

for app in ${oldapps[@]}; do
    sudo apt remove -y "$app"
done

sudo apt remove -y php8.4-{curl,apcu,intl,mbstring,opcache,pgsql,mysql,sqlite3,redis,xml,zip}

# Remove all old keys
sudo rm -f /etc/apt/keyrings/{mise-archive-keyring,packages.microsoft}.gpg
sudo rm -f /etc/apt/trusted.gpg.d/{spotify.gpg,typora.asc}
sudo rm -f /usr/share/keyrings/{1password,brave-browser,githubcli,signal-desktop}-archive-keyring.gpg

# Remove all old repos
sudo rm -f /etc/apt/sources.list.d/{1password,brave-browser-release,github-cli,mise,signal-xenial,spotify,vscode}.list

# Remove all old PPAs
oldppas=(
    ppa:agornostal/ulauncher       
    ppa:zhangsongcui3371/fastfetch 
    ppa:ondrej/php                 
)

for ppa in ${oldppas[@]}; do
    sudo add-apt-repository -r -y "$ppa"
done

# Various other files that need deleting
sudo rm -rf /{etc/debsig/policies,usr/share/debsig/keyrings}/AC2D62742012EA22
sudo rm -rf /opt/cursor.appimage
sudo rm -rf /usr/share/applications/cursor.desktop

sudo rm -rf /usr/local/bin/{lazydocker,lazygit,zellij,composer}

# Special zed treatment
rm -f $HOME/.local/share/applications/dev.zed.Zed.desktop
rm -rf $HOME/.local{,/bin}/zed

# Special neovim treatment
sudo rm -rf /usr/local/{bin,share,lib}/nvim

# If nix not installed, do that
source $OMAKUB_PATH/install/terminal/required/app-nix.sh >/dev/null
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# New non-optional desktop apps
new_desktopapps=(
    app-signal
    app-chrome
    app-localsend
    app-typora
    app-vlc
    app-vscode
    app-xournalpp
    fonts
    ulauncher
)

for app in ${new_desktopapps[@]}; do
    source $OMAKUB_PATH/install/desktop/$app.sh
done

# New non-optional terminal apps

new_terminalapps=(
    app-fastfetch
    app-github-cli
    app-lazydocker
    app-lazygit
    app-neovim
    app-zellij
    mise
    required/app-gum
    select-dev-language
)

for app in ${new_terminalapps[@]}; do
    source $OMAKUB_PATH/install/terminal/$app.sh
done

# New optionals
for app in ${!installed_optapps}; do
    if [[ ${installed_optapps[${app}]} -eq 1 ]]; then
        source $OMAKUB_PATH/install/desktop/optional/app-$app.sh
    fi
done

# Disable apparmor for nix (profiles include /usr/bin)
source $OMAKUB_PATH/install/disable-apparmor.sh

# Cleanup
sudo apt autoremove
nh clean all -k 3 --nogcroots
