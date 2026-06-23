HOME = os.getenv("HOME")
PUBLIC = HOME .. "/nix-config/users/desktop/home/hyprland"

XDG = os.getenv("XDG_CONFIG_HOME") or (HOME .. "/.config")

package.path = package.path
  .. ";" .. PUBLIC          .. "/?.lua"
  .. ";" .. XDG .. "/hypr"  .. "/?.lua"

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

-- hl.exec_cmd("")

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user import-environment PATH WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- start daemons, bar and user apps
    hl.exec_cmd([[ bash -c '
        playerctld &
        awww-daemon &
        ags &

        sleep 1
        cycle-wallpaper &

        sleep 1
        
        nm-applet &
        vesktop &
        dopamine &
        signal-desktop --use-tray-icon --start-in-tray &
        electron-mail &
        ferdium &
    ']])
end)

require("keybinds")
require("workspaces")
require("windowRules")
require("render")
require("layout")
require("input")
