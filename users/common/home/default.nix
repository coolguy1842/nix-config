{ lib, ... }: {
    imports = [
        ./theme.nix
    ];
    
    home.stateVersion = lib.mkDefault "26.05";
}
