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

            global_prep_cmd = ''[
                {
                    "do": "systemctl stop --user hypridle.service && hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'",
                    "undo": "systemctl start --user hypridle.service"
                }
            ]'';
        };
    };
}
