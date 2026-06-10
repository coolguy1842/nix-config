{ pkgs, ... }: {
    imports = [
        ./extra/plugdev.nix

        ./system.nix
        ./network.nix
        ./bluetooth.nix
        ./audio.nix
        ./video.nix
        ./users.nix
        ./security.nix
        ./desktop.nix
        ./config.nix
    ];

    # useful packages
    environment.systemPackages = with pkgs; [
        jq
        git
        nixd
        wget
        htop
        lsof
        lshw
        p7zip
        psmisc
        pciutils
        usbutils
        brotli
        unzip
        
        appimage-run
    ];
}
