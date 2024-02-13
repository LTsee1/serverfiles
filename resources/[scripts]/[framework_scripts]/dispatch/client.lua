local dispatch = {}
local ESX
local QBCore

-- variables
dispatch.InFocus = false
dispatch.DispatchForJobs = {}



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

dispatch['ESX'].ShowNotification = function(msg,type,time)
    ESX.ShowNotification(msg, type or 'success', time or 3000)
end
dispatch['QB'].ShowNotification = function(text,textype,length)
    QBCore.Functions.Notify(text, textype, length)
end

dispatch['STANDALONE'].ShowNotification = function(text)
end


-- functions
function dispatch:Focus()
    dispatch.InFocus = true
    SetNuiFocus(
        dispatch.InFocus,
        dispatch.InFocus
    )
    SendNUIMessage({
        action = "focus",
        focus =   dispatch.InFocus
    })
end
function dispatch:UnFocus()
    dispatch.InFocus = false
    SetNuiFocus(
        dispatch.InFocus,
        dispatch.InFocus
    )
    SendNUIMessage({
        action = "focus",
        focus =  dispatch.InFocus
    })
end
function dispatch:SetGPS(coordinates)
    dispatch:UnFocus()
    local x,y = coordinates.x,coordinates.y
    SetNewWaypoint(x,y)
    dispatch[dispatch.Framework].ShowNotification('Ustawiono GPS na zgłoszenie')
end
function dispatch:Initialize()
    dispatch:UnFocus()
end

dispatch:Initialize()

-- SendDispatch
-- @data = {
--   code = "10-13",
--title = "This is notification Title",
--description = "This is description of notification",
--dontshowtimer = true, -- Disables Timer 
--coordinates = {
--  x = 100, 
--  y =100
-- },
--}


function dispatch:SendDispatch(data)
    SendNUIMessage({
        action = "NewNotify",
        list = {data},
    })
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end


-- NUI Callbacks
RegisterNUICallback('dispatch:UnFocus', function(data)
    dispatch:UnFocus()
end)    

RegisterNUICallback('dispatch:SetGPS', function(data)
    dispatch:SetGPS(data.coordinates)
end)
RegisterNUICallback('dispatch:Join', function(data)
    TriggerServerEvent("Player:RequestJoinToDispatch",data.id)
end)

-- Enabling dispatch
RegisterCommand('+dispatch', function()
    if Config.AllowedJobsToDisplayDispatch[ESX.PlayerData.job.name] then
        if not dispatch.InFocus then
            dispatch:Focus()
        end 
    end    
end, false)

RegisterCommand('-dispatch', function()

end, false)


RegisterKeyMapping('+dispatch', 'Otwórz Dispatch', 'keyboard', 'HOME')

-- events
RegisterNetEvent("dispatch:NewDispatch")
AddEventHandler("dispatch:NewDispatch",function (data)
    if not Config.AllowedJobsToDisplayDispatch[ESX.PlayerData.job.name] then
        return
    end
    

    dispatch:SendDispatch(data)
end)

RegisterNetEvent("dispatch:ShowNotification")
AddEventHandler("dispatch:ShowNotification", function(dispatch)
    local dispatch_data = dispatch.data 


end)


RegisterNetEvent("dispatch:AddUnitToDispatch")
AddEventHandler("dispatch:AddUnitToDispatch",function (dispatch_id,dispatch)
    SendNUIMessage({
        action = "AddUnit",
        id = dispatch_id,
        dispatch_data = dispatch
    })
    local notify_data = dispatch

end)

