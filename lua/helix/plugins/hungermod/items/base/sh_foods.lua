
ITEM.name = "Food Base"
ITEM.model = "models/props_junk/watermelon01.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.food = 0 
ITEM.saturation = 0
ITEM.description = "Just food."
ITEM.category = "Food"
ITEM.useSound = "npc/barnacle/barnacle_crunch2.wav"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
        local client = itemTable.player
        local character = client:GetCharacter()
        character:AddFood(itemTable.food,itemTable.saturation)
		return true
	end,
}
