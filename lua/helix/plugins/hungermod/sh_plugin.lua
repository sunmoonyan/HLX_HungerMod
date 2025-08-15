--[[
 ________  ___  ___  ________   ________  ___  ___  ___     
|\   ____\|\  \|\  \|\   ___  \|\   ____\|\  \|\  \|\  \    
\ \  \___|\ \  \\\  \ \  \\ \  \ \  \___|\ \  \\\  \ \  \   
 \ \_____  \ \  \\\  \ \  \\ \  \ \_____  \ \   __  \ \  \  
  \|____|\  \ \  \\\  \ \  \\ \  \|____|\  \ \  \ \  \ \  \ 
    ____\_\  \ \_______\ \__\\ \__\____\_\  \ \__\ \__\ \__\
   |\_________\|_______|\|__| \|__|\_________\|__|\|__|\|__|
   \|_________|                   \|_________|              
]]--

local PLUGIN = PLUGIN

PLUGIN.name = "Hunger Mod"
PLUGIN.author = "Sunshi"
PLUGIN.description = "."
PLUGIN.requires = {}


ix.config.Add("energyStaminaModifier", 0.5, "Multiplier applied to stamina after drinking an energy drink.", nil, {
    data = {min = 0, max = 1, decimals = 2},
    category = "Hunger"
})

ix.config.Add("hungerKill", false, "If enabled, players can die from starvation.", nil, {
    category = "Hunger"
})

ix.config.Add("hungerHeal", 5, "Health gained each cycle when hunger is full.", nil, {
    data = {min = 0, max = 100, decimals = 0},
    category = "Hunger"
})

ix.config.Add("hungerDamage", 5, "Health lost each cycle when hunger is at 0.", nil, {
    data = {min = 0, max = 100, decimals = 0},
    category = "Hunger"
})

ix.config.Add("hungerStarve", 2.5, "Amount of hunger points lost per update cycle.", nil, {
    data = {min = 0, max = 5, decimals = 1},
    category = "Hunger"
})

ix.config.Add("hungerSpeed", 30, "Sets the interval (in seconds) at which hunger is updated.", function()
    if SERVER then
        timer.Create("HungerUpdate", ix.config.Get("hungerSpeed"), 0, function()
            UpdateHunger()
        end)
    end
end, {
    data = {min = 0, max = 120, decimals = 0},
    category = "Hunger"
})





if SERVER then
    function PLUGIN:LoadData()

    end

    function PLUGIN:OnCharacterCreated(client, character)
        character:InitHungerMod()
    end


    function PLUGIN:CharacterLoaded(character)
          if character:GetData("food") == nil then
             character:InitHungerMod()
          end
    end


    include("hungermod/sv_food.lua")
    include("hungermod/sv_drink.lua")
    include("hungermod/sh_stamina.lua")
    AddCSLuaFile("hungermod/sh_stamina.lua")
else 
    include("hungermod/sh_stamina.lua")    
end
