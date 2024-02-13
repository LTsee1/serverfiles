ESX = exports["es_extended"]:getSharedObject()

Rust = {}

-- functions

function Rust:Ban(plr,reason)
    reason = reason or "Automatic System [Rust Anticheat]"
    local str = "You are banned from this server expires : Never \nReason: "..reason
    TriggerClientEvent("chatMessage", plr, "[RUST]", { 200, 100, 100 },str)
end
function Rust:Kick(plr,reason)
    TriggerClientEvent("chatMessage", plr, "[RUST]", { 200, 100, 100 }," kicked: ")
end

function Rust:Debug(...)
    print('^3[^1RUST^3] ^2',...)
end


-- players

Rust.players = {}

-- player data
function createPlayerMetadata()
    local p = {}
    -- entities
    p.entites = {
    [1] = { -- peds
            Total = 0,
            LastSpawn = os.time(),
        },
        [2] = { -- vehicles
            Total = 0,
            LastSpawn = os.time(),
        },
        [3] = { -- objects
            Total = 0,
            LastSpawn = os.time(),
        },    
    }
    return p
end

function Rust:GetPlayerData(src)
    return Rust.players[src] or Rust.players[tostring(src)]
end


AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    deferrals.defer();

    Wait(0)
    deferrals.update("[RUST ANTICHEAT] Are you banned?");


    deferrals.done();

    
    Rust.players[source] = createPlayerMetadata()
end)

AddEventHandler('playerDropped', function (reason)
  Rust.players[source] = nil
end)
  

-- active players (when script restarts)
for _, playerId in ipairs(GetPlayers()) do
    Rust:Debug("Metadata [",playerId,"]")
    Rust.players[playerId] = createPlayerMetadata()
end