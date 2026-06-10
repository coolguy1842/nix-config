WORKSPACES = {
    { on_created_empty = "firefox"          },
    { on_created_empty = "moonlight"        },
    { on_created_empty = "chiaki"           },
    { on_created_empty = "jellyfin-desktop" },
}

WORKSPACE_ID = 1
for _, options in ipairs(WORKSPACES) do
    hl.workspace_rule({ workspace = tostring(WORKSPACE_ID), on_created_empty = options.on_created_empty, default = WORKSPACE_ID == 1 })

    hl.bind(string.format("%s + ALT + %d", MAIN_MODIFIER, WORKSPACE_ID), hl.dsp.focus({ workspace = tostring(WORKSPACE_ID) }))
    hl.bind(string.format("%s + SHIFT + ALT + %d", MAIN_MODIFIER, WORKSPACE_ID), hl.dsp.window.move({ workspace = tostring(WORKSPACE_ID) }))

    WORKSPACE_ID = WORKSPACE_ID + 1
end
