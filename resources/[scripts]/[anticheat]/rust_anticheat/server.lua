


RegisterNetEvent("Rust:banself")
AddEventHandler("Rust:banself",function ()
    local plr = source
    Rust:Ban(plr)
end)

AddEventHandler('weaponDamageEvent', function(sender, data)
    if data.silenced and data.weaponDamage == 0 and data.weaponType == 2725352035 then
        Rust:Ban(sender)
    end
    if data.silenced and data.weaponDamage == 0 and data.weaponType == 3452007600 then
        Rust:Ban(sender)
    end
end)

AddEventHandler('explosionEvent', function(sender, ev)
    local name = GetPlayerName(sender)
    local _src = source

    -- We need to make sure it is original from explosion sender.
    if ev.damageScale ~= 0.0 and ev.ownerNetId == 0 then 
        Rust:Ban(_src)
        CancelEvent()
    end
end)

--[[
AddEventHandler('entityCreated', function(entity) --- this can ban wrong
    if not DoesEntityExist(entity) then
        return
    end
    local type, owner, population, model = GetEntityType(entity), NetworkGetFirstEntityOwner(entity),  GetEntityPopulationType(entity), GetEntityModel(entity)
        local pData = Rust:GetPlayerData(owner)

       if population == 0 then
                 -- counting player entities
            local lastSpawn = pData.entites[type].LastSpawn
            local lastTotal = pData.entites[type].Total

            local curTotal = lastTotal + 1

            local currentSpawn = os.time()
            print("lastSpawn : ", lastSpawn)
            print("curSpawn :", currentSpawn)
            print("lastTotal : ", lastTotal)
            print('dif ', currentSpawn-lastSpawn)
            if currentSpawn-lastSpawn > 10 then
                pData.entites[type].lastSpawn = currentSpawn
                pData.entites[type].Total = 0
                print("reset")

            else
                print("Total : ", pData.entites[type].Total)
                print(config.MaxEntites[type])

                if pData.entites[type].Total >= config.MaxEntites[type] then
                    local _list = GetAllEntitiesOfType(type)
                    -- Destroy all player ents in specified type
                    for _, ent in pairs(_list) do
                        local entOwner = NetworkGetFirstEntityOwner(ent)
                        if entOwner == owner and DoesEntityExist(ent) then
                            DeleteEntity(ent)
                        end
                    end
                    
                    if DoesEntityExist(entity) then
                        DeleteEntity(entity)
                    end
                    
                    Rust:Kick(owner)
                end
            end

         
        end

end)]]

local resourceList = {}
for i = 0, GetNumResources(), 1 do
  local resource_name = GetResourceByFindIndex(i)
  if resource_name and GetResourceState(resource_name) == "started" then
    table.insert(resourceList, resource_name)
  end
end


exports("BanPlayer",function (player,reason)
    Rust:Ban(player,reason)
end)