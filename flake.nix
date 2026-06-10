{
    description = "NixOS Config";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        ags.url = "github:coolguy1842/agsv1/v1";
        ags-config = {
            url = "github:coolguy1842/ags";
            flake = false;
        };

        waveeffect.url = "github:coolguy1842/waveeffect";
        savesyncd.url = "github:coolguy1842/SaveSyncd";
        
        capturecardrelay = {
            url = "github:coolguy1842/CaptureCardRelay";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        monado = {
            url = "gitlab:monado/monado?host=gitlab.freedesktop.org";
            flake = false;
        };
    };

    outputs = { nixpkgs, home-manager, ... } @ inputs: let
        defaultConfig = configName: username: customModule: nixpkgs.lib.nixosSystem {
            modules = [
                /etc/nixos/hardware-configuration.nix
                ./users/common
                ./users/${configName}
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        backupFileExtension = "hmbak";

                        users."${username}" = {
                            imports = [
                                ./users/common/home
                                ./users/${configName}/home
                            ];
                        };

                        extraSpecialArgs = {
                            inherit inputs username;
                        };
                    };
                }
                inputs.savesyncd.nixosModules.default
                { nixpkgs.hostPlatform = "x86_64-linux"; }
                { nixpkgs.config.allowUnfree = true; }
                # TODO: allow for agsv1(not ideal)
                { nixpkgs.config.permittedInsecurePackages = [ "libsoup-2.74.3" ]; }
                customModule
            ];

            specialArgs = { inherit inputs configName username; };
        };
    in {
        nixosConfigurations = {
            desktop = defaultConfig "desktop" "coolguy" {};
            media = defaultConfig "media" "media" {};
        };
    };
}
