{ pkgs, username, ... }: {
    services.gnome.gnome-keyring.enable = true;

    environment.systemPackages = with pkgs; [
        polkit
        polkit_gnome
    ];
    
    security = {
        # change hard file limit for horizon zero dawn and forbidden west audio
        pam.loginLimits = [
            { domain = "*"; type = "soft"; item = "nofile"; value = "8192";     }
            { domain = "*"; type = "hard"; item = "nofile"; value = "infinity"; }
        ];
        
        polkit = {
            enable = true;

            # allow reboot and shutdown without auth
            extraConfig = ''
                polkit.addRule(function(action, subject) {
                    if(
                        subject.user == "${username}"
                        && (
                            action.id.indexOf("org.freedesktop.NetworkManager.") == 0 ||
                            action.id.indexOf("org.freedesktop.ModemManager") == 0
                        )
                    ) {
                        return polkit.Result.YES;
                    }
                });

                polkit.addRule(function(action, subject) {
                if(
                    subject.isInGroup("users")
                    && (
                        action.id == "org.freedesktop.login1.reboot" ||
                        action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                        action.id == "org.freedesktop.login1.power-off" ||
                        action.id == "org.freedesktop.login1.power-off-multiple-sessions"
                    )
                    ) {
                        return polkit.Result.YES;
                    }
                });
            '';
        };
    };

    # autostart gnome polkit
    systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy    = ["graphical-session.target"];
            wants       = ["graphical-session.target"];
            after       = ["graphical-session.target"];
            
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };
}
