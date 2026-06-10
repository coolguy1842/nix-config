{ ... }: {
    services.syncthing = {
        enable = true;
        group = "users";
        user = "coolguy";
        dataDir = "/home/coolguy";
        configDir = "/home/coolguy/.config/syncthing";
    };
}
