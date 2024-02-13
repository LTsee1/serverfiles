
ESX = exports['es_extended']:getSharedObject()
local ox_inventory = exports['ox_inventory']

ESX.RegisterServerCallback("base:hasphone",function(source,cb)
    local phone_count = ox_inventory:GetItem(source, 'water', nil, true)
    if phone_count > 0 then
        cb(true)
    else
        cb(false) 
    end
end)