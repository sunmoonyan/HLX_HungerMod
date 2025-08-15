
ITEM.name = "Drinks Base"
ITEM.model = "models/props_junk/PopCan01a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.energy = 0 
ITEM.stamina = 0
ITEM.description = "Just drink."
ITEM.category = "Drinks"

ITEM.functions.Drink = {
	OnRun = function(itemTable)
        local client = itemTable.player
        local character = client:GetCharacter()
        character:AddEnergy(itemTable.energy)
        character:AddStamina(itemTable.stamina)
		return true
	end,
}
