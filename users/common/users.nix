{ lib, username, ... }: {
    users.groups.docker = {};
    users.users."${username}" = {
        isNormalUser = lib.mkDefault true;
        description = lib.mkDefault "${username}";
        extraGroups = [ "networkmanager" "wheel" "video" ];

        initialPassword = "nix";
    };
}
