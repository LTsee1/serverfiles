local vehicles = {}

MySQL.ready(function()
	vehicles = MySQL.Sync.fetchAll('SELECT * FROM vehicles')
end)

RegisterServerEvent('waitrp_vehicleshop:requestInfo')
AddEventHandler('waitrp_vehicleshop:requestInfo', function()
    local _source = source
    TriggerClientEvent("waitrp_vehicleshop:vehiclesInfos", _source , vehicles)
    TriggerClientEvent("esx:showNotification", _source, 'Użyj A oraz D aby obwrócić pojazd')
end)

ESX.RegisterServerCallback('waitrp_vehicleshop:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('waitrp_vehicleshop:CheckMoneyForVeh')
AddEventHandler('waitrp_vehicleshop:CheckMoneyForVeh', function(vehicle, price, name, vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        local vehicleModel = vehicle
        local vehiclePrice = price
        if xPlayer.getAccount('bank').money >= tonumber(vehiclePrice) then
            xPlayer.removeAccountMoney('bank', tonumber(vehiclePrice))
            --exports['wait_logs']:SendLog(_source, 'VEHICLESHOP: `'..GetPlayerName(xPlayer.source)..'` ZAKUPIŁ POJAZD `'..vehicleModel..'` za `'..tonumber(vehiclePrice)..'`', 'nowe-napadyinne')
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
                ['@owner'] = xPlayer.identifier,
                ['@plate'] = vehicleProps.plate,
                ['@vehicle'] = json.encode(vehicleProps),
            }, function(rowsChanged)
                TriggerClientEvent("waitrp_vehicleshop:sussessbuy", _source, name, vehicleProps.plate, vehiclePrice)
                TriggerClientEvent('waitrp_vehicleshop:spawnVehicle', _source, vehicleModel, vehicleProps.plate)
                TriggerClientEvent('ls:dodajklucze2', _source, tostring(string.lower(vehicleProps.plate)))
            end)
        else
            TriggerClientEvent("esx:showNotification", _source, 'Nie posiadasz wystarczająco pieniędzy!')
        end
    end
end)

ESX.RegisterServerCallback('waitrp_vehicleshop:resellVehicle', function (source, cb, plate, model, auto, resellPrice)
    if resellPrice ~= 0 then
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = plate
        }, function(result)
            if result[1] then
                local vehicle = json.decode(result[1].vehicle)
                if vehicle.model == model then
                    if vehicle.plate == plate then
                        xPlayer.addAccountMoney('bank', tonumber(resellPrice))
                        MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
                            ['@plate'] = plate
                        })
                        TriggerClientEvent('esx:showNotification', _source, 'Sprzedałeś pojazd '..plate..' za '..resellPrice..'$')
                        --exports['wait_logs']:SendLog(_source, "```LOKALNA SPRZEDAŻ AUTA```\nSprzedał: `" ..auto.. "`\nRejestracja: `"..plate.."` \nCena: `"..resellPrice.."`", 'contract')
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            else
                cb(false)
            end
        end)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('waitrp_vehicleshop:getResellPrice', function (source, cb, model)
    local resellPrice = 0
    for i=1, #vehicles, 1 do
        if joaat(vehicles[i].model) == model then
            resellPrice = ESX.Math.Round(vehicles[i].price / 100 * 70)
            break
        end
    end
    cb(resellPrice)
end)

AddEventHandler('playerDropped', function()
	TriggerClientEvent('waitrp_vehicleshop:checkRentCar', source)
end)