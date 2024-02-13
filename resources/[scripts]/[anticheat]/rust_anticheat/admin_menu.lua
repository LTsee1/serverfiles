--- MenuV Menu
---@type Menu
local menu = MenuV:CreateMenu(false, 'Welcome to MenuV', 'topleft', 255, 0, 0, 'size-125', 'example', 'menuv', 'example_namespace')

local menu_button = menu:AddButton({ icon = '😃', label = 'Open Demo 2 Menu', value = menu, description = 'YEA :D from first menu' })

--- Events


menu:OpenWith('KEYBOARD', 'F11') -- Press F1 to open Menu