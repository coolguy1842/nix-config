# credit: https://gitlab.com/nicky.tope/nixos-config/-/blob/main/user/desktop/hyprland/default.nix

{ config, pkgs, configName, ... }: let
    wallpapers = ./wallpapers;
in {
    wayland.windowManager.hyprland.enable = false;
    services.awww.enable = true;

    services.hypridle = {
        enable = true;
        
        settings = {
            general = {
                inhibit_sleep = 3;

                lock_cmd = "";
                before_sleep_cmd = "";
                after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
            };

            listener = [
                {
                    on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
                    on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
                    timeout = 900;
                }
            ];
        };
    };

    xdg.dataFile."hypr/stubs".source = "${pkgs.hyprland}/share/hypr/stubs";    
    xdg.configFile."hypr/hyprland.lua".source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/nix-config/users/${configName}/home/hyprland/hyprland.lua";
    
    home = {
        pointerCursor.hyprcursor.enable = true;
        packages = with pkgs; [
            wl-clipboard
            hyprland-protocols
            hyprpicker
            hyprshade
            playerctl
            wayfreeze
            libnotify
            grim
            slurp

            (writeShellScriptBin "cycle-wallpaper" ''
                export AWWW_TRANSITION_FPS=60
                export AWWW_TRANSITION_STEP=90
                export AWWW_TRANSITION=wipe
                export AWWW_TRANSITION_ANGLE=45

                current_wallpaper="$(basename "$(awww query | grep -Eio "image: .*" | grep -Eio "/.*\..*" -A 0 | head -1)")"
                ls "${wallpapers}" | grep -v ".*\.md" | sort -R | tail -n 3 | while read file; do
                    new_wallpaper="${wallpapers}/$file"
                    if [[ $current_wallpaper == $file ]]; then
                        continue
                    fi

                    awww img "${wallpapers}/$file"
                    break
                done
            '')
        ];
    };
}
