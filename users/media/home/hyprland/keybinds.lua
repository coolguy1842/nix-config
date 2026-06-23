MAIN_MODIFIER = "SUPER"

TERMINAL="kitty"

hl.bind(MAIN_MODIFIER .. " + SHIFT + BACKSPACE", hl.dsp.exit())
hl.bind(MAIN_MODIFIER .. " + Q", hl.dsp.window.close())
hl.bind(MAIN_MODIFIER .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(MAIN_MODIFIER .. " + M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(MAIN_MODIFIER .. " + T", hl.dsp.exec_cmd(TERMINAL))

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


hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.25"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })

local DPMS_STATUS = true
hl.bind(MAIN_MODIFIER .. " + ESCAPE", function()
    hl.timer(function()
        DPMS_STATUS = not DPMS_STATUS
        hl.dispatch(hl.dsp.dpms({ action = DPMS_STATUS and "enabled" or "disabled" }))
    end, {timeout = 500, type = "oneshot"})
end)
