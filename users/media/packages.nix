{ pkgs, username, ... }: {
    users.users."${username}".packages = with pkgs; [
        kitty
        firefox
        moonlight-qt
        chiaki-ng
        jellyfin-media-player
    ];
}
