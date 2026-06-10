hl.config({
    general = {
        border_size = 0,
        gaps_in = 0,
        gaps_out = 0
    },
    decoration = {
        blur = {
            enabled = false
        },
        shadow = {
            enabled = false
        }
    },
    cursor = {
        inactive_timeout = 2
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        background_color = "#000000"
    },
    animations = {
        enabled = false
    }
})

MONITOR = "desc:Shenzhen KTC Technology Group H27T27";
hl.monitor({
    output = MONITOR,
    mode = "2560x1440@100",
    position = "0x0",
    scale = 1,
    transform = 2,
    vrr = true,

    bitdepth = 8,
    cm = "hdr",
    sdrbrightness = 1.2,
    sdrsaturation = 1.0,
})
