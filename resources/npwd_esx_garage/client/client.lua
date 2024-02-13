ESX = exports["es_extended"]:getSharedObject()



RegisterNUICallback("npwd:esx-garage:getVehicles", function(_, cb)
	TriggerServerEvent("npwd:esx-garage:getVehicles")
	RegisterNetEvent("npwd:esx-garage:sendVehicles", function(vehicles)
		for _, v in pairs(vehicles) do
			local type = GetVehicleClassFromName(v.model)
			if type == 15 or type == 16 then
				v.type = "aircraft"
			elseif type == 14 then
				v.type = "boat"
			elseif type == 13 or type == 8 then
				v.type = "bike"
			else
				v.type = "car"
			end
		end

		cb({ status = "ok", data = vehicles })
	end)
end)

RegisterNUICallback("npwd:esx-garage:requestWaypoint", function(data, cb)
	local plate = data.plate
	local state = data.state
	cb({})
end)