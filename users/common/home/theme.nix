{ inputs, config, pkgs, username, ... }: {
    home.packages = with pkgs; [
        glib
        gsettings-desktop-schemas

        kdePackages.qtstyleplugin-kvantum

        libsForQt5.qt5ct
        libsForQt5.qtstyleplugin-kvantum
        
        kdePackages.qt6ct

        adwaita-qt
        adwaita-icon-theme
        gnome-themes-extra

        # nautilus

        # kdePackages.qtsvg
        # kdePackages.kio
        # kdePackages.kio-fuse
        # kdePackages.kio-extras
        # kdePackages.ark
        # kdePackages.dolphin
    ];

    home.pointerCursor = {
        gtk.enable = true;

        package = pkgs.vanilla-dmz;
        name = "Vanilla-DMZ";
        size = 24;
    };

    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            gtk-theme = "Adwaita-dark";
        };
    };

    gtk = {
        enable = true;
        colorScheme = "dark";

        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
        };

        gtk2 = {
            enable = true;
            theme = {
                name = "Adwaita-dark";
                package = pkgs.gnome-themes-extra;
            };
        };

        gtk3 = {
            enable = true;
            
            colorScheme = "dark";
            theme = {
                name = "Adwaita-dark";
                package = pkgs.gnome-themes-extra;
            };
        };

        gtk4 = {
            enable = true;
            
            colorScheme = "dark";
            theme = {
                name = "Adwaita-dark";
                package = pkgs.gnome-themes-extra;
            };
        };
    };

    home.sessionVariables.QT_QPA_PLATFORMTHEME = "qt5ct";
    home.sessionVariables.GTK_THEME = "Adwaita-dark";
}
