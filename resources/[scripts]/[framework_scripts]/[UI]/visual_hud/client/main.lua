local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
ESX = nil

ESX = exports["es_extended"]:getSharedObject()
playerLoaded = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    Citizen.Wait(200)
    playerLoaded = true
    StartHud()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    Citizen.Wait(200)
    StartHud()
end)
function notify(title,message,duration,icon)

    if string.find(message, "<iframe") or string.find(message, "<img") or string.find(message, "<video") then return end

        if icon == nil then 
            SendNUIMessage({
                action = "notify_js",
                duration = duration or 3000,
                title = colorformat(title),
                message = colorformat(message),
                icon = "fa-solid fa-bell",
            })
        else
            SendNUIMessage({
                action = "notify_js",
                duration = duration or 3000,
                title = colorformat(title),
                message = colorformat(message),
                icon = icon,
            })
        end

    --PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    PlaySoundFrontend(-1, "DELETE", "HUD_DEATHMATCH_SOUNDSET", 1)
end

RegisterNetEvent('hud:notify')
AddEventHandler('hud:notify', function(duration, title, message, icon, bg)
    notify(title,message,duration,icon,bg)
end)


Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, true)
	SetRadarZoom(1200)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
		SetRadarBigmapEnabled(false, true)
		SetRadarZoom(1200)
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)

local directions = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"}

function StartHud()
    print("^7[^3HUD^7] Wystartowano HUD")
    SendNUIMessage({
        action = 'showhud',
    })
    Citizen.CreateThread(function()
        while true do 
            TriggerEvent('esx_status:getStatus', 'hunger', function(status)
                hunger = status.getPercent()
            end)
            TriggerEvent('esx_status:getStatus', 'thirst', function(status)
                thirst = status.getPercent()
            end)

            local mode = Player(GetPlayerServerId(PlayerId())).state.proximity.mode

            local voicedist = 0
            if mode == "Whisper" then
                voicedist = 25
            elseif mode == "Normal" then
                voicedist = 50
            elseif mode == "Shouting" then
                voicedist = 100
            end



            local armor = (GetPedArmour(PlayerPedId()))
            local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()) 
            local healthPercent = (GetEntityHealth(PlayerPedId()) / 200) * 100
            local staminaPercent = (stamina / 100) * 100
            SendNUIMessage({
                action = "update",
                jedzenie = hunger,
                woda = thirst,
                zycie = healthPercent,
                zmeczenie = staminaPercent,
                voice = voicedist,
                backpack = 0,
                kamza = armor,
            })
            Citizen.Wait(200)
        end
    end)
end

RegisterNetEvent("blowrp_hud:setTalkingIcon")
AddEventHandler("blowrp_hud:setTalkingIcon", function(icon)
    SendNUIMessage({
        action = 'toggleSpeakingIcon',
        icon = icon
    }) 
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(250)
        local voiceline = NetworkIsPlayerTalking(PlayerId())
        local voicestatus = false

        if voiceline == 1 then
            voicestatus = true
        else
            voicestatus = false
        end

        SendNUIMessage({
            action = 'toggleSpeaking',
            toggle = voicestatus,
        }) 
    end
end)

lib.onCache('vehicle', function(value)
    if value then
        inVeh = true
        StartLoop()
    else
        inVeh = false
        SendNUIMessage({
            action = 'HideCarHud'
        })
        DisplayRadar(false)
    end
end)


function StartLoop()
    Citizen.CreateThread(function()
        while inVeh do
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local pedCar = GetVehiclePedIsUsing(playerPed, false)
            local speed = math.floor(GetEntitySpeed(pedCar) * 3.6)
            local street = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            local fuel = GetVehicleFuelLevel(pedCar)

            local waypointBlip = GetFirstBlipInfoId(8)
            local distanceToWaypoint = 0

            if waypointBlip ~= 0 then
                local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())
                distanceToWaypoint = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, coord.x, coord.y, coord.z, true)
            end

            local distanceToWaypointKM = tonumber(string.format("%.1f", distanceToWaypoint / 1000))

            local heading = 360.0 - ((GetGameplayCamRot(0).z + 360.0) % 360.0)
            SendNUIMessage({
                action = 'UpdateCarHud',
                speed = speed,
                street = GetStreetNameFromHashKey(street),
                direction = Direction(heading),
                fuel = fuel,
                distanceToWaypoint = distanceToWaypointKM  -- Add distance to waypoint in kilometers with one decimal place
            })

            DisplayRadar(true)
            Citizen.Wait(100)
        end
    end)
end





function Direction(heading)
    return directions[(math.floor((heading / 45) + 0.5) % 8) + 1];
end

--[[
RegisterCommand("hud", function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "ToggleSettings",
    })
end)
]]

RegisterCommand("showhud", function()
    SendNUIMessage({
        action = 'showhud',
    })
end, false)


RegisterCommand("hidehud", function()
    SendNUIMessage({
        action = 'hidehud',
    })
end, false)



function colorformat(text)
	for i = 1, #kolorki do
		for k = 1, #kolorki[i][1] do
			text = string.gsub(text, kolorki[i][1][k], kolorki[i][2])
		end
	end
	return text
end

kolorki = {
	{
		{"~Q~", "~q~", "~w~", "~W~", "~s~", "~S~", "~c~", "~C~", "~r~", "~R~", "~g~", "~G~", "~b~", "~B~", "~y~", "~Y~", "~p~", "~P~", "~m~", "~M~", "~u~", "~U~", "~o~", "~O~"},
		'<span style="color: #ffffff;">',
	},
}

--[[ HIDECOMPONENTS ]]


