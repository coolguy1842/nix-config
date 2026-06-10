{ username, ... }: {
    boot = {
        loader.timeout = 1;
        plymouth.enable = true;
    };

    systemd.network.wait-online.enable = true;
    boot.kernelModules = [ "uinput" ];

    networking = {
        networkmanager.enable = true;

        firewall = {
            enable = true;
            
            allowedTCPPorts = [ 22 ];
            allowedUDPPorts = [];
        };

        interfaces.enp3s0 = {
            ipv4.addresses = [{
                address = "192.168.1.6";
                prefixLength = 24;
            }];
            
            useDHCP = false;
        };
    };

    users.users."${username}" = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" "input" ];
    };
}
