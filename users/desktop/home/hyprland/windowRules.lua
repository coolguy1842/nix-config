hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({ match = { initial_title = "^(CaptureCardRelay)$"  }, fullscreen = true                    })
hl.window_rule({ match = { initial_class = "^(discord)|(vesktop)$" }, workspace = "special:discord silent" })
hl.window_rule({ match = { initial_class = "^(Dopamine)$"          }, workspace = "special:music silent"   })
hl.window_rule({ match = { initial_class = "^(electron-mail)$"     }, workspace = "special:email silent"   })

hl.window_rule({ match = { class = "steam", title = "^(Friends List)$" }, float = true})

local HIDDEN_BORDER_COLOR = { colors = { "rgba(ff3333ee)", "rgba(ff3c00ee)" }, angle = 45 }

HIDDEN_WINDOWS = {}
local function setToggleableWindow(initial_class, enabled)
    hl.window_rule({
        enabled = enabled,
        name = string.format("%s_no_screenshare", initial_class),
        match = { initial_class = initial_class },
        border_color = HIDDEN_BORDER_COLOR,
        no_screen_share = true
    })

    HIDDEN_WINDOWS[initial_class] = enabled
end

-- both should be plain initial_class, regex will remove any toggle logic
UNTOGGLEABLE_HIDDEN = {
    "electron-mail",
    "io.ente.auth",
    "proton-pass",
    "librewolf",
    "ferdium",
    "signal",

    "steam_app_945360"
}

for _, initial_class in ipairs(UNTOGGLEABLE_HIDDEN) do
    hl.window_rule({ match = { initial_class = initial_class }, no_screen_share = true, border_color = HIDDEN_BORDER_COLOR })
end

TOGGLEABLE_HIDDEN = {
    "steam_app_4704690"
}

for _, initial_class in ipairs(TOGGLEABLE_HIDDEN) do
    setToggleableWindow(initial_class, true)
end

hl.bind(MAIN_MODIFIER .. " + R", function()
    local window = hl.get_active_window()
    if window == nil then
        return
    end

    if HasValue(UNTOGGLEABLE_HIDDEN, window.initial_class) then
        hl.notification.create({ text = string.format("%s is untoggleable.", window.initial_class), timeout = 2000, color = "#C45C5CFF" })
        return
    end

    local windowHidden = HIDDEN_WINDOWS[window.initial_class] == nil or not HIDDEN_WINDOWS[window.initial_class]
    setToggleableWindow(window.initial_class, windowHidden)

    switch(windowHidden)
        .case(true, function() hl.notification.create({ text = string.format("%s is now hidden.", window.initial_class), timeout = 2000, color = "#62BE5EFF" }) end)
        .case(false, function() hl.notification.create({ text = string.format("%s is not hidden.", window.initial_class), timeout = 2000, color = "#C45C5CFF" }) end)
        .process()
end)


