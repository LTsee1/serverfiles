---@alias NotificationPosition 'top' | 'top-right' | 'top-left' | 'bottom' | 'bottom-right' | 'bottom-left' | 'center-right' | 'center-left'
---@alias NotificationType 'info' | 'warning' | 'success' | 'error'

---@class NotifyProps
---@field id? string
---@field title? string
---@field description? string
---@field duration? number
---@field position? NotificationPosition
---@field type? NotificationType
---@field style? { [string]: any }
---@field icon? string | {[1]: IconProp, [2]: string};
---@field iconColor? string;
---@field alignIcon? 'top' | 'center';

---`client`
---@param data NotifyProps
---@diagnostic disable-next-line: duplicate-set-field

function lib.notify(data)
       -- SendNUIMessage({
       --     action = 'notify',
      --      data = data
       -- })

      local title = false
      local titleText = data.title
      if not data.title then
        titleText = data.description
        data.description = nil
      end
    exports['visual_hud']:notify(titleText,data.description or "",data.duration,data.icon)

end

---@class DefaultNotifyProps
---@field title? string
---@field description? string
---@field duration? number
---@field position? NotificationPosition
---@field status? 'info' | 'warning' | 'success' | 'error'
---@field id? number

---@param data DefaultNotifyProps
function lib.defaultNotify(data)
    -- Backwards compat for v3
    data.type = data.status
    if data.type == 'inform' then data.type = 'info' end
    return lib.notify(data --[[@as NotifyProps]])
end

RegisterNetEvent('ox_lib:notify', lib.notify)
RegisterNetEvent('ox_lib:defaultNotify', lib.defaultNotify)
