
Level = Core.class(Sprite)

function Level:init(player, enemy, world)
	self.player = player
	self.enemy = enemy
	self.world = world
	
	self:addEventListener(Event.ENTER_FRAME, self.on_enter_frame, self)
end

function Level:on_enter_frame(event)
	
end