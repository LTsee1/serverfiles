local token = nil 
RegisterNetEvent("test_script-token")
AddEventHandler("test_script-token",function(t)
      for _,i in pairs(t) do
        token = i
      end
      print(token)
end)