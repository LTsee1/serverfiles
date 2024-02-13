local dispatch = {}
local ESX
local QBCore

dispatch.Framework = "STANDALONE"
if dispatch.Framework == "STANDALONE" then
    if GetResourceState("es_extended") ~= "missing"  then
         ESX = exports['es_extended']:getSharedObject()
        dispatch.Framework = "ESX"
    elseif GetResourceState("qb-core") ~= "missing" then
         QBCore = exports['qb-core']:GetCoreObject()
        dispatch.Framework = "QB"
    end 
end

dispatch['ESX'] = {}
dispatch['QB'] = {}
dispatch['STANDALONE'] = {}

dispatch.list = {}

dispatch.id = 1

function NewDispatch(data)
    dispatch.id += 1
    local id = dispatch.id
    data.id = id
    dispatch.list[id] = {
        units = {},
        max_units = 6,
        data = data
    }
    local xPlayers = ESX.GetExtendedPlayers('job', data.job)

    for _, xPlayer in pairs(xPlayers) do
        TriggerClientEvent("dispatch:NewDispatch",xPlayer.source,data)
    end
end

exports("NewDispatch",NewDispatch)
  /* EXAMPLE  
   local dispatch_data = {
        code = "10-91",
     title = "Sprzedaż narkotyków",
     description = "Obywatel handluje narkotykami!",
     blink = false, -- blinks infinite in red
     coordinates = {
       x = 100, 
       y =100
      },
      job = "unemployed",
     }
  */


RegisterNetEvent("Player:RequestJoinToDispatch")
AddEventHandler("Player:RequestJoinToDispatch",function(dispatch_id)
    local src = source
    local dispatch = dispatch.list[dispatch_id]
    
    if dispatch then
        local units_in = #dispatch.units    
        if units_in < 6 and units_in+1 <= 6 then
            

            if dispatch.units[src] then -- leaves from dispatch
                    dispatch.units[src] = nil
                    -- update event 
                    TriggerClientEvent("dispatch:AddUnitToDispatch",-1,dispatch_id,dispatch)
                    return
            end

            local xPlayer = ESX.GetPlayerFromId(src)
            local new_unit = {
                src = src,
                label = xPlayer.getName()
            }
            
            dispatch.units[src] = new_unit
            TriggerClientEvent("dispatch:AddUnitToDispatch",-1,dispatch_id,dispatch)
        end
    end

end)