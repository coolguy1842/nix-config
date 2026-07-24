# credit: https://gitlab.com/nicky.tope/nixos-config/-/blob/main/user/desktop/hyprland/default.nix

{ config, pkgs, configName, ... }: {
    wayland.windowManager.hyprland.enable = false;

    xdg.dataFile."hypr/stubs".source = "${pkgs.hyprland}/share/hypr/stubs";    
    xdg.configFile."hypr/hyprland.lua".source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/nix-config/users/${configName}/home/hyprland/hyprland.lua";

    services.hypridle = {
        enable = true;
        
        settings = {
            general = {
                inhibit_sleep = 0;

                lock_cmd = "";
                before_sleep_cmd = "";
                after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
            };

            listener = [
                {
                    timeout = 900;
                    on-timeout = "systemctl suspend";
                }
            ];
        };
    };

    home = {
        pointerCursor.hyprcursor.enable = true;
        packages = with pkgs; [
            wl-clipboard
            hyprland-protocols
            playerctl
            libnotify
        ];
    };
}
