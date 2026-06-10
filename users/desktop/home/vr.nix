{ inputs, username, config, pkgs, ... }: let
    # to try 
    monadoPatched = pkgs.monado.overrideAttrs (_: {
        src = inputs.monado;

        patches = [];
    });
in {
    home.packages = with pkgs; [
        xrgears
        xr-hardware

        monadoPatched
        sidequest
    ];

    xdg.configFile."openxr/1/active_runtime.json" = {
        text = builtins.toJSON {
            file_format_version = "1.0.0";
            runtime = {
                name = "SteamVR";
                VALVE_runtime_is_steamvr = true;
                library_path = "/home/${username}/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrclient.so";
            };
        };
    };

    # xdg.configFile."openxr/1/active_runtime.json".source = "${monadoPatched}/share/openxr/1/openxr_monado.json";
    # xdg.configFile."openvr/openvrpaths.vrpath".text = ''
    #     {
    #         "config": [
    #             "${config.xdg.dataHome}/Steam/config"
    #         ],
    #         "external_drivers": null,
    #         "jsonid": "vrpathreg",
    #         "log": [
    #             "${config.xdg.dataHome}/Steam/logs"
    #         ],
    #         "runtime": [
    #             "${pkgs.opencomposite}/lib/opencomposite"
    #         ],
    #         "version": 1
    #     }
    # '';

    # or use "${pkgs.xrizer}/lib/xrizer" in runtime
}
