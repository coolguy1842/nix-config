{ lib, pkgs, ... }: {
    fonts.packages = with pkgs; [
        source-code-pro
        font-awesome
        powerline-fonts
        powerline-symbols
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
    ];

    environment = {
        systemPackages = with pkgs; [
            glib
            gsettings-desktop-schemas

            gtk3
            gtk4

            nautilus

            kdePackages.qtsvg
            kdePackages.kio
            kdePackages.kio-fuse
            kdePackages.kio-extras
            kdePackages.ark
            kdePackages.dolphin
        ];

        variables = with pkgs; {
            GSETTINGS_SCHEMA_DIR = "${gtk3}/share/gsettings-schemas/${gtk3.name}/glib-2.0/schemas:${gtk4}/share/gsettings-schemas/${gtk4.name}/glib-2.0/schemas:${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}/glib-2.0/schemas";
        }; 
    };

    programs = {
        nautilus-open-any-terminal = {
            enable = true;
            terminal = "kitty";
        };

        uwsm.enable = true;
    };

    services = {
        # for nautilus sftp
        gvfs.enable = true;
        # nautilus image preview expanding 
        gnome.sushi.enable = true;

        displayManager.sddm = {
            enable = lib.mkDefault true;
            wayland.enable = true;
        };
    };
}
