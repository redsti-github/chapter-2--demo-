-- StickyWheel.lua --

StickyWheel = class( nil )

lastShapes = {}
stickyWheels = {}
mass = 0
isSticking = false
StickingWheels = 0


function StickyWheel.server_onCollision( self, other, collisionPosition, selfPointVelocity, otherPointVelocity, collisionNormal )
	

	self.Other = other
	self.CollisionNormal = collisionNormal
	self.time = 10
	self.isSticking = true
	self.shape:getInteractable():setPublicData({true})
end

function StickyWheel.server_onFixedUpdate( self, deltaTime )


	if (self.shape:getBody():isStatic() or self.isSticking == false or self.time == nil) then
		return
	end

	if (self.time < 0) then
		self.isSticking = false
		self.shape:getInteractable():setPublicData({false})
		return
	end

	if (type(self.Other) == "Character") then
		return
	end

	local shapes = self.shape:getBody():getCreationShapes()

	if (self.lastShapes == nil) then
		self.lastShapes = {}
	end

	if (self.stickyWheels == nil) then
		self.stickyWheels = {}
	end

	if (not compare(self.lastShapes, shapes)) or self.stickyWheels == nil or self.mass == 0 then
		self.mass = 0
		self.stickyWheels = {}

		for i = 1, #shapes, 1 do
			self.mass = self.mass + shapes[i]:getMass()

			if(shapes[i]:getShapeUuid() == sm.uuid.new("3e10ef67-383a-4b60-aa5b-b1173134e431")) and not shapes[i]:getBody():isStatic() then
				table.insert(self.stickyWheels, shapes[i])
			end
		end

		self.lastShapes = copy(shapes)
	end

	self.StickingWheels = 0

	for i = 1, #self.stickyWheels, 1 do
		if (self.stickyWheels[i]:getInteractable():getPublicData() ~= nil) then
			if (self.stickyWheels[i]:getInteractable():getPublicData()[1]) then
				self.StickingWheels = self.StickingWheels + 1
			end
		end
	end

	local fractionalMass = self.mass / self.StickingWheels

	local dir = sm.vec3.new(0, 0, 1)

	sm.physics.applyImpulse(self.shape, dir * fractionalMass * 0.2645, true)
	sm.physics.applyImpulse(self.shape, -self.CollisionNormal * fractionalMass * 0.35, true)

	self.time = self.time - 1

	if (self.Other ~= nil) then
		if (sm.exists(self.Other)) then
			sm.physics.applyImpulse(self.Other, -dir * fractionalMass * 0.2645, true)
			sm.physics.applyImpulse(self.Other, self.CollisionNormal * fractionalMass * 0.35, true)
		end
	end
end


function copy(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do res[copy(k)] = copy(v) end
    return res
end

function compare(t1,t2)

	if (#t1 ~= #t2) then
		return false
	end

	for i = 1, #t1, 1 do
		if (t1[i] ~= t2[i]) then
			return false
		end
	end

	return true
end