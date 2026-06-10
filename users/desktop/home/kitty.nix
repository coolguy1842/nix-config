{ ... }: {
    programs.kitty = {
        enable = true;
        enableGitIntegration = true;
        
        font.name = "Source Code Pro Medium";
        font.size = 12.0;
        
        settings = {
            scrollback_lines = 10000;
            enable_audio_bell = false;

            update_check_interval = 0;

            background_opacity = 0.96;
            background_blur = 60;
        };

        extraConfig = ''
            confirm_os_window_close 0
        '';

        shellIntegration = {
            enableBashIntegration = true;
        };
    };
}
