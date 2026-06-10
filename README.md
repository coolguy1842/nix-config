## NOTE: Each user starts with its password as "nix", make sure to change this using passwd.

Activate the config by running:
```nix
git clone https://github.com/coolguy1842/nix-config
sudo nixos-rebuild boot --flake .#<config> --impure
reboot
```

<config\> can be either:
  - desktop
  - media

The config is impure for /etc/nixos/hardware-configuration.nix, and for hyprland hotreloading. It isn't hard to make it pure again.

Wallpaper credits are in ./users/desktop/home/wallpapers/Sources.md
