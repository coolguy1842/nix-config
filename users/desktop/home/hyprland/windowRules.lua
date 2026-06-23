hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({ match = { initial_title = "^(CaptureCardRelay)$"  }, fullscreen = true                    })
hl.window_rule({ match = { initial_class = "^(discord)|(vesktop)$" }, workspace = "special:discord silent" })
hl.window_rule({ match = { initial_class = "^(Dopamine)$"          }, workspace = "special:music silent"   })
hl.window_rule({ match = { initial_class = "^(electron-mail)$"     }, workspace = "special:email silent"   })

hl.window_rule({ match = { class = "steam", title = "^(Friends List)$" }, float = true})

-- both should be plain initial_class, regex will remove any toggle logic
UNTOGGLEABLE_HIDDEN = {
    "electron-mail",
    "io.ente.auth",
    "proton-pass",
    "librewolf",
    "Ferdium",
    "signal",

    "steam_app_945360"
}

TOGGLEABLE_HIDDEN = {
    "steam_app_4704690"
}

local function has_value(table, a)
    for _, b in ipairs(table) do
        if a == b then
            return true
        end
    end

    return false
end


HIDDEN_WINDOWS = {}
for _, initial_class in ipairs(UNTOGGLEABLE_HIDDEN) do
    hl.window_rule({
        match = { initial_class = initial_class },
        no_screen_share = true
    })
end

for _, initial_class in ipairs(TOGGLEABLE_HIDDEN) do
    hl.window_rule({
        name = string.format("%s_no_screenshare", initial_class),
        match = { initial_class = initial_class },
        no_screen_share = true
    })

    HIDDEN_WINDOWS[initial_class] = true
end

hl.bind(MAIN_MODIFIER .. " + R", function()
    local window = hl.get_active_window()
    if window == nil then
        return
    elseif has_value(UNTOGGLEABLE_HIDDEN, window.initial_class) then
        hl.notification.create({ text = string.format("%s is untoggleable.", window.initial_class), timeout = 2000, color = "#C45C5CFF" })

        return
    end

    local windowHidden = HIDDEN_WINDOWS[window.initial_class] == nil or not HIDDEN_WINDOWS[window.initial_class]
    hl.window_rule({
        enabled = windowHidden,
        name = string.format("%s_no_screenshare", window.initial_class),
        match = { initial_class = window.initial_class },
        no_screen_share = true
    })

    HIDDEN_WINDOWS[window.initial_class] = windowHidden

    if windowHidden then
        hl.notification.create({ text = string.format("%s is now hidden.", window.initial_class), timeout = 2000, color = "#62BE5EFF" })
    else
        hl.notification.create({ text = string.format("%s is not hidden.", window.initial_class), timeout = 2000, color = "#C45C5CFF" })
    end
end)


