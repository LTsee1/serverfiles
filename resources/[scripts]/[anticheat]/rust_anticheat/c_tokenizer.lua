function InstallTokenizer(resource_name)

    local s = 'local token = nil RegisterNetEvent("%s-token") AddEventHandler("%s-token",function(t)  for _,i in pairs(t) do token = i end print("works") end)'
    s = string.format(s,resource_name,resource_name)
    return s
end

exports("InstallTokenizer",InstallTokenizer)