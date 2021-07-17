-- Drill.lua --

dofile("$SURVIVAL_DATA/Scripts/game/survival_items.lua")

PlasmaDrill = class( nil )

function PlasmaDrill.server_onFixedUpdate( self, deltaTime )

	local valid, result = sm.physics.raycast(self.shape:getWorldPosition(), self.shape:getWorldPosition() + (self.shape:getAt() * 5))

	--print(result)


	if (result.type == "harvestable" and valid) then
		local Harvestable = result:getHarvestable()

		Harvestable:setPublicData({1, result.pointWorld})
	end

	if (result.type == "body" and valid) then
		local shape = result:getShape()

		if (shape:getShapeUuid() == obj_harvest_stone or shape:getShapeUuid() == obj_harvests_stones_p01 or shape:getShapeUuid() == obj_harvests_stones_p02 or shape:getShapeUuid() == obj_harvests_stones_p03 or shape:getShapeUuid() == obj_harvests_stones_p04 or shape:getShapeUuid() == obj_harvests_stones_p05 or shape:getShapeUuid() == obj_harvests_stones_p06 or shape:getShapeUuid() == obj_harvest_stonechunk01 or shape:getShapeUuid() == obj_harvest_stonechunk02 or shape:getShapeUuid() == obj_harvest_stonechunk03) then

			shape:getInteractable():setPublicData({1, result.pointWorld})
		end
	end
end