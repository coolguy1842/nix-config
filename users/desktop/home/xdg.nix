{ pkgs, ... }: let
    web-browser = "firefox.desktop";
    file-manager = "dolphin.desktop";  
in {
    xdg = {
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                kdePackages.xdg-desktop-portal-kde
                xdg-desktop-portal-hyprland
            ];

            config = {
                common = {
                    default = [
                        "gtk"
                        "hyprland"
                    ];

                    "org.freedesktop.impl.portal.FileChooser" = "kde";
                };
            };
        };

        mimeApps = {
            enable = true;
    
            defaultApplications = {
                "default-web-browser" = web-browser;
                
                "text/html"              = web-browser;
                "x-scheme-handler/http"  = web-browser;
                "x-scheme-handler/https" = web-browser;

                "inode/directory" = file-manager;
            };

            associations.added = {
                "x-scheme-handler/http"         = [ web-browser ];
                "x-scheme-handler/https"        = [ web-browser ];
                "x-scheme-handler/chrome"       = [ web-browser ];
                "text/html"                     = [ web-browser ];
                "application/x-extension-htm"   = [ web-browser ];
                "application/x-extension-html"  = [ web-browser ];
                "application/x-extension-shtml" = [ web-browser ];
                "application/xhtml+xml"         = [ web-browser ];
                "application/x-extension-xhtml" = [ web-browser ];
                "application/x-extension-xht"   = [ web-browser ];

                "inode/directory" = [ file-manager ];
            };
        };
    };
}
