Rust_tokenizer = {}

Rust_tokenizer.__index = Rust_tokenizer

local players = {}
local resource_name = GetCurrentResourceName()

function  Rust_tokenizer.new(resource_name)
    local tokenizer_info = {
        players = players,
        resource_name = resource_name
    }
    return setmetatable(tokenizer_info,Rust_tokenizer)
end
local RANDOM_WORDS = {
    "Rust"..math.random(1,100), "gsda"..math.random(1,100), "tysd"..math.random(1,100), "xczcer"..math.random(1,100), "JGDGF"..math.random(1,100), "asdahg"..math.random(1,100), "gDasdaDFe"..math.random(1,100), "hohfghtdew"..math.random(1,100), "i4adsfgfds"..math.random(1,100), "jacgfhfhbnt"..math.random(1,100),
    "41as"..math.random(1,100), "lhdf"..math.random(1,100), "gfgdf"..math.random(1,100), "gdfgdg"..math.random(1,100), "orSDasd"..math.random(1,100), "pjhjfr"..math.random(1,100), "HUhsidjahd"..math.random(1,100), "raliujly"..math.random(1,100), "sjhgknfdgdfh"..math.random(1,100), "tghfhtrine"..math.random(1,100)
}



local function generateToken()
    local currentDay = os.date("%d")
    
    if not currentDay then
        return nil, "Failed to get the current day."
    end
    
    local token = ""
    local words_amount = math.random(10,15)
    for i = 1, words_amount do
        local randomWord = RANDOM_WORDS[math.random(#RANDOM_WORDS)]
        token = token .. randomWord
    end
    
    return token
end

function Rust_tokenizer:GenerateToken(plr)
    local t = generateToken()
    players[plr] = t
    local token = ""
    local words_amount = math.random(2,3)
    for i = 1, words_amount do
        local randomWord = RANDOM_WORDS[math.random(#RANDOM_WORDS)]
        token = token .. randomWord
    end

    TriggerClientEvent(resource_name..'-token',plr,{words_amount = t})
end


function Rust_tokenizer:IsTokenValid(plr,token)
     local plr,token_provided = plr,token
    -- valid
    if players[plr] == token_provided then
        Rust_tokenizer:GenerateToken(plr)
        return true
    end
    -- invalid

    return false
end
