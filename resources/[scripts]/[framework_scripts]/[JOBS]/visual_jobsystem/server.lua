ESX = exports["es_extended"]:getSharedObject()


local groups = {}

local invites = {}


function PlayerJoinToGroup(target,group)

end


function PlayerRemoveFromGroup(target,groupid)
    local group = groups[groupid]
    
    if not group then
        return
    end

    local memberingroup = groups[groupid].members[target]

    if not memberingroup then
        return
    end

    groups[groupid].members[target] = nil
    local xplayer = ESX.GetPlayerFromId(target)
  xplayer.showNotification('Zostałeś wyrzucony z grupy pracy #'..groupid)

end

local function getrandomid()
    local newid = math.random(10000,99999)
    if invites[newid] then
        return getrandomid()
    end
    return newid
end

function CreateInvite(owner,target)   
    local group = groups[owner]
    if not group then return end
    --[[
    if IsPlayerInGroup(target) then
        local xplayer = ESX.GetPlayerFromId(owner)
        xplayer.showNotification('Ten uzytkownik jest aktualnie w grupie pracy')
        return 
    end]]

    local inviteID = getrandomid()
    
    local newInvite = {
        groupid = group.groupid,
        inviteTime = os.time(),
    }
    
    invites[inviteID] = newInvite
    local xplayer = ESX.GetPlayerFromId(target)
    xplayer.showNotification('Zostałeś zaproszony do grupy pracy #'..group.groupid)

    TriggerClientEvent("v-jobsystem:ReceiveInvitation",target,{
        groupid = group.groupid,
        inviteTime = newInvite.inviteTime,
        inviteID = inviteID
    })
    print(ESX.DumpTable(invites))

end

function ChangePlayerPercentInGroup(owner,target,newPercent)
        
end




function CreateGroup(owner)
    -- if exists then returns 
    if  groups[owner] then
        return
    end
    -- new group
    groups[owner] = {
        groupid = owner,
        members = {
            -- @key -- player id
            [owner] = {
                rank = 'owner',
                label = 'User: '.. owner,
                percent = 100,
            }
        }
    }
    print(ESX.DumpTable(groups[owner]))
 
 
end



function RemoveGroup(owner)
    -- group exists?
    local group = groups[owner]
    if  not group then
        return
    end
    
    
    for id,userData in pairs(group) do
        ESX.ShowNotification(id,'Grupa pracy #'..owner.." została usunięta")
    end
    
end


function IsPlayerInGroup(plr)
    -- if owner of group then return true
    if groups[plr] then
        return true, plr
    end
    -- is not owner of group then we find him in groups
    for groupid,groupdata in pairs(groups) do
        for memberid,memberdata in pairs(groupdata.members) do
            if memberid == plr then
                return true, groupid
            end
        end
    end
    
    return false
end

-- Owner of group leaves the game
AddEventHandler('playerDropped', function (reason)
    local owner = source
    --  exists?
    if groups[owner] then
        RemoveGroup(owner)
    end

    local plrGroup,groupid = IsPlayerInGroup(owner)

    if plrGroup then
        PlayerRemoveFromGroup(owner,groupid)
    end
        
end)

RegisterNetEvent("v-jobsystem:AcceptedInvitation")
AddEventHandler("v-jobsystem:AcceptedInvitation",function(invitationData)
    local src = source
    local xplayer = ESX.GetPlayerFromId(src)
    -- invite exists?
    if not invites[invitationData.inviteID] then
        xplayer.showNotification('Te zaproszenie do grupy pracy nie istnieje')
        return
    end

    -- expired invite?
    if os.time()- invitationData.inviteTime >= 10 then
        invites[invitationData.inviteID] = nil
        xplayer.showNotification('Te zaproszenie do grupy pracy jest już nieważne')
        return
    end

    PlayerJoinToGroup(src,invitationData.groupid)
    xplayer.showNotification('Zakceptowales zaproszenie')
end)



exports("CreateGroup",CreateGroup)
exports("RemoveGroup",RemoveGroup)
exports("IsPlayerInGroup",IsPlayerInGroup)

exports("CreateInvite",CreateInvite)
