{ inputs, pkgs, ... }: {
    imports = [
        ./system.nix
        ./nvidia.nix
        ./user.nix
        ./packages.nix
        ./syncthing.nix
        ./sunshine.nix
        ./games.nix
        ./vm.nix
        ./wheel.nix
    ];

    programs = {
        uwsm.enable = true;
        hyprland = {
            enable = true;
            xwayland.enable = true;
        };
    };

    hardware.opentabletdriver = {
        enable = true;
        daemon.enable = true;
    };
    
    systemd.services.waveeffect = {
        enable = true;
        serviceConfig = {
            ExecStart = "${inputs.waveeffect.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/waveeffect";
        };

        wantedBy = [ "default.target" ];
    };

    services.flatpak.enable = true;
}
