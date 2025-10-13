// sv_init.nut runs before entities have spawned + on every game load. wait until entities are ready before running
function initStart() {
    local initStartTimer = CreateEntityByName("logic_timer", {   // check every tick if entities have actually spawned in yet
        targetname = "playerblood_canstarttimer"
        RefireTime = 0.01
    })

    initStartTimer.ConnectOutput("OnTimer", "Init")
    EntFire("playerblood_canstarttimer", "Enable")
}
function Init() {   // if player exists, other entities exist
    local player = GetPlayer()
    if(player != null) {
        EntFire("playerblood_canstarttimer", "Kill")    // prevent further inits

        player.__KeyValueFromString("bloodcolor", "0")  // enable blood
        if(GetDeveloperLevel() > 0) printl("[PLAYER BLOOD - DEV] Enabled player blood.")
    }
}

// run the script
initStart()