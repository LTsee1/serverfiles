lib.onCache('ped', function(value)
    SetPedConfigFlag(value, 241, true) -- PED_FLAG_DISABLE_STOPPING_VEHICLE_ENGINE
    SetPedConfigFlag(value, 429, true) -- PED_FLAG_DISABLE_STARTING_VEHICLE_ENGINE
  end)
  
  lib.addKeybind({
      name = 'engine',
      description = 'Engine',
      defaultKey = 'Y',
      onPressed = function(self)
        if not cache.vehicle then
          return
        end
  
        if not cache.seat then
          return
        end
  
        if GetVehicleClass(cache.vehicle) == 13 then
          return
        end
  
        SetVehicleEngineOn(cache.vehicle, not GetIsVehicleEngineRunning(cache.vehicle), false, true)
      end
  })