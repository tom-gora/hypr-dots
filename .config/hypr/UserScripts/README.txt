NOTE:

in `/usr/share/sddm/themes/simple-sddm` 
(this path remains hardcoded, so just put any sddm theme in such folder
then mod .conf file so it grabs the backgound from its root dir/background.jpg and
there is a link to wallpapers)
a link to `/home/tomeczku/.config/hypr-wallpapers`
must be placed to allow systemd to sync and randomize sddm background on startup

/home/tomeczku/.config/hypr/UserScripts/SetStartupWallpaper.sh must be called in 
/etc/sddm/wayland-session right after shell evaluation block
