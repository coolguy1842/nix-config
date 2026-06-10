{ pkgs, ... }: {
    services.sunshine = {
        enable = true;

        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;

        settings = {
            sunshine_name = "desktop-nixos";

            capture = "kms";
            encoder = "vaapi";

            output_name = 1;

            adapter_name = "/dev/dri/intel-render";
            kms_node = "/dev/dri/intel-card";
        };

        applications.apps = [
            {
                name = "Desktop";

                exclude-global-prep-cmd = "false";
                auto-detach = "true";
            }
            {
                name = "1440p Desktop";
                prep-cmd = [
                    {
                        do = "${(pkgs.writeShellScriptBin "startSunshine" ''
                            hyprctl eval 'hl.config({ decoration = { screen_shader = \"\" } })'

                            hyprctl eval 'hl.monitor({ output = SECOND_MONITOR, mode = "2560x1440@100", position = "auto", scale = 1.3333 })'
                            hyprctl eval 'hl.monitor({ output = MAIN_MONITOR, disabled = true })'
                        '')}/bin/startSunshine";
                        undo = "${(pkgs.writeShellScriptBin "stopSunshine" ''
                            hyprctl reload
                        '')}/bin/stopSunshine";
                    }
                ];

                exclude-global-prep-cmd = "false";
                auto-detach = "true";
            }
        ];
    };
}
