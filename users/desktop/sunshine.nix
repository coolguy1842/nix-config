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

            output_name = 0;

            adapter_name = "/dev/dri/intel-render";
            kms_node = "/dev/dri/intel-card";
        };


        applications.apps = [
            {
                name = "Desktop";
                prep-cmd = [
                    {
                        do = "${(pkgs.writeShellScriptBin "startSunshine" ''
                            hyprctl eval 'hl.monitor({ output = SECOND_MONITOR, disabled = true })'
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
