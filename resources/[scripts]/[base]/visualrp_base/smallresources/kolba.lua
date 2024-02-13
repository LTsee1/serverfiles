local p = lib.cache('ped')

lib.onCache('ped', function(value)
    p = value
end)

lib.onCache("weapon",function(value)
    lib.disableControls:Add({
        140,
        141,
        142
    })
end)
