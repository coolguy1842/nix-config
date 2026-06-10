{ lib, pkgs, ... }: {
    system.stateVersion = "26.05";

    boot = {
        kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

        loader = {
            systemd-boot = {
                enable = lib.mkDefault true;
                memtest86.enable = true;
            };

            efi.canTouchEfiVariables = true;
        };
    };

    hardware.enableRedistributableFirmware = lib.mkDefault true;

    nix = {
        extraOptions = "experimental-features = nix-command flakes";
        settings.auto-optimise-store = true;

        gc = {
            automatic = true;
            dates = "daily";
            options = "--delete-older-than 2d";
        };
    };

    services = {
        nohang.enable = true;
    };
}
