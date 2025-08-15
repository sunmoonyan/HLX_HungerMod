local character = ix.meta.character

--AJOUTER DES BRUIT DE STARVING/MANGER

function character:InitHungerMod()
        self:SetData("food", 100)
        self:SetData("saturation", 100)
        self:SetData("energy", 0)
end

function character:AddFood(food,saturation)
    self:SetData("food", math.Clamp(self:GetData("food")+food, 0, 100))
    self:SetData("saturation", math.Clamp(self:GetData("saturation")+saturation, 0, 100))
end

function UpdateHunger()
  for client, character in ix.util.GetCharacters() do
	  if character:GetData("saturation") > 0 then
	  	client:SetHealth(math.Clamp(client:Health()+ix.config.Get("hungerHeal"), 0, 100)) 
        character:SetData("saturation", math.Clamp(character:GetData("saturation")-ix.config.Get("hungerStarve"), 0, 100))
	  elseif character:GetData("food") > 0 then
        character:SetData("food", math.Clamp(character:GetData("food")- ix.config.Get("hungerStarve") , 0, 100))
	  elseif ix.config.Get("hungerKill") then
        client:TakeDamage( ix.config.Get("hungerDamage"))
      else
        client:SetHealth(math.Clamp(client:Health()-ix.config.Get("hungerDamage"), 10, 100))         
	  end
  end
end

hook.Add( "PlayerDeath", "RestoreFood", function( player )
      local char = player:GetCharacter()
      char:SetData("food", 100)
      char:SetData("saturation", 50)      
end )

timer.Create("HungerUpdate", ix.config.Get("hungerSpeed"), 0,function() UpdateHunger() end)