{ lib, inputs, pkgs, username, ... }: {
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
        hyprland = {
            enable = true;
            xwayland.enable = true;
        };

        CaptureCardRelay = {
            enable = true;

            settings = {
                camera = "Live Gamer MINI";
                recordingDevice = "Live Gamer MINI Analog Stereo";
                displayMode = "contain";
                frameLimiting = "camera";
                fullscreen = true;
            };
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

    services = {
        flatpak.enable = true;
        zerotierone.enable = true;

        immich = {
            enable = true;
            openFirewall = true;

            host = "0.0.0.0";
        };
    };
}
