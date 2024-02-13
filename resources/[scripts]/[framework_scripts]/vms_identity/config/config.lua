Config                  = {}

Config.MaxNameLength = 20 -- Max Name Length.
Config.LimitHeight = {120, 220} -- minimum and maximum
Config.LimitYear = {1900, 2023} -- minimum and maximum

Config.EnableBlur = true

Config.Multichars = true
Config.UseCustomSkinCreator = false -- If you want this you must set Config.Multichars = false 

Config.Notification = function(title, message, type)
	if type == "Sukces" then
		TriggerEvent('esx:showNotification', message)
		
	elseif type == "Błąd" then
		TriggerEvent('esx:showNotification', message)
		
	elseif type == "Info" then
		TriggerEvent('esx:showNotification', message)
		
	end
end

Config.Translate = {
	['cmd.opened_register'] = 'Otworzono menu rejestracji graczowi %s',
	['cmd.help_id'] = 'id',
	['cmd.help_register'] = 'Otwórz menu rejestracji gracza',

	['register_notify'] = 'Rejestracja',
  	['register_success'] = 'Rejestracja zakończona!',
  	['already_registered'] = 'Masz już stworzoną postać.',
  	['invalid_firstname'] = 'Zły format <b>First Name</b>.',
  	['invalid_lastname'] = 'Zły format <b>Last Name</b>.',
  	['invalid_sex'] = 'Zły format <b>Sex</b>.',
  	['invalid_dob'] = 'Zły format <b>DOB</b>.',
  	['invalid_height'] = 'Zły format <b>Height</b>.',
}