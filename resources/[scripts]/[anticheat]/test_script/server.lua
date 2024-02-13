local tokenizer = Rust_tokenizer.new()
local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent("testscript:spawnmoney")
AddEventHandler("testscript:spawnmoney",function(token)
    local plr = source
    if not tokenizer:IsTokenValid(plr,token) then
        return
    end

end)