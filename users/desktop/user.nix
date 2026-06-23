{ pkgs, inputs, username, ... }: {
    users.users."${username}" = {
        extraGroups = [ "dialout" "input" "plugdev" "libvirtd" "qemu" "docker" "podman" "gamemode" "devcontainer" "immich" ];

        packages = [
            inputs.capturecardrelay.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
    };
}
