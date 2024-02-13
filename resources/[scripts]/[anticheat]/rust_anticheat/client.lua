local Rust = {}

function Rust:Ban()
    TriggerServerEvent("Rust:banself")
end
function Rust:Kick()
    TriggerServerEvent("Rust:kickself")
end



CreateThread(function()
    while true do
            if IsPedInAnyVehicle(PlayerPedId(), false) or IsPedFalling(PlayerPedId()) then
                SetPedCanRagdoll(PlayerPedId(), true)
            Wait(10000)
            else
                SetPedCanRagdoll(PlayerPedId(), false)
            end
            Wait(100)
        end
     end)

CreateThread(function ()

    while true do
        local playerPed = PlayerPedId()
        local doesPlayerExist = DoesEntityExist(playerPed)
        local isPlayerInVehicle = IsPedInAnyVehicle(playerPed, false)
        local isPlayerSwitchInProgress = IsPlayerSwitchInProgress()
        local isCameraControlDisabled = IsPlayerCamControlDisabled()

        Wait(200)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(tonumber(2500))
        local spec = NetworkIsInSpectatorMode()
        if spec == 1 then
            Rust:Ban()
        end
    end
end)

CreateThread(function ()
    local t_d = 0
    while true do
        if t_d >= 10 then
            Rust:Ban()
        end

        local playerId      = PlayerId()
        local playerPed     = GetPlayerPed(-1)
        local health        = GetEntityHealth(playerPed)

        if (health > 200) then
            Rust:Ban()
        end

        SetPlayerHealthRechargeMultiplier(playerId, 0.0)
        SetEntityHealth(playerPed, health - 2)
        Wait(50)

        if (GetEntityHealth(playerPed) > (health - 2)) then
            t_d = t_d + 1
        elseif(t_d > 0) then
            t_d = t_d - 1
        end

        SetEntityHealth(playerPed, GetEntityHealth(playerPed) + 2)
    end
end)


AddEventHandler("gameEventTriggered", function(name, args)
    if name == 'CEventNetworkEntityDamage' then
        if args[2] == -1 and args[5] == tonumber(-842959696) then
            Rust:Ban()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(tonumber(2000))
    local DetectableTextures = {
    {txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu"},
    {txd = "John", txt = "John2", name = "SugarMenu"},
    {txd = "darkside", txt = "logo", name = "Darkside"},
    {txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU"},
    {txd = "dopatest", txt = "duiTex", name = "Copypaste Menu"},
    {txd = "fm", txt = "menu_bg", name = "Fallout Menu"},
    {txd = "wave", txt = "logo", name ="Wave"},
    {txd = "wave1", txt = "logo1", name = "Wave (alt.)"},
    {txd = "meow2", txt = "woof2", name ="Alokas66", x = 1000, y = 1000},
    {txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86", txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6", name ="Guest Menu"},
    {txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name="HugeV Menu"},
    {txd = "MM", txt = "menu_bg", name="Metrix Mehtods"},
    {txd = "wm", txt = "wm2", name="WM Menu"},
    {txd = "NeekerMan", txt="NeekerMan1", name="Lumia Menu"},
    {txd = "Blood-X", txt="Blood-X", name="Blood-X Menu"},
    {txd = "Dopamine", txt="Dopameme", name="Dopamine Menu"},
    {txd = "Fallout", txt="FalloutMenu", name="Fallout Menu"},
    {txd = "Luxmenu", txt="Lux meme", name="LuxMenu"},
    {txd = "Reaper", txt="reaper", name="Reaper Menu"},
    {txd = "absoluteeulen", txt="Absolut", name="Absolut Menu"},
    {txd = "KekHack", txt="kekhack", name="KekHack Menu"},
    {txd = "Maestro", txt="maestro", name="Maestro Menu"},
    {txd = "SkidMenu", txt="skidmenu", name="Skid Menu"},
    {txd = "Brutan", txt="brutan", name="Brutan Menu"},
    {txd = "FiveSense", txt="fivesense", name="Fivesense Menu"},
    {txd = "NeekerMan", txt="NeekerMan1", name="Lumia Menu"},
    {txd = "Auttaja", txt="auttaja", name="Auttaja Menu"},
    {txd = "BartowMenu", txt="bartowmenu", name="Bartow Menu"},
    {txd = "Hoax", txt="hoaxmenu", name="Hoax Menu"},
    {txd = "FendinX", txt="fendin", name="Fendinx Menu"},
    {txd = "Hammenu", txt="Ham", name="Ham Menu"},
    {txd = "Lynxmenu", txt="Lynx", name="Lynx Menu"},
    {txd = "Oblivious", txt="oblivious", name="Oblivious Menu"},
    {txd = "malossimenuv", txt="malossimenu", name="Malossi Menu"},
    {txd = "memeeee", txt="Memeeee", name="Memeeee Menu"},
    {txd = "tiago", txt="Tiago", name="Tiago Menu"},
    {txd = "Hydramenu", txt="hydramenu", name="Hydra Menu"},
    {txd = "Hydramenu", txt="hydramenu", name="Hydra Menu"},
    {txd = "Terror", txt="Terror Menu", name="Terror Menu"}
    
    }
    
    for i, data in pairs(DetectableTextures) do
    if data.x and data.y then
    if GetTextureResolution(data.txd, data.txt).x == data.x and GetTextureResolution(data.txd, data.txt).y == data.y then
        Rust:Ban()
    end
    else 
    if GetTextureResolution(data.txd, data.txt).x ~= 4.0 then
        Rust:Ban()
    end 
    end
    end
    end
    end)