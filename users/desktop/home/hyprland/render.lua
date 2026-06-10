-- Animations
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

-- Decoration Config
hl.config({
    general = {
        gaps_out = 10,
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)"
        }
    },
    decoration = {
        blur = {
            size = 10
        },
        rounding = 8,
        screen_shader = os.getenv("HOME") .. "/.config/hypr/shaders/screen-vibrance.glsl"
    },
    render = {
        direct_scanout = 0
    }
})

-- Layer Rules
hl.layer_rule({
    name = "bar-blur",
    match = { namespace = "bar-[0-9]+" },
    blur = true
})

hl.layer_rule({
    name = "quickshell-blur",
    match = { namespace = "quickshell" },
    blur = true
})

-- see users/desktop/system.nix for path info
hl.env("AQ_DRM_DEVICES", "/dev/dri/intel-card")

-- Monitors
MAIN_MONITOR = "desc:Philips Consumer Electronics Company PHL 322M8CZ 0x000016F2";
hl.monitor({ output = MAIN_MONITOR, mode = "1920x1080@165", position = "1680x0", scale = 1 })

-- workspaces on main monitor
WORKSPACE_ID = 1

for id=1,9 do
    hl.workspace_rule({ workspace = tostring(WORKSPACE_ID), monitor = MAIN_MONITOR, default = id == 1, persistent = true })
    hl.bind(string.format("%s + %d", MAIN_MODIFIER, id), hl.dsp.focus({ workspace = tostring(WORKSPACE_ID) }))
    hl.bind(string.format("%s + SHIFT + %d", MAIN_MODIFIER, id), hl.dsp.window.move({ workspace = tostring(WORKSPACE_ID) }))

    WORKSPACE_ID = WORKSPACE_ID + 1
end

SECOND_MONITOR = "desc:Hewlett Packard LA2205 3CQ0341FGY";
hl.monitor({ output = SECOND_MONITOR, mode = "1680x1050@60", position = "0x30" })

-- workspaces on second monitor
for id=1,2 do
    hl.workspace_rule({ workspace = tostring(WORKSPACE_ID), monitor = SECOND_MONITOR, default = id == 1, persistent = id == 1 })
    hl.bind(string.format("%s + ALT + %d", MAIN_MODIFIER, id), hl.dsp.focus({ workspace = tostring(WORKSPACE_ID) }))
    hl.bind(string.format("%s + SHIFT + ALT + %d", MAIN_MODIFIER, id), hl.dsp.window.move({ workspace = tostring(WORKSPACE_ID) }))

    WORKSPACE_ID = WORKSPACE_ID + 1
end
