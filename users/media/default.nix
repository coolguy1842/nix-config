{ lib, pkgs, username, ... }: {
    imports = [
        ./system.nix
        ./packages.nix
    ];

    services = {
        displayManager = {
            autoLogin.enable = true;
            autoLogin.user = "${username}";
        };
    };

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
}
