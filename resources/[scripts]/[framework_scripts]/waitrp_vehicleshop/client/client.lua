local lastSelectedVehicleEntity
local startCountDown
local testDriveEntity
local lastPlayerCoords
local inTheShop = false


Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-32.04, -1097.46, 27.27)
    SetBlipSprite(blip, 326)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Car Dealer')
    EndTextCommandSetBlipName(blip)


    exports.qtarget:AddBoxZone('vehicleshop', vector3(-56.947, -1097.145, 25.422), 1.4, 5.6, {
        name = 'vehicleshop',
        heading = 253.0,
        debugPoly = false,
        minZ = 26.27,
        maxZ = 27.57,
    }, {
        options = {
            {
                icon = "fas fa-car",
                label = "Przejrzyj pojazdy",
                action = function(data)
                    OpenVehicleShop()
                end,
            },
        },
        distance = 1.5
    })
end)

RegisterNetEvent('waitrp_vehicleshop:sussessbuy')
AddEventHandler('waitrp_vehicleshop:sussessbuy', function(vehicleName, vehiclePlate, value)
    SendNUIMessage({
        type = "sussess-buy",
        vehicleName = vehicleName,
        vehiclePlate = vehiclePlate,
        value = value
    })
    CloseNui()
end)

local vehiclesTable = {}
local provisoryObject = {}

RegisterNetEvent('waitrp_vehicleshop:vehiclesInfos')
AddEventHandler('waitrp_vehicleshop:vehiclesInfos', function(tableVehicles)
    for _, value in pairs(tableVehicles) do
        vehiclesTable[value.category] = {}
    end
    for _, value in pairs(tableVehicles) do
        local vehicleModel = joaat(value.model)
        local brandName = GetLabelText(GetMakeNameFromVehicleModel(vehicleModel))
        provisoryObject = {
            brand = brandName,
            name = value.name,
            price = value.price,
            model = value.model
        }
        vehiclesTable[value.category][#vehiclesTable[value.category] + 1] = provisoryObject
    end
end)

function OpenVehicleShop()
    inTheShop = true
    local ped = PlayerPedId()
    TriggerServerEvent("waitrp_vehicleshop:requestInfo")
    Citizen.Wait(500)
    SendNUIMessage({
        data = vehiclesTable,
        type = "display"
    })
    SetNuiFocus(true, true)
    RequestCollisionAtCoord(x, y, z)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",-46.631, -1091.193, 27.422, -10.0, 0.0, 170.0, 40.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1, true, true)
    SetFocusPosAndVel(-46.86, -1085.10, 28.27, 295.5, 0.0, 0.0)
    if lastSelectedVehicleEntity ~= nil then
        DeleteEntity(lastSelectedVehicleEntity)
    end
end

function updateSelectedVehicle(model)
    local hash = joaat(model)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    if lastSelectedVehicleEntity ~= nil then
        DeleteEntity(lastSelectedVehicleEntity)
    end

    lastSelectedVehicleEntity = CreateVehicle(hash, -46.898, -1097.091, 26.422, 189.914, false, false)
    local vehicleData = {}
    vehicleData.traction = GetVehicleMaxTraction(lastSelectedVehicleEntity)
    vehicleData.breaking = GetVehicleMaxBraking(lastSelectedVehicleEntity) * 0.9650553
    if vehicleData.breaking >= 1.0 then
        vehicleData.breaking = 1.0
    end
    vehicleData.maxSpeed = GetVehicleEstimatedMaxSpeed(lastSelectedVehicleEntity) * 0.9650553
    if vehicleData.maxSpeed >= 50.0 then
        vehicleData.maxSpeed = 50.0
    end
    vehicleData.acceleration = GetVehicleAcceleration(lastSelectedVehicleEntity) * 2.6
    if  vehicleData.acceleration >= 1.0 then
        vehicleData.acceleration = 1.0
    end
    SendNUIMessage({
        data = vehicleData,
        type = "updateVehicleInfos",
    })
    SetEntityHeading(lastSelectedVehicleEntity, 295.5)
end

function rotation(dir)
    local entityRot = GetEntityHeading(lastSelectedVehicleEntity) + dir
    SetEntityHeading(lastSelectedVehicleEntity, entityRot % 360)
end

RegisterNUICallback("rotate", function(data, cb)
    if (data["key"] == "left") then
        rotation(2)
    else
        rotation(-2)
    end
    cb("ok")
end)

RegisterNUICallback("SpawnVehicle", function(data, cb)
    updateSelectedVehicle(data.modelcar)
end)

RegisterNUICallback("Buy", function(data, cb)
    local newPlate = GeneratePlate()
    local vehicleProps = ESX.Game.GetVehicleProperties(lastSelectedVehicleEntity)
    vehicleProps.plate = newPlate
    TriggerServerEvent('waitrp_vehicleshop:CheckMoneyForVeh', data.modelcar, data.sale, data.name, vehicleProps)
    Citizen.Wait(1500)
end)

RegisterNetEvent('waitrp_vehicleshop:spawnVehicle')
AddEventHandler('waitrp_vehicleshop:spawnVehicle', function(model, plate)
    local hash = joaat(model)
    lastPlayerCoords = GetEntityCoords(PlayerPedId())
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    local vehicleBuy = CreateVehicle(hash, -11.87, -1080.87, 25.71, 132.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    SetVehicleNumberPlateText(vehicleBuy, plate)
end)

RegisterNUICallback("TestDrive", function(data, cb)
    startCountDown = true
    local hash = joaat(data.vehicleModel)
    lastPlayerCoords = GetEntityCoords(PlayerPedId())
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    if testDriveEntity ~= nil then
        DeleteEntity(testDriveEntity)
    end
    testDriveEntity = CreateVehicle(hash, -11.87, -1080.87, 25.71, 132.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), testDriveEntity, -1)
    local timeGG = GetGameTimer()
    CloseNui()
    while startCountDown do
        local countTime
        if GetGameTimer() < timeGG + tonumber(1000 * Config.TestDriveTime) then
            local secondsLeft = GetGameTimer() - timeGG
            drawTxt('Jazda testowa: ' .. math.ceil(Config.TestDriveTime - secondsLeft/1000), 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
        else
            DeleteEntity(testDriveEntity)
            SetEntityCoords(PlayerPedId(), lastPlayerCoords)
            startCountDown = false
        end
        Citizen.Wait(0)
    end
    -- dodane
    DeleteEntity(testDriveEntity)
end)

RegisterNUICallback("menuSelected", function(data, cb)
    local categoryVehicles
    local playerIdx = GetPlayerFromServerId(source)
    local ped = GetPlayerPed(playerIdx)
    if data.menuId ~= 'all' then
        categoryVehicles = vehiclesTable[data.menuId]
    else
        SendNUIMessage({
            data = vehiclesTable,
            type = "display",
            playerName = GetPlayerName(ped)
        })
        return
    end
    SendNUIMessage({
        data = categoryVehicles,
        type = "menu"
    })
end)

RegisterNUICallback("Close", function(data, cb)
    CloseNui()
end)

function CloseNui()
    SendNUIMessage({
        type = "hide"
    })
    SetNuiFocus(false, false)
    if inTheShop then
        if lastSelectedVehicleEntity ~= nil then
            DeleteVehicle(lastSelectedVehicleEntity)
        end
        RenderScriptCams(false)
        DestroyAllCams(true)
        SetFocusEntity(GetPlayerPed(PlayerId())) 
        DisplayHud(true)
        DisplayRadar(true)
    end
    inTheShop = false
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CloseNui()
        RemoveBlip(blip)
    end
end)

RegisterNetEvent('waitrp_vehicleshop:checkRentCar')
AddEventHandler('waitrp_vehicleshop:checkRentCar', function()
    if testDriveEntity ~= nil then
        DeleteEntity(testDriveEntity)
    end
end)