-- Drill.lua --

dofile("$SURVIVAL_DATA/Scripts/game/survival_items.lua")

PlasmaDrill = class( nil )

function PlasmaDrill.server_onFixedUpdate( self, deltaTime )

	local valid, result = sm.physics.raycast(self.shape:getWorldPosition(), self.shape:getWorldPosition() + (self.shape:getAt() * 5))


	if (result.type == "harvestable" and valid) then
		local Harvestable = result:getHarvestable()

		Harvestable:setPublicData({1, result.pointWorld})
	end

	if (result.type == "body" and valid) then
		local shape = result:getShape()

		if (IsTree(shape:getShapeUuid()) or shape:getShapeUuid() == obj_harvest_stone or shape:getShapeUuid() == obj_harvests_stones_p01 or shape:getShapeUuid() == obj_harvests_stones_p02 or shape:getShapeUuid() == obj_harvests_stones_p03 or shape:getShapeUuid() == obj_harvests_stones_p04 or shape:getShapeUuid() == obj_harvests_stones_p05 or shape:getShapeUuid() == obj_harvests_stones_p06 or shape:getShapeUuid() == obj_harvest_stonechunk01 or shape:getShapeUuid() == obj_harvest_stonechunk02 or shape:getShapeUuid() == obj_harvest_stonechunk03) then

			shape:getInteractable():setPublicData({1, result.pointWorld})
		end
	end

	if (result.type == "character" and valid) then
		local character = result:getCharacter()

		if (character:isPlayer()) then
			sm.event.sendToPlayer( character:getPlayer(), "sv_e_receiveDamage", { damage = 1 } )
		else
			--sm.event.sendToUnit( character:getUnit(), "sv_e_receiveDamage", { damage = 100 })
		end
	end
end

function IsTree( Uuid )
	

	if obj_harvest_log_s01 == Uuid then return true end
	if obj_harvest_log_m01 == Uuid then return true end
	if obj_harvest_log_l01 == Uuid then return true end
	if obj_harvest_log_l02a == Uuid then return true end
	if obj_harvest_log_l02b == Uuid then return true end
	if obj_harvests_trees_spruce02_p00 == Uuid then return true end
	if obj_harvests_trees_spruce02_p01 == Uuid then return true end
	if obj_harvests_trees_spruce02_p02 == Uuid then return true end
	if obj_harvests_trees_spruce02_p03 == Uuid then return true end
	if obj_harvests_trees_spruce02_p04 == Uuid then return true end
	if obj_harvests_trees_spruce01_p05 == Uuid then return true end
	if obj_harvests_trees_spruce02_p05 == Uuid then return true end
	if obj_harvests_trees_spruce03_p05 == Uuid then return true end
	if obj_harvests_trees_leafy01_p00 == Uuid then return true end
	if obj_harvests_trees_leafy01_p01 == Uuid then return true end
	if obj_harvests_trees_leafy01_p02 == Uuid then return true end
	if obj_harvests_trees_leafy01_p03 == Uuid then return true end
	if obj_harvests_trees_leafy01_p04 == Uuid then return true end
	if obj_harvests_trees_leafy02_p00 == Uuid then return true end
	if obj_harvests_trees_leafy02_p01 == Uuid then return true end
	if obj_harvests_trees_leafy02_p02 == Uuid then return true end
	if obj_harvests_trees_leafy02_p03 == Uuid then return true end
	if obj_harvests_trees_leafy02_p04 == Uuid then return true end
	if obj_harvests_trees_leafy02_p05 == Uuid then return true end
	if obj_harvests_trees_leafy02_p06 == Uuid then return true end
	if obj_harvests_trees_leafy02_p07 == Uuid then return true end
	if obj_harvests_trees_leafy03_p00 == Uuid then return true end
	if obj_harvests_trees_leafy03_p01 == Uuid then return true end
	if obj_harvests_trees_leafy03_p02 == Uuid then return true end
	if obj_harvests_trees_leafy03_p03 == Uuid then return true end
	if obj_harvests_trees_leafy03_p04 == Uuid then return true end
	if obj_harvests_trees_leafy03_p05 == Uuid then return true end
	if obj_harvests_trees_leafy03_p06 == Uuid then return true end
	if obj_harvests_trees_leafy03_p07 == Uuid then return true end
	if obj_harvests_trees_leafy03_p08 == Uuid then return true end
	if obj_harvests_trees_leafy03_p09 == Uuid then return true end
	if obj_harvests_trees_birch01_p00 == Uuid then return true end
	if obj_harvests_trees_birch01_p01 == Uuid then return true end
	if obj_harvests_trees_birch01_p02 == Uuid then return true end
	if obj_harvests_trees_birch01_p03 == Uuid then return true end
	if obj_harvests_trees_birch01_p04 == Uuid then return true end
	if obj_harvests_trees_birch01_p05 == Uuid then return true end
	if obj_harvests_trees_birch02_p00 == Uuid then return true end
	if obj_harvests_trees_birch02_p01 == Uuid then return true end
	if obj_harvests_trees_birch02_p02 == Uuid then return true end
	if obj_harvests_trees_birch02_p03 == Uuid then return true end
	if obj_harvests_trees_birch02_p04 == Uuid then return true end
	if obj_harvests_trees_birch02_p05 == Uuid then return true end
	if obj_harvests_trees_birch02_p06 == Uuid then return true end
	if obj_harvests_trees_birch03_p00 == Uuid then return true end
	if obj_harvests_trees_birch03_p01 == Uuid then return true end
	if obj_harvests_trees_birch03_p02 == Uuid then return true end
	if obj_harvests_trees_birch03_p03 == Uuid then return true end
	if obj_harvests_trees_birch03_p04 == Uuid then return true end
	if obj_harvests_trees_birch03_p05 == Uuid then return true end
	if obj_harvests_trees_birch03_p06 == Uuid then return true end
	if obj_harvests_trees_pine01_p00 == Uuid then return true end
	if obj_harvests_trees_pine01_p01 == Uuid then return true end
	if obj_harvests_trees_pine01_p02 == Uuid then return true end
	if obj_harvests_trees_pine01_p03 == Uuid then return true end
	if obj_harvests_trees_pine01_p04 == Uuid then return true end
	if obj_harvests_trees_pine01_p05 == Uuid then return true end
	if obj_harvests_trees_pine01_p06 == Uuid then return true end
	if obj_harvests_trees_pine01_p07 == Uuid then return true end
	if obj_harvests_trees_pine01_p08 == Uuid then return true end
	if obj_harvests_trees_pine01_p09 == Uuid then return true end
	if obj_harvests_trees_pine01_p10 == Uuid then return true end
	if obj_harvests_trees_pine01_p11 == Uuid then return true end
	if obj_harvests_trees_pine02_p00 == Uuid then return true end
	if obj_harvests_trees_pine02_p01 == Uuid then return true end
	if obj_harvests_trees_pine02_p02 == Uuid then return true end
	if obj_harvests_trees_pine02_p03 == Uuid then return true end
	if obj_harvests_trees_pine02_p04 == Uuid then return true end
	if obj_harvests_trees_pine02_p05 == Uuid then return true end
	if obj_harvests_trees_pine02_p06 == Uuid then return true end
	if obj_harvests_trees_pine02_p07 == Uuid then return true end
	if obj_harvests_trees_pine02_p08 == Uuid then return true end
	if obj_harvests_trees_pine02_p09 == Uuid then return true end
	if obj_harvests_trees_pine02_p10 == Uuid then return true end
	if obj_harvests_trees_pine03_p00 == Uuid then return true end
	if obj_harvests_trees_pine03_p01 == Uuid then return true end
	if obj_harvests_trees_pine03_p02 == Uuid then return true end
	if obj_harvests_trees_pine03_p03 == Uuid then return true end
	if obj_harvests_trees_pine03_p04 == Uuid then return true end
	if obj_harvests_trees_pine03_p05 == Uuid then return true end
	if obj_harvests_trees_pine03_p06 == Uuid then return true end
	if obj_harvests_trees_pine03_p07 == Uuid then return true end
	if obj_harvests_trees_pine03_p08 == Uuid then return true end
	if obj_harvests_trees_pine03_p09 == Uuid then return true end
	if obj_harvests_trees_pine03_p10 == Uuid then return true end
	return false

end