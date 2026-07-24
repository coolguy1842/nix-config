MAIN_MODIFIER = "SUPER"

WEB_BROWSER="firefox"
FILE_MANAGER="dolphin"
TERMINAL="kitty"

SCREENSHOT="SHADER=$(hyprctl getoption decoration.screen_shader -j | jq '.[\"str\"]'); hyprctl eval 'hl.config({ decoration = { screen_shader = \"\" } })'; wayfreeze & PID=$!; sleep .1; grim -g \"$(slurp)\" - | wl-copy; kill $PID; hyprctl eval \"hl.config({ decoration = { screen_shader = $SHADER } })\""
APP_LAUNCHER="printf \"app_launcher\" | socat - UNIX-CONNECT:/tmp/coolguy/ags/socket"
COLOUR_PICKER="hyprpicker"


hl.config({
    binds = {
        scroll_event_delay = 0
    }
})

hl.bind(MAIN_MODIFIER .. " + SHIFT + BACKSPACE", hl.dsp.exit())

hl.bind(MAIN_MODIFIER .. " + Q", hl.dsp.window.close())
hl.bind(MAIN_MODIFIER .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(MAIN_MODIFIER .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MAIN_MODIFIER .. " + M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(MAIN_MODIFIER .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(MAIN_MODIFIER .. " + P", function()
    local window = hl.get_active_window()
    if window == nil or not window.floating then
        return
    end

    hl.dispatch(hl.dsp.window.pin({ window = window }))

    if window.pinned then
        hl.notification.create({ text = "Window Pinned",  timeout = 1500, color = "#62BE5EFF" })
    else
        hl.notification.create({ text = "Window Not pinned", timeout = 1500, color = "#C45C5CFF" })
    end
end)

hl.bind(MAIN_MODIFIER .. " + W", hl.dsp.exec_cmd(WEB_BROWSER))
hl.bind(MAIN_MODIFIER .. " + N", hl.dsp.exec_cmd(FILE_MANAGER))
hl.bind(MAIN_MODIFIER .. " + T", hl.dsp.exec_cmd(TERMINAL))

hl.bind(MAIN_MODIFIER .. " + SPACE", hl.dsp.exec_cmd(APP_LAUNCHER))
hl.bind(MAIN_MODIFIER .. " + L", hl.dsp.exec_cmd(COLOUR_PICKER))
hl.bind("Print", hl.dsp.exec_cmd(SCREENSHOT))

hl.bind(MAIN_MODIFIER .. " + LEFT", hl.dsp.focus({ workspace = "m-1" }), { repeating = true })
hl.bind(MAIN_MODIFIER .. " + RIGHT", hl.dsp.focus({ workspace = "m+1" }), { repeating = true })

hl.bind(MAIN_MODIFIER .. " + SHIFT + LEFT", hl.dsp.window.move({ workspace = "e-1" }), { repeating = true })
hl.bind(MAIN_MODIFIER .. " + SHIFT + RIGHT", hl.dsp.window.move({ workspace = "e+1" }), { repeating = true })


hl.bind(MAIN_MODIFIER .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(MAIN_MODIFIER .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }))

hl.bind(MAIN_MODIFIER .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) 
hl.bind(MAIN_MODIFIER .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


hl.bind("ALT + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind("ALT + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind("ALT + UP", hl.dsp.focus({ direction = "u" }))
hl.bind("ALT + DOWN", hl.dsp.focus({ direction = "d" }))

hl.bind("ALT + TAB", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

hl.bind("ALT + SHIFT + TAB", function()
    hl.dispatch(hl.dsp.window.cycle_next({ prev = false }))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)


hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.25"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })

hl.config({
    misc = {
        enable_swallow = false,
        swallow_regex = "^(kitty)$"
    }
})

-- only works if the window had been swallowed
hl.bind(MAIN_MODIFIER .. " + X", hl.dsp.window.toggle_swallow())
hl.bind(MAIN_MODIFIER .. " + V", function()
    local should_swallow = not hl.get_config("misc.enable_swallow")

    if should_swallow then
        hl.notification.create({ text = "Window Swallowing Enabled",  timeout = 1500, color = "#62BE5EFF" })
    else
        hl.notification.create({ text = "Window Swallowing Disabled", timeout = 1500, color = "#C45C5CFF" })
    end

    hl.config({ misc = { enable_swallow = should_swallow }})
end)

hl.config({ cursor = { zoom_detached_camera = false } })
hl.bind(MAIN_MODIFIER .. " + SHIFT + mouse_down", function()
    local zoom = hl.get_config("cursor.zoom_factor")

    zoom = zoom + 0.2
    hl.config({ cursor = { zoom_factor = zoom }})
end)

hl.bind(MAIN_MODIFIER .. " + SHIFT + mouse_up", function()
    local zoom = hl.get_config("cursor.zoom_factor")

    zoom = zoom - 0.5
    if zoom < 1.0 then
        zoom = 1.0
    end

    hl.config({ cursor = { zoom_factor = zoom }})
end)
