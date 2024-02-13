local UseKey = true
local vehicles = {}; RPWorking = true


local silnik = false
RegisterCommand('+Silnik', function()
    silnik = true
end, false)
RegisterCommand('-Silnik', function()
    silnik = false
end, false)
RegisterKeyMapping('+Silnik', 'Silnik', 'keyboard', 'y')


RegisterNetEvent('EngineToggle:Engine')
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			if UseKey and silnik then
				if silnik then
					letsleep = false
					TriggerEvent('EngineToggle:Engine')
					Wait(250)
				end
			end

			if GetSeatPedIsTryingToEnter(PlayerPedId()) == -1 and not table.contains(vehicles, GetVehiclePedIsTryingToEnter(PlayerPedId())) then
				table.insert(vehicles, {GetVehiclePedIsTryingToEnter(PlayerPedId()), IsVehicleEngineOn(GetVehiclePedIsTryingToEnter(PlayerPedId()))})
			elseif IsPedInAnyVehicle(PlayerPedId(), false) and not table.contains(vehicles, GetVehiclePedIsIn(PlayerPedId(), false)) then
				table.insert(vehicles, {GetVehiclePedIsIn(PlayerPedId(), false), IsVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false))})
			end

			for i, vehicle in ipairs(vehicles) do
				if DoesEntityExist(vehicle[1]) then
					if (GetPedInVehicleSeat(vehicle[1], -1) == PlayerPedId()) or IsVehicleSeatFree(vehicle[1], -1) then
						if RPWorking then
							SetVehicleEngineOn(vehicle[1], vehicle[2], false, false)
							SetVehicleJetEngineOn(vehicle[1], vehicle[2])
							if not IsPedInAnyVehicle(PlayerPedId(), false) or (IsPedInAnyVehicle(PlayerPedId(), false) and vehicle[1]~= GetVehiclePedIsIn(PlayerPedId(), false)) then
								if IsThisModelAHeli(GetEntityModel(vehicle[1])) or IsThisModelAPlane(GetEntityModel(vehicle[1])) then
									if vehicle[2] then
										SetHeliBladesFullSpeed(vehicle[1])
									end
								end
							end
						end
					end
				else
					table.remove(vehicles, i)
				end
			end
			if letsleep then
				Citizen.Wait(2000)
				letsleep = true
			end
		else
			letsleep = false
		end
	end
end)

AddEventHandler('EngineToggle:Engine', function()
	local veh
	local StateIndex
	local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player, false)
	local vehicleClass = GetVehicleClass(vehicle)
	for i, vehicle in ipairs(vehicles) do
		if vehicle[1] == GetVehiclePedIsIn(PlayerPedId(), false) then
			veh = vehicle[1]
			StateIndex = i
		end
	end
	Citizen.Wait(500)
	if IsPedInAnyVehicle(PlayerPedId(), false) then 
		if (GetPedInVehicleSeat(veh, -1) == PlayerPedId()) then
			if vehicleClass ~= 13 then
			vehicles[StateIndex][2] = not GetIsVehicleEngineRunning(veh)
				if vehicles[StateIndex][2] then
                    SendNUIMessage({
                        action = "UpdateEngine",
                        engine = false
                    })
					TriggerEvent("hud:notify", 3000,"SILNIK","Włączono Silnik", "fa-solid fa-car", "158, 21, 21")

				else
                    SendNUIMessage({
                        action = "UpdateEngine",
                        engine = true
                    })
					TriggerEvent("hud:notify", 3000,"SILNIK","Wyłączono Silnik", "fa-solid fa-car", "158, 21, 21")

				end
			end
		end 
    end 
end)

function table.contains(table, element)
    for _, value in pairs(table) do
      if value[1] == element then
        return true
      end
    end
    return false
  end