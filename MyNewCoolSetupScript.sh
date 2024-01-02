# Version 0.1.0
sudo apt update
sudo apt upgrade

# Simple Installations
mkdir ~/Applications/
sudo apt -y install curl
sudo apt -y install git
sudo apt -y install golang-go
sudo apt -y install make cmake
sudo apt -y install i3
sudo apt -y install polybar
sudo apt -y install flatpak gnome-software-plugin-flatpak
sudo apt -y install meld
sudo apt -y install xss-lock
sudo apt -y install i3lock
sudo apt -y install policykit-1-gnome
sudo apt -y install python3-setuptools
sudo apt -y install gettext
sudo apt -y install gparted
sudo apt -y install libfuse2
sudo apt -y install gimp
sudo apt -y install jackd qjackctl
sudo apt -y install wine
sudo apt -y install pamixer playerctlv
sudo apt -y install dconf-editor
sudo apt -y install putty
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak --noninteractive install org.audacityteam.Audacity
flatpak --noninteractive install flathub md.obsidian.Obsidian
flatpak --noninteractive install flathub cc.arduino.IDE2
flatpak --noninteractive install flathub com.ticktick.TickTick
flatpak --noninteractive install flathub org.prismlauncher.PrismLauncher
flatpak --noninteractive install flathub io.mgba.mGBA
flatpak --noninteractive install flathub org.kde.krita
flatpak --noninteractive install flathub org.gnome.GHex

# System Configs
echo -e "Section \"InputClass\"\n        Identifier \"libinput touchpad catchall\"\n        MatchIsTouchpad \"\n        MatchDevicePath \"/dev/input/event*\"\n        Driver \"libinput\"\n        Option \"NaturalScrolling\" \"True\"\n        Option \"Tapping\" \"on\"\nEndSection" | sudo tee -a /usr/share/X11/xorg.conf.d/50-libinput.conf > /dev/null
echo -e "export GDK_SCALE=2\nxrandr --dpi 180\n" >> ~/.profile

# Install Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt -y install sublime-text

# Install Kitty
cd ~/Applications
git clone https://github.com/kovidgoyal/kitty.git
cd kitty
sudo apt -y install libdbus-1-dev libxcursor-dev libxrandr-dev libxi-dev libxinerama-dev libgl1-mesa-dev libxkbcommon-x11-dev libfontconfig-dev libx11-xcb-dev liblcms2-dev libssl-dev libpython3-dev libxxhash-dev
./dev.sh build
mkdir ~/bin/
ln -s ~/Applications/kitty/kitty/launcher/kitty ~/bin/kitty

echo -e "[Desktop Entry]\nName=Kitty\nExec=/home/flicker/Applications/kitty/kitty/launcher/kitty\nGenericName=Terminal Emulator\nType=Application\nTerminal=false\nIcon=/home/flicker/Applications/kitty/kitty/launcher/kitty.ico\n" >> ~/.local/share/applications/kitty.desktop

# Install Github Desktop & VS Code
mkdir ~/Applications/"Debian Files"
cd ~/Applications/"Debian Files"
sudo wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
sudo apt install ./GitHubDesktop-linux-3.1.1-linux1.deb
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/0ee08df0cf4527e40edc9aa28f4b5bd38bbff2b2/code_1.85.1-1702462158_amd64.deb
sudo apt install ./code_1.85.1-1702462158_amd64.deb

# Install Font Awesome
cd ~/Applications
wget https://use.fontawesome.com/releases/v6.5.1/fontawesome-free-6.5.1-desktop.zip
unzip fontawesome-free-6.5.1-desktop.zip
rm fontawesome-free-6.5.1-desktop.zip
sudo mkdir /usr/share/fonts/opentype/FA/
sudo cp 'fontawesome-free-6.5.1-desktop/otfs/Font Awesome 6 Free-Solid-900.otf' /usr/share/fonts/opentype/FA/

# Install custom dmenu
cd ~/Applications
git clone https://github.com/code32123/dmenu.git
cd dmenu
sudo apt install libxft-dev
sudo make clean install

# Install custom j4-dmenu-desktop
cd ~/Applications
git clone https://github.com/code32123/j4-dmenu-desktop.git
cd j4-dmenu-desktop
cmake .
make
sudo make install

# Install Syncthing
sudo apt install syncthing
sudo systemctl enable syncthing@flicker
sudo systemctl start syncthing@flicker

# Install Bespokesynth
echo 'deb http://download.opensuse.org/repositories/home:/bespokesynth/xUbuntu_23.10/ /' | sudo tee /etc/apt/sources.list.d/home:bespokesynth.list
curl -fsSL https://download.opensuse.org/repositories/home:bespokesynth/xUbuntu_23.10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_bespokesynth.gpg > /dev/null
sudo apt update
sudo apt install bespokesynth

# Install Steam
sudo add-apt-repository -y multiverse
sudo dpkg --add-architecture i386
sudo apt update
sudo apt -y install steam

# Install Input-Remapper
cd ~/Applications
git clone https://github.com/sezanzeb/input-remapper.git
cd input-remapper
./scripts/build.sh
sudo apt -y install -f ./dist/input-remapper-2.0.1.deb

# Install Spotify and Spicetify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
rm install.log
cd ~/Applications
git clone --depth=1 https://github.com/spicetify/spicetify-themes.git
cd spicetify-themes
mkdir -p ~/.config/spicetify/Themes/Sleek/
cp -r ./Sleek/* ~/.config/spicetify/Themes/Sleek/
sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R
mkdir ~/.config/spotify/
touch ~/.config/spotify/prefs
/home/flicker/.spicetify/spicetify config current_theme Sleek
/home/flicker/.spicetify/spicetify config color_scheme coral
/home/flicker/.spicetify/spicetify backup apply

# Install Balena Etcher
mkdir ~/Applications/BalenaEtcher
cd ~/Applications/BalenaEtcher
wget https://github.com/balena-io/etcher/releases/download/v1.18.11/balenaEtcher-1.18.11-x64.AppImage
chmod +x /home/flicker/Applications/BalenaEtcher/balenaEtcher-1.18.11-x64.AppImage
echo -e "[Desktop Entry]\nName=Balena Etcher\nGenericName=ISO Writer\nExec=/home/flicker/Applications/BalenaEtcher/balenaEtcher-*-x64.AppImage\nType=Application\nTerminal=false\n" >> ~/.local/share/applications/balena.desktop

# Install Ultimaker Cura
mkdir ~/Applications/Cura
cd ~/Applications/Cura
wget https://github.com/Ultimaker/Cura/releases/download/5.6.0/UltiMaker-Cura-5.6.0-linux-X64.AppImage
chmod +x /home/flicker/Applications/Cura/UltiMaker-Cura-5.6.0-linux-X64.AppImage
echo -e "[Desktop Entry]\nName=Ultimaker Cura\nGenericName=ISO Writer\nExec=/home/flicker/Applications/Cura/UltiMaker-Cura-5.6.0-linux-X64.AppImage\nType=Application\nTerminal=false\n" >> ~/.local/share/applications/cura.desktop

# Install osu!
mkdir ~/Applications/osu
cd ~/Applications/osu
wget https://github.com/ppy/osu/releases/latest/download/osu.AppImage
chmod +x osu.AppImage
echo -e "[Desktop Entry]\nName=osu\nExec=/home/flicker/Applications/osu/osu.AppImage\nType=Application\nTerminal=false\nCategories=Game" >> ~/.local/share/applications/osu.desktop

# Firefox Modifications
cd ~/Applications
wget https://download-installer.cdn.mozilla.net/pub/devedition/releases/122.0b3/linux-x86_64/en-US/firefox-122.0b3.tar.bz2
tar -xf firefox-122.0b3.tar.bz2
rm firefox-122.0b3.tar.bz2
mv firefox firefoxdev
echo -e "[Desktop Entry]\nName=Firefox Dev\nExec=/home/flicker/Applications/firefoxdev/firefox\nGenericName=Web Browser\nType=Application\nTerminal=false\nCategories=Web;Firefox;ff;ffd;" >> ~/.local/share/applications/FirefoxDev.desktop
echo -e "[Desktop Entry]\nName=Firefox Web\nExec=firefox %u\nTerminal=false\nX-MultipleArgs=false\nType=Application\nIcon=firefox\nCategories=Web;Firefox;ff;ffw;\nMimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;\nStartupNotify=true" >> ~/.local/share/applications/FirefoxWeb.desktop
sudo rm /usr/share/applications/firefox.desktop

# Install REX Paint
cd ~/Applications
wget 'https://www.gridsagegames.com/blogs/fileDownload.php?fileName=REXPaint-v1.60.zip' -O REXPaint-v1.60.zip
unzip "REXPaint-v1.60.zip"
rm "REXPaint-v1.60.zip"
echo -e "[Desktop Entry]\nName=REXPaint\nGenericName=Ascii Art Editor\nExec=bash -c 'cd /home/flicker/Applications/REXPaint-v1.60/ && wine REXPaint.exe'\nType=Application\nTerminal=false" >> ~/.local/share/applications/REXPaint.desktop

# Install Aqua Key Test
mkdir ~/Applications/aquakeytest
cd ~/Applications/aquakeytest
wget 'https://geekhack.org/index.php?action=dlattach;topic=34670.0;attach=2245' -O aquakeytest.exe
echo -e "[Desktop Entry]\nName=AquaKeyTest\nExec=wine /home/flicker/Applications/aquakeytest/aquakeytest.exe\nType=Application\nTerminal=false\nCategories=Keyboard" >> ~/.local/share/applications/AquaKeyTest.desktop

# Install Write
cd ~/Applications
wget http://www.styluslabs.com/download/write-tgz -O write.tar.gz
tar -xf write.tar.gz
rm write.tar.gz
cd Write
./setup.sh

# Install OBS
sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt -y install obs-studio

# Install kdenlive
sudo add-apt-repository -y ppa:kdenlive/kdenlive-stable
sudo apt -y install kdenlive

# Install Inkscape
sudo add-apt-repository -y ppa:inkscape.dev/stable
sudo apt -y install inkscape

# Install Strawberry
sudo add-apt-repository -y ppa:jonaski/strawberry
sudo apt -y install strawberry

##### DEBIAN PACKAGES
cd ~/Applications/"Debian Files"

# Vital Synth
# wget "https://account.vital.audio/VitalInstaller.deb?idToken=" -O VitalInstaller.deb
# sudo apt -y install ./VitalInstaller.deb

# Install Discord
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt -y install ./discord.deb

# Install Insomnia
wget "https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app&source=website" -O Insomnia.deb
sudo apt -y install ./Insomnia.deb

# Install AIMP
wget "https://www.aimp.ru/?do=download.file&id=26" -O aimp.deb
sudo apt -y install ./aimp.deb

# Install Zoom
wget "https://zoom.us/client/5.17.1.1840/zoom_amd64.deb"
sudo apt -y install ./zoom_amd64.deb

# Install FAF
cd ~/Applications
curl -L -O https://github.com/FAForever/downlords-faf-client/releases/download/v2023.12.1/faf_unix_2023_12_1.tar.gz
mkdir -p ~/faf
tar -xf faf_unix_2023_12_1.tar.gz -C ~/faf/
echo -e "[Desktop Entry]\nName=FAF Client\nCategories=Games;Steam;\nTerminal=false\nExec=bash -c \"cd ~/faf/faf-client-2023.12.1; INSTALL4J_JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64 ./faf-client\"\nType=Application" >> ~/.local/share/applications/faf.desktop

# Install ardour
cd ~/Applications
git clone https://github.com/Ardour/ardour.git
cd ardour
sudo apt -y install python3-pip python-is-python3 libboost-dev libalsa-ocaml-dev libglibmm-2.4-dev libsndfile1-dev libcurl-ocaml-dev libarchive-dev liblo-dev libtaglib-ocaml-dev vamp-plugin-sdk librubberband-dev clang libaubio-dev libcppunit-dev libwebsockets-dev libclang-dev libudev-dev libpulse-dev libusb-1.0-0-dev libpangomm-1.4-dev liblrdf0-dev lv2-dev libserd-dev libsord-dev libsratom-dev liblilv-dev libsuil-dev libgtkmm-2.4-dev
./waf configure
./waf
./waf clean
echo -e "[Desktop Entry]\nName=Ardour\nExec=/usr/local/bin/ardour8\nCategories=DAW;Audio;Music;Midi\nTerminal=false\nType=Application" >> ~/.local/share/applications/ardour.desktop

# Replace open in gnome terminal with open in kitty
sudo apt remove nautilus-extension-gnome-terminal
cd ~/Applications
git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
cd nautilus-open-any-terminal
./tools/update-extension-user.sh install
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty
nautilus -q

# Install configs
cd ~/
git clone https://github.com/code32123/PortableConfigs.git
mkdir ~/.config/kitty/
ln -s ~/PortableConfigs/kitty.conf ~/.config/kitty/kitty.conf

mkdir  ~/.config/polybar/
ln -s ~/PortableConfigs/config.ini ~/.config/polybar/config.ini
ln -s ~/PortableConfigs/launch.sh ~/.config/polybar/launch.sh
ln -s ~/PortableConfigs/player-mpris-tail.py ~/.config/polybar/player-mpris-tail.py
ln -s ~/PortableConfigs/battery-combined-udev.sh ~/.config/polybar/battery-combined-udev.sh
ln -s ~/PortableConfigs/volume.py ~/.config/polybar/volume.py
sudo cp ~/PortableConfigs/95-battery.rules /etc/udev/rules.d/95-battery.rules

mkdir -p ~/.config/sublime-text/Packages/User/
ln -s ~/PortableConfigs/Default.sublime-mousemap ~/.config/sublime-text/Packages/User/Default.sublime-mousemap
ln -s ~/"PortableConfigs/Default (Linux).sublime-keymap" ~/.config/sublime-text/Packages/User/
ln -s ~/PortableConfigs/Preferences.sublime-settings ~/.config/sublime-text/Packages/User/Preferences.sublime-settings
ln -s ~/PortableConfigs/SublimeLinter.sublime-settings ~/.config/sublime-text/Packages/User/SublimeLinter.sublime-settings

mkdir ~/.config/i3/
ln -s ~/PortableConfigs/config ~/.config/i3/
ln -s ~/PortableConfigs/micVolumeUp.sh ~/.config/i3/

ln -s ~/PortableConfigs/"Where Is.txt" ~/

mkdir -p "/home/flicker/.config/input-remapper-2/presets/Logitech Gaming Mouse G600/"
ln -s ~/PortableConfigs/MousePreset.json "~/.config/input-remapper-2/presets/Logitech Gaming Mouse G600/new preset.json"

ln -s ~/PortableConfigs/Xmodmap ~/.Xmodmap

# TODO: mouse stuff, python-umonitor, quassel

# alias sa="apt list | grep -i "
# alias aa="sudo apt -y install "

sudo apt autoremove
