{ lib, pkgs, username, ... }: {
    networking = {
        hostName = lib.mkDefault "nixos-${username}";

        networkmanager = {
            enable = lib.mkDefault true;
      
            plugins = with pkgs; [
                networkmanager-openvpn
            ];
        };

        firewall.enable = lib.mkDefault false;

        nameservers = lib.mkDefault [ "1.1.1.1" "1.0.0.1" ];
        defaultGateway = {
            address = lib.mkDefault "192.168.1.1";
            interface = lib.mkDefault null;
        };
    };

    # i have slow internet so limit for app bandwidth
    nix.extraOptions = lib.mkDefault ''
        download-speed = 1000
    '';
}
