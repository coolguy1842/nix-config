{ lib, pkgs, username, ... }: let
    GPUOffloadApp = import ./util/gpu-offload.nix { inherit lib pkgs; };
in {
    virtualisation = {
        libvirtd = {
            enable = true;
            qemu = {
                package = pkgs.qemu;
                swtpm.enable = true;
            };
        };

        docker.enable = true;
    };

    programs = {
        virt-manager.enable = true;
        ente-auth.enable = true;

        obs-studio = {
            enable = true;
            plugins = with pkgs; [
                obs-studio-plugins.obs-pipewire-audio-capture
            ];
        };
    };

    users.users."${username}".packages = with pkgs; [
        # system/essential
        networkmanagerapplet
        kitty

        # accounts/security
        electron-mail
        proton-pass

        # applications
        gnome-text-editor
        vscode.fhs
        element-desktop
        signal-desktop
        qbittorrent
        ferdium
        vesktop
        discord
        motrix

        # useful util
        baobab
        gnome-disk-utility
        waypaper
        
        # browsers
        firefox
        librewolf
        chromium

        # cli tools
        smartmontools
        fastfetch
        ddcutil
        
        # audio/media
        jellyfin-media-player
        pavucontrol
        qcomicbook
        koreader
        dopamine
        cheese
        loupe
        vlc

        # creative
        orca-slicer
        gimp
        krita
        (GPUOffloadApp (blender.override { cudaSupport=true; }) "blender")
        # broken for now
        # (GPUOffloadApp openscad "openscad")
    ];
}
