local character = ix.meta.character

--AJOUTER LES BRUITS ET L'ALCOOL

function character:AddStamina(stamina)
    local ply = self:GetPlayer()
    ply:RestoreStamina(stamina)
end

function character:AddEnergy(energy)
    self:SetData("energy", math.Clamp(self:GetData("energy")+energy, 0, 100))
end

function UpdateEnergy()
  for client, character in ix.util.GetCharacters() do
	  if character:GetData("energy") > 0 then
        character:SetData("energy", math.Clamp(character:GetData("energy")-1, 0, 100))
    end
  end
end

timer.Create("EnergyUpdate", 1, 0,function() UpdateEnergy() end)