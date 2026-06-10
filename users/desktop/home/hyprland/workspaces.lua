SPECIAL_WORKSPACES = {
    discord     = { key = "D", on_created_empty = ""                     },
    music       = { key = "S", on_created_empty = ""                     },
    email       = { key = "E", on_created_empty = ""                     },
    capturecard = { key = "C", on_created_empty = "CaptureCardRelay"     },
    windows     = { key = "G", on_created_empty = "looking-glass-client" },
}

-- special workspaces
for workspaceName, options in pairs(SPECIAL_WORKSPACES) do
    local name = "special:" .. workspaceName

    hl.workspace_rule({ workspace = name, on_created_empty = options.on_created_empty })

    hl.bind(string.format("%s + %s", MAIN_MODIFIER, options.key), hl.dsp.workspace.toggle_special(workspaceName))
    hl.bind(string.format("%s + SHIFT + %s", MAIN_MODIFIER, options.key), hl.dsp.window.move({ workspace = name }))
end
