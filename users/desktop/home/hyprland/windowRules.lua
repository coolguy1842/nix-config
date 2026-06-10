hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({ match = { initial_title = "^(CaptureCardRelay)$"  }, fullscreen = true                    })
hl.window_rule({ match = { initial_class = "^(discord)|(vesktop)$" }, workspace = "special:discord silent" })
hl.window_rule({ match = { initial_class = "^(Dopamine)$"          }, workspace = "special:music silent"   })
hl.window_rule({ match = { initial_class = "^(electron-mail)$"     }, workspace = "special:email silent"   })

hl.window_rule({
    match = { initial_class = "^(electron-mail)|(Proton Pass)|(io.ente.auth)|(Element)|(Signal)|(librewolf)|(Among Us)$" },
    no_screen_share = true
})

hl.window_rule({ match = { class = "steam", title = "^(Friends List)$" }, float = true})
