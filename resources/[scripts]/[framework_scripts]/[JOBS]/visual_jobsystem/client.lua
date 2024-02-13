ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("v-jobsystem:ReceiveInvitation")
AddEventHandler("v-jobsystem:ReceiveInvitation", function(inviteData)
    exports["npwd"]:createSystemNotification({
        uniqId = "v-jobsystem:invitenotify"..inviteData.groupid,
        content = "Zostałeś zaproszony do grupy pracy #"..inviteData.groupid,
        secondaryTitle = "SYSTEM",
        keepOpen = true,
        duration = 5000,
        controls = true,
        onConfirm = function()
         TriggerServerEvent("v-jobsystem:AcceptedInvitation",inviteData)
        end,
        onCancel = function()
          print("declined")
        end,
      })
end)

