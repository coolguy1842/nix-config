{ lib, config, pkgs, ... }: let
    GPUOffloadApp = import ./util/gpu-offload.nix { inherit lib pkgs; };

    ld-libs = with pkgs; [
        # common requirement for several games
        stdenv.cc.cc.lib

        # from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/games/steam/fhsenv.nix#L72-L79
        libxcomposite
        libxtst
        libxrandr
        libxext
        libx11
        libxfixes
        libxcb
        libGL
        libva

        # from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/games/steam/fhsenv.nix#L124-L136
        fontconfig
        freetype
        libxt
        libxmu
        libxdamage
        libogg
        libvorbis
        SDL
        SDL2_image
        glew_1_10
        libdrm
        libidn
        tbb
        zlib
        fuse
        glib
        nss
        nspr
        atk
        dbus
        gdk-pixbuf
        gtk3
        pango
        cairo
        expat
        libxkbcommon
        libgbm
        alsa-lib
        cups
        icu

        libcap
        libxcb-cursor
        libxcursor
        libxi
        libxinerama
        libxscrnsaver
        libpng
        libpulseaudio
        libkrb5
        keyutils
        gamemode
        at-spi2-atk
        at-spi2-core
        libxshmfence

        libsForQt5.qtbase
        libsForQt5.qtmultimedia

        gcc
        glibc

        pulseaudio

        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
    ];
in {
    services.ananicy = with pkgs; {
        enable = true;
        package = ananicy-cpp;
        rulesProvider = ananicy-cpp;
        extraRules = [
            {
                "name" = "gamescope";
                "nice" = -20;
            }
        ];
    };

    hardware.steam-hardware.enable = true;
    programs = {
        nix-ld = {
            enable = true;

            libraries = ld-libs;
        };

        gamemode.enable = true;
        gamescope = {
            enable = true;

            args = [
                "-w 2560"
                "-h 1440"
                "-W 2560"
                "-H 1440"
                "-r 180"
                "-f"
            ];

            capSysNice = false;
        };

        steam = {
            enable = true;
            package = with pkgs; steam.override {
                extraPkgs = pkgs: ld-libs;
            };
        };


        alvr = {
            enable = true;
            openFirewall = true;
        };
    };

    environment.systemPackages = let
        mangohudWrapped = pkgs.mangohud.overrideAttrs (old: {
            nativeBuildInputs = old.nativeBuildInputs or [] ++ [ pkgs.makeWrapper ];

            postFixup = ''
                wrapProgram $out/bin/mangohud \
                    --set LD_LIBRARY_PATH "/run/opengl-driver/lib:${old.LD_LIBRARY_PATH or ""}" 
            '';
        }); 
    in with pkgs; [
        mangohudWrapped
        protonup-qt

        archipelago
        poptracker
        bs-manager
        r2modman
        lumafly
        heroic

        (prismlauncher.override {
            additionalLibs = ld-libs;
            additionalPrograms = [ ffmpeg ];

            jdks = [
                javaPackages.compiler.openjdk25
                javaPackages.compiler.openjdk21
                javaPackages.compiler.openjdk17
                javaPackages.compiler.openjdk8
            ];
        })

        (GPUOffloadApp osu-lazer "osu")
    ] ++
    # emulators
    [
        mesen
        (GPUOffloadApp ares "ares")
        (GPUOffloadApp mgba "io.mgba.mGBA")
        (GPUOffloadApp melonds "net.kuribo64.melonDS")
        (GPUOffloadApp azahar "org.azahar_emu.Azahar")
        (GPUOffloadApp dolphin-emu "dolphin-emu")
        (GPUOffloadApp cemu "info.cemu.Cemu")
        (GPUOffloadApp ryubing "Ryujinx")
        (GPUOffloadApp eden "dev.eden_emu.eden")
        (GPUOffloadApp chiaki-ng "chiaking")
        (GPUOffloadApp ppsspp "ppsspp")
    ];
}
