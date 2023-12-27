sudo apt update
sudo apt upgrade

# Simple Installations
mkdir ~/Applications/
sudo apt -y install i3 git golang-go polybar make cmake flatpak gnome-software-plugin-flatpak meld curl xss-lock i3lock policykit-1-gnome python3-setuptools gettext gparted libfuse2 gimp jackd qjackctl
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak --noninteractive install flathub md.obsidian.Obsidian
flatpak --noninteractive install flathub cc.arduino.IDE2
flatpak --noninteractive install org.audacityteam.Audacity
flatpak --noninteractive install flathub com.ticktick.TickTick

# System Configs
echo -e "Section \"InputClass\"\n        Identifier \"libinput touchpad catchall\"\n        MatchIsTouchpad \"\n        MatchDevicePath \"/dev/input/event*\"\n        Driver \"libinput\"\n        Option \"NaturalScrolling\" \"True\"\n        Option \"Tapping\" \"on\"\nEndSection" | sudo tee -a /usr/share/X11/xorg.conf.d/50-libinput.conf > /dev/null
echo -e "export GDK_SCALE=2\nxrandr --dpi 180\n" >> ~/.profile

# Install Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# Install Kitty
cd ~/Applications
git clone https://github.com/kovidgoyal/kitty.git
cd kitty
sudo apt install libdbus-1-dev libxcursor-dev libxrandr-dev libxi-dev libxinerama-dev libgl1-mesa-dev libxkbcommon-x11-dev libfontconfig-dev libx11-xcb-dev liblcms2-dev libssl-dev libpython3-dev libxxhash-dev
./dev.sh build
ln -s ~/Applications/kitty/kitty/launcher/kitty ~/bin/kitty

echo -e "[Desktop Entry]\nName=Kitty\nExec=/home/flicker/Applications/kitty/kitty/launcher/kitty\nGenericName=Terminal Emulator\nType=Application\nTerminal=false\nIcon=/home/flicker/Applications/kitty/kitty/launcher/kitty.ico\n" >> ~/.local/share/applications/kitty.desktop

# Install Github Desktop & VS Code
mkdir ~/Applications/"Debian Files"
cd ~/Applications/"Debian Files"
sudo wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
sudo apt install ./GitHubDesktop-linux-3.1.1-linux1.deb
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/0ee08df0cf4527e40edc9aa28f4b5bd38bbff2b2/code_1.85.1-1702462158_amd64.deb
sudo apt install ./code_1.85.1-1702462158_amd64.deb


# Install custom dmenu
cd ~/Applications
git clone https://github.com/code32123/dmenu.git
cd dmenu
sudo apt install libxft-dev
sudo make clean install

# Install custom j4-dmenu-desktop
cd ~/Applications
git pull https://github.com/code32123/j4-dmenu-desktop.git
git clone https://github.com/code32123/j4-dmenu-desktop.git
cd j4-dmenu-desktop
cmake .
make
sudo make install

# Install & Config Syncthing
sudo apt install syncthing
sudo systemctl enable syncthing@flicker
sudo systemctl start syncthing@flicker

# Install Bespokesynth
echo 'deb http://download.opensuse.org/repositories/home:/bespokesynth/xUbuntu_23.10/ /' | sudo tee /etc/apt/sources.list.d/home:bespokesynth.list
curl -fsSL https://download.opensuse.org/repositories/home:bespokesynth/xUbuntu_23.10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_bespokesynth.gpg > /dev/null
sudo apt update
sudo apt install bespokesynth

# Install Steam
sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install steam

# Install Input-Remapper
cd ~/Applications
git clone https://github.com/sezanzeb/input-remapper.git
cd input-remapper
./scripts/build.sh
sudo apt install -f ./dist/input-remapper-2.0.1.deb

# Install Spotify and Spicetify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
rm install.log

cd ~/Applications
git clone --depth=1 https://github.com/spicetify/spicetify-themes.git
cd spicetify-themes
mkdir -p ~/.config/spicetify/Themes/Sleek/
cp -r ./Sleek/* ~/.config/spicetify/Themes/Sleek/
sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R
/home/flicker/.spicetify/spicetify config current_theme Sleek
/home/flicker/.spicetify/spicetify config color_scheme coral
/home/flicker/.spicetify/spicetify backup apply

# Install Balena Etcher
cd ~/Applications
mkdir BalenaEtcher
cd BalenaEtcher
wget https://github.com/balena-io/etcher/releases/download/v1.18.11/balenaEtcher-1.18.11-x64.AppImage
echo -e "[Desktop Entry]\nName=Balena Etcher\nGenericName=ISO Writer\nExec=/home/flicker/Applications/BalenaEtcher/balenaEtcher-*-x64.AppImage\nType=Application\nTerminal=false\n" >> ~/.local/share/applications/balena.desktop
chmod +x /home/flicker/Applications/BalenaEtcher/balenaEtcher-*-x64.AppImage

# Install configs
cd ~/
git clone https://github.com/code32123/PortableConfigs.git

mkdir ~/.config/kitty/
ln -s ~/PortableConfigs/kitty.conf ~/.config/kitty/kitty.conf

mkdir  ~/.config/polybar/
ln -s ~/PortableConfigs/config.ini ~/.config/polybar/config.ini
ln -s ~/PortableConfigs/launch.sh ~/.config/polybar/launch.sh
cp ~/PortableConfigs/player-mpris-tail.py ~/.config/polybar/player-mpris-tail.py
cp ~/PortableConfigs/battery-combined-udev.sh ~/.config/polybar/battery-combined-udev.sh
sudo cp ~/PortableConfigs/95-battery.rules /etc/udev/rules.d/95-battery.rules

ln -s ~/PortableConfigs/Default.sublime-mousemap ~/.config/sublime-text/Packages/User/Default.sublime-mousemap
ln -s ~/"PortableConfigs/Default (Linux).sublime-keymap" ~/.config/sublime-text/Packages/User/
ln -s ~/PortableConfigs/Preferences.sublime-settings ~/.config/sublime-text/Packages/User/Preferences.sublime-settings
ln -s ~/PortableConfigs/SublimeLinter.sublime-settings ~/.config/sublime-text/Packages/User/SublimeLinter.sublime-settings

ln -s ~/PortableConfigs/config ~/.config/i3/


# TODO: mouse stuff, ticktick, ardour, ffw & ffd

# wget https://download-installer.cdn.mozilla.net/pub/devedition/releases/122.0b3/linux-x86_64/en-US/firefox-122.0b3.tar.bz2

