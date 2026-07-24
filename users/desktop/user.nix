{ username, ... }: {
    users.users."${username}" = {
        extraGroups = [ "dialout" "input" "plugdev" "libvirtd" "qemu" "docker" "podman" "gamemode" "devcontainer" "immich" ];
    };
}
