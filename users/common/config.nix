{ lib, pkgs, ... }: {
    i18n.defaultLocale = "en_AU.UTF-8";        
    time.timeZone = lib.mkDefault "Australia/Brisbane";

    services.xserver = {
        xkb = {
            layout = "us";
            variant = "";
        };
    };

    users.defaultUserShell = pkgs.bash;
}
