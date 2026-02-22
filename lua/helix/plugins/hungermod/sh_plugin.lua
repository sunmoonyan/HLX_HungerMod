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
PLUGIN.description = "Add a hunger system , have full food bar will heal you and have an empty food bar will do damage."
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
    
concommand.Add("copy_item_from_entity", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    local tr = ply:GetEyeTrace()
    if not IsValid(tr.Entity) then
        chat.AddText(Color(255,0,0), "Aucune entité regardée.")
        return
    end

    local ent = tr.Entity
    local model = ent:GetModel() or "models/error.mdl"
    local name = ent.PrintName or ent:GetClass()

    local text = string.format([[
ITEM.name = "%s"
ITEM.model = Model("%s")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A green fruit, it has a hard outer shell."
ITEM.energy = 25
ITEM.stamina = 100
]], name, model)

    SetClipboardText(text)

    chat.AddText(Color(0,255,0), "Item copié dans le presse-papier ✔")
end)

end

