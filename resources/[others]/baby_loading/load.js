var ServerNameText = document.getElementById("server_name_text");
var DiscordLinkText = document.getElementById("discord_link_text");
const servername =  GetConvar("server_name","Convar server_name is not defined")
const discordlink = GetConvar("discord_link","Convar discord_link is not defined")

ServerNameText.innerHTML = servername

DiscordLinkText.innerHTML = discordlink
