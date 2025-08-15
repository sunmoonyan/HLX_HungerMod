
-- Ajustement de l'offset de stamina selon l'énergie du personnage
function PLUGIN:AdjustStaminaOffset(client, baseOffset)
    local character = client:GetCharacter()
    if character:GetData("energy") > 0 then
        return baseOffset * ix.config.Get("energyStaminaModifier")
    end
end

if CLIENT then 

function PLUGIN:CharacterLoaded(character)
    ix.bar.Add(function()
        return character:GetData("food") / 100
    end, Color(80, 162, 108), nil, "food")
end


end