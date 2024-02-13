ESX = exports["es_extended"]:getSharedObject()
local maxDistance = 5

local function DebugPrint(...)
    print("^3[^6Debug Garage^3]^2 : ",...)
end

function GetClosestGarage()
    local player = cache.ped

    for id,garagedata in pairs(Config.Garages) do
        local playerDistance = GetEntityCoords(player)
        local point = garagedata.point
        local dist = GetDistanceBetweenCoords(point.x,point.y,point.z,playerDistance.x,playerDistance.y,playerDistance.z)
       DebugPrint(dist)

        if maxDistance >= dist then
            DebugPrint("in distance of garage")
            for _,coords in pairs(garagedata.slots) do
                local clear = ESX.Game.IsSpawnPointClear(coords, maxDistance)
                if clear then
                    return id,coords
                end
            end
       end
    end
    ESX.ShowNotification("Nie jestes w pobliżu garażu")
    return false
end

exports["npwd"]:createNotification({
    notisId = "npwd:tweetBroadcast",
    appId = "TWITTER",
    content = "Hello, this is a new tweet",
    secondaryTitle = "Twitter bot",
    keepOpen = false,
    duration = 5000,
    path = "/twitter",
})
DebugPrint(GetClosestGarage())