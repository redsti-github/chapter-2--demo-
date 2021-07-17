-- PowerCoreSocket.lua --
dofile("$SURVIVAL_DATA/Scripts/game/survival_shapes.lua")
dofile( "$SURVIVAL_DATA/Scripts/game/managers/QuestManager.lua" )

PowerCoreSocket = class( nil )
PowerCoreSocket.maxParentCount = 0
PowerCoreSocket.maxChildCount = 255
PowerCoreSocket.colorNormal = sm.color.new( 0xdeadbeef )
PowerCoreSocket.colorHighlight = sm.color.new( 0xdeadbeef )
PowerCoreSocket.connectionInput = sm.interactable.connectionType.none
PowerCoreSocket.connectionOutput = sm.interactable.connectionType.logic
PowerCoreSocket.poseWeightCount = 1

-- Server

function PowerCoreSocket.server_onCreate( self )
	self.sv = {}
	self.sv.saved = self.storage:load()
	
	if self.sv.saved == nil then
		self.sv.saved = {}
		self.interactable.active = false
		self.sv.saved.active = false
	else
		self.interactable.active = self.sv.saved.active
	end
	
	if self.params then
		if self.params.lightInteractables then
			self.sv.saved.lightInteractables = self.params.lightInteractables
		end
		if self.params.shipworkbenchInteractables then
			self.sv.saved.shipworkbenchInteractables = self.params.shipworkbenchInteractables
		end
		if self.params.noteterminalInteractables then
			self.sv.saved.noteterminalInteractables = self.params.noteterminalInteractables
		end
		if self.params.dispenserbotInteractables then
			self.sv.saved.dispenserbotInteractables = self.params.dispenserbotInteractables
		end
	end
	self.storage:save( self.sv.saved )
	
	if self.sv.saved.lightInteractables then
		for _, interactable in ipairs( self.sv.saved.lightInteractables ) do
			self.interactable:connect( interactable )
		end
	end
	if self.sv.saved.shipworkbenchInteractables then
		for _, interactable in ipairs( self.sv.saved.shipworkbenchInteractables ) do
			self.interactable:connect( interactable )
		end
	end
	if self.sv.saved.noteterminalInteractables then
		for _, interactable in ipairs( self.sv.saved.noteterminalInteractables ) do
			self.interactable:connect( interactable )
		end
	end
	if self.sv.saved.dispenserbotInteractables then
		for _, interactable in ipairs( self.sv.saved.dispenserbotInteractables ) do
			self.interactable:connect( interactable )
		end
	end
	
end

function PowerCoreSocket.sv_e_unlock( self, params )
	if self.interactable.active == false and params.player and sm.exists( params.player ) then
		if params.keyId == obj_survivalobject_powercore then
			local inventory = params.player:getInventory()
			sm.container.beginTransaction()
			sm.container.spend( inventory, obj_survivalobject_powercore, 1, true )
			if sm.container.endTransaction() then
				self.sv.saved.active = true
				self.interactable.active = true
				self.storage:save( self.sv.saved )
				local messageParams = { player = params.player, message = "#{INFO_POWER_RESTORED}" }
				self.network:sendToClients( "cl_n_onMessage", messageParams )
				sm.effect.playEffect( "PowerSocket - Activate", self.shape.worldPosition, nil, self.shape.worldRotation )

				Server_completeQuest( quest_restore_power )
			else
				local messageParams = { player = params.player, message = "#{INFO_NO_CORE}" }
				self.network:sendToClients( "cl_n_onMessage", messageParams )
			end
		end
	end
end

-- Client

function PowerCoreSocket.client_onCreate( self )
	self.interactable:setPoseWeight( 0, self.interactable.active and 1 or 0 )
end

function PowerCoreSocket.client_canInteract( self )
	if not self.interactable.active then
		local canUnlock
		local inventory = sm.localPlayer.getInventory()
		if sm.container.canSpend( inventory, obj_survivalobject_powercore, 1 ) then
			canUnlock = ( sm.localPlayer.getActiveItem() == obj_survivalobject_powercore )
		end
		
		sm.gui.setCenterIcon( "Use" )
		local itemName = sm.shape.getShapeTitle( obj_survivalobject_powercore )
		if canUnlock then
			local keyBindingText =  sm.gui.getKeyBinding( "Create" )
			sm.gui.setInteractionText( "", keyBindingText, "#{INTERACTION_PLACE} [" .. itemName .. "]" )
		else
			sm.gui.setInteractionText( "#{INFO_REQUIRES} [" .. itemName .. "]" )
		end
	end
	
	return false
end

function PowerCoreSocket.client_onUpdate( self, deltaTime )
	self.interactable:setPoseWeight( 0, self.interactable.active and 1 or 0 )
	if self.interactable.active then
		self.interactable:setGlowMultiplier( 1.0 )
	else
		self.time = self.time and self.time + deltaTime or 0
		self.interactable:setGlowMultiplier( math.sin( self.time * math.pi ) * 0.25 + 0.5 )
	end
end

function PowerCoreSocket.cl_n_onMessage( self, params )
	if sm.localPlayer.getPlayer() == params.player then
		sm.gui.displayAlertText( params.message, 2 )
	end
end

function PowerCoreSocket.server_onProjectile( self )
	if g_survivalDev then
		self.interactable.active = not self.interactable.active
	end
end