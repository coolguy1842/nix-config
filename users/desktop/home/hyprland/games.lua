local EForcingGameMode = Enum { "NotForcing", "ForcingOn", "ForcingOff" }
local forcingGameMode = EForcingGameMode.NotForcing

local gameModeEnabled = false
local function setGameModeEnabled(enabled, showStatus)
    if gameModeEnabled == enabled or type(enabled) ~= "boolean" then
        return
    end

    gameModeEnabled = enabled
    hl.monitor({ output = MAIN_MONITOR, scale = gameModeEnabled and 1.0 or MAIN_MONITOR_DEFAULT_SCALING, vrr = gameModeEnabled and 1 or 0 })
    hl.timer(function() UpdateSecondMonitorPosition() end, {timeout = 25, type = "oneshot"})

    if showStatus ~= false then
        switch(gameModeEnabled)
            .case(true, function() hl.notification.create({ text = "Game Mode Enabled", timeout = 1500, color = "#62BE5EFF" }) end)
            .case(false, function() hl.notification.create({ text = "Game Mode Disabled", timeout = 1500, color = "#C45C5CFF" }) end)
            .process()
    end
end

-- initialClass, should only be needed if game doesnt have game tag, follows lua pattern matching
local windowGameOverrides = {
    "^gamescope$",
    "^steam_app_%d+$",
    "^Minecraft.*$"
}

local windowValidContentTypes = {
    "game",
    "video"
}

local function shouldEnableGameMode(workspace)
    if workspace == nil then
        return false
    end

    local window = workspace.fullscreen_window
    return (
        window ~= nil and window.fullscreen ~= 0 and
        (
            HasValue(windowValidContentTypes, window.content_type) or
            HasValueMatchingPattern(windowGameOverrides, window.initial_class)
        )
    )
end

local function checkGameActive()
    if forcingGameMode ~= EForcingGameMode.NotForcing then
        return
    end

    local monitor = hl.get_monitor(MAIN_MONITOR)
    setGameModeEnabled(
        monitor ~= nil and
        (
            shouldEnableGameMode(monitor.active_workspace) or
            shouldEnableGameMode(monitor.active_special_workspace)
        )
    )
end

hl.on("workspace.active", checkGameActive)
hl.on("window.active", checkGameActive)
hl.on("window.fullscreen", checkGameActive)

hl.bind(MAIN_MODIFIER .. " + F1", function()
    forcingGameMode = EForcingGameMode.next(forcingGameMode)
    switch(forcingGameMode)
        .case(EForcingGameMode.NotForcing, function()
            hl.notification.create({ text = "Not Forcing Game Mode", timeout = 1500, color = "#C45C5CFF" })
            checkGameActive()
        end)
        .case(EForcingGameMode.ForcingOn, function()
            hl.notification.create({ text = "Forcing Game Mode On", timeout = 1500, color = "#62BE5EFF" })
            setGameModeEnabled(true, false)
        end)
        .case(EForcingGameMode.ForcingOff, function()
            hl.notification.create({ text = "Forcing Game Mode Off", timeout = 1500, color = "#C49C5C" })
            setGameModeEnabled(false, false)
        end)
        .process()
end)
