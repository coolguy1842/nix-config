{ ... }: {
    imports = [
        ./hyprland.nix
        ./ags.nix
        ./direnv.nix
        ./dunst.nix
        ./git.nix
        ./kitty.nix
        ./xdg.nix
        ./vr.nix
    ];

    services.awww.enable = true;

    programs.looking-glass-client = {
        enable = true;

        settings = {
            win = {
                fullscreen = "yes";
                title = "Win10";
            };

            input = {
                rawMouse = "yes";
                ignoreWindowsKeys = "yes";
                escapeKey = 74;
            };

            spice = {
                alwaysShowCursor = "yes";
                audio = "yes";
            };

            egl = {
                mapHDRtoSDR = "no";
            };
        };
    };
}
