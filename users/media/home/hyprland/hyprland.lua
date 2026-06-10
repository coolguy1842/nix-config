HOME = os.getenv("HOME")
PUBLIC = HOME .. "/nix-config/users/media/home/hyprland"

XDG = os.getenv("XDG_CONFIG_HOME") or (HOME .. "/.config")

-- package.path = package.path
--   .. ";" .. PUBLIC          .. "/?.lua"
--   .. ";" .. XDG .. "/hypr"  .. "/?.lua"

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

require("keybinds")
require("render")
require("input")
require("workspaces")

hl.on("hyprland.start", function ()
    hl.exec_cmd("systemctl --user import-environment PATH WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("playerctld")
end)
