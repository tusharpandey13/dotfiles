#!/bin/sh

cd ~

yadm add .astylerc .bash_profile .bashrc .exports.sh .festival_history .festivalrc .gitconfig .gtkrc-2.0 .imwheelrc .mysql_history .npmrc .p10k.zsh .profile .psql_history .pycodestyle .python_history .vimrc .xinitrc .Xresources .xscreensaver .yarnrc .zprofile .zsh_aliases.sh .zsh_preload.sh .zshrc blur.sh cleanpacman.sh edits gitrmcached.sh rc.xml screenoff.sh setauto.sh start.sh startgala.sh startpolybar.sh startvnc.sh test.py toggle_screenkey.sh toggleinternalkeyboard.sh update_cmus.sh xfce4-panel.xml xfwm_gala_replace.sh .emerald .gimp-2.8 .icons .kde4 .themes backup_dotfiles.sh

cd .config

yadm add autokey autostart-scripts bleachbit blender bspwm catfish cmus compiz conky dconf deadbeef GIMP gpicview gtk-2.0 gtk-3.0 gtk-4.0 htop KDE kde.org kdeconnect kitty Kvantum latte lxpanel lxterminal Mousepad mpv MusicBrainz neofetch openbox pcmanfm picom plank polybar qBittorrent qpdfview rofi Thunar tilda vlc waybar xarchiver xfce4 xsettingsd arkrc baloofileinformationrc baloofilerc breezerc chromium-flags.conf classikstylesrc dolphinrc elisarc filelightrc gwenviewrc katerc kateschemarc kcmfonts kcmshell5rc kcminputrc kconf_updaterc kdeconnect.apprc kdeconnect.notifyrc kded5rc kdeglobals kfontinstuirc kfontviewrc kglobalshortcutsrc khotkeysrc kiorc klipperrc konquerorrc konsolerc krenamerc kscreenlockerrc kservicemenurc ksmserverrc ksplashrc ksysguardrc ktimezonedrc kwalletmanager5rc kwalletrc kwinrc kwin_rules_dialogrc kwinrulesrc lattedockrc lightlyrc lightlyshaders.conf lxtask.conf mimeapps.list okular-generator-popplerrc okularpartrc okularrc Picardrc plasma_workspace.notifyrc plasma-localerc plasma-nm plasma-org.kde.plasma.desktop-appletsrc plasma.emojierrc plasmanotifyrc plasmarc plasmashellrc powerdevilrc powermanagementprofilesrc pycodestyle qBittorrentrc qmmprc QtCreatorrc QtProject.conf screenkey.json sddmthemeinstallerrc spectacle.notifyrc spectaclerc systemmonitorrc systemsettingsrc TelegramDesktoprc touchpadrc touchpadxlibinputrc trashrc vlcrc yakuakerc user-dirs.dirs user-dirs.locale

cd ..
cd .local/share

yadm add color-schemes cinnamon desktop-directories dolphin kwin latte latte-layouts okular plank plasma plasmashell qpdfview Qt wallpapers xfce4 applications

cd ..
cd ..

yadm add .config/yadm/encrypt
yadm add .local/share/yadm/archive

yadm commit -m "tushar $(date +"%T")"

yadm remote add origin git@github.com:tusharpandey13/dotfiles.git >/dev/null 2>&1

yadm push -u origin master