
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(250)
        SendNUIMessage({
            action = 'ToggleRadioList',
            toggle = false
        })    
	end
end)

Citizen.CreateThread(function() 
    while true do
        local channel = exports['pma-voice']:GetRadioChannel()
        local count = exports['pma-voice']:GetRadioCount()
        if tostring(channel) == "0" then
            sleep = 1500
            SendNUIMessage({
                action = 'ToggleRadioList',
                toggle = false
            })    
        else
            sleep = 500
            SendNUIMessage({
                action = 'ToggleRadioList',
                toggle = true
            }) 
        end    
        Citizen.Wait(sleep)
    end
end)
