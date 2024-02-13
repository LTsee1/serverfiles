local playerServerID = GetPlayerServerId(PlayerId())
local playersInRadio, currentRadioChannel, currentRadioChannelName = {}, nil, nil
local allowedToSeeRadioList, radioListVisibility = true, true
local temporaryName = "temporaryPlayerNameAsAWorkaroundForABugInPMA-VOICEWhichEventsGetCalledTwiceWhileThePlayerConnectsToTheRadioForFirstTime"


local function modifyTheRadioListVisibility(state)
    SendNUIMessage({ changeVisibility = true, visible = allowedToSeeRadioList})
end

local function closeTheRadioList()
    playersInRadio, currentRadioChannel, currentRadioChannelName = {}, nil, nil
    SendNUIMessage({ clearRadioList = true })
    modifyTheRadioListVisibility(false)
end

local function addServerIdToPlayerName(serverId, playerName)
    if Config.ShowPlayersServerIdNextToTheirName then
        if Config.PlayerServerIdPosition == "left" then playerName = ("%s) %s"):format(serverId, playerName)
        elseif Config.PlayerServerIdPosition == "right" then playerName = ("%s (%s"):format(playerName, serverId) end
    end
    return playerName
end

local function addPlayerToTheRadioList(playerId, playerName)
    if playersInRadio[playerId] then return end
    playersInRadio[playerId] = temporaryName
    playersInRadio[playerId] = addServerIdToPlayerName(playerId, playerName or Player(playerId).state[Shared.State.nameInRadio] or callback.await(Shared.Callback.getPlayerName, false, playerId))
    SendNUIMessage({ self = playerId == playerServerID, radioId = playerId, radioName = playersInRadio[playerId], channel = currentRadioChannelName })
end

local function removePlayerFromTheRadioList(playerId)
    if not playersInRadio[playerId] then return end
    if playersInRadio[playerId] == temporaryName then return end
    if playerId == playerServerID then closeTheRadioList() return end
    playersInRadio[playerId] = nil
    SendNUIMessage({ radioId = playerId })
end

RegisterNetEvent("pma-voice:addPlayerToRadio", function(playerId)
    if not currentRadioChannel or not (currentRadioChannel > 0) then return end
    addPlayerToTheRadioList(playerId)
end)

RegisterNetEvent("pma-voice:removePlayerFromRadio", function(playerId)
    if not currentRadioChannel or not (currentRadioChannel > 0) then return end
    removePlayerFromTheRadioList(playerId)
end)

RegisterNetEvent("pma-voice:syncRadioData", function()
    closeTheRadioList()
    local _playersInRadio
    _playersInRadio, currentRadioChannel, currentRadioChannelName = callback.await(Shared.Callback.getPlayersInRadio, false)
    for playerId, playerName in pairs(_playersInRadio) do
        addPlayerToTheRadioList(playerId, playerName)
    end
    _playersInRadio = nil
end)

RegisterNetEvent("pma-voice:radioActive")
AddEventHandler("pma-voice:radioActive", function(talkingState)
    SendNUIMessage({ radioId = playerServerID, radioTalking = talkingState })
end)

RegisterNetEvent("pma-voice:setTalkingOnRadio")
AddEventHandler("pma-voice:setTalkingOnRadio", function(source, talkingState)
    SendNUIMessage({ radioId = source, radioTalking = talkingState })
end)

AddStateBagChangeHandler(Shared.State.allowedToSeeRadioList, ("player:%s"):format(playerServerID), function(bagName, key, value)
    local receivedPlayerServerId = tonumber(bagName:gsub('player:', ''), 10)
    if not receivedPlayerServerId or receivedPlayerServerId ~= playerServerID then return end
    allowedToSeeRadioList = (value == nil and false) or value
    modifyTheRadioListVisibility(radioListVisibility)
end)
