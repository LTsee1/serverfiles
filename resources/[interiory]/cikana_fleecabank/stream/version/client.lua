Citizen.CreateThread(function()
local link = "^4https://discord.gg/FKgcHAeJyY^7"
local link2 = "^4https://store.cikana-modding.de^7"
local serverName = GetConvar("sv_hostname", "^1Unbekannter Server^7")
local time = os.date("^1%H:%M:%S^7 ")
local date = os.date("^1%Y-%m-%d^7")

	print("^3Server:^7 " ..serverName)
	print("^2CikanaModding^7 - ^5Fleecabank-rework Version 1.0.0^7")
	print("^4For Support and Updates^7 - " .. link)
	print("^4Our Shop^7  - " .. link2)
	print("          " .. time  .. date)
end)