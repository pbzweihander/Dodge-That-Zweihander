
World = Core.class(Stage)

function World:init()
	self.b2world = b2.World.new(0, 0)
	self.actors = {}
	self.player = nil
	
	self:addEventListener(Event.ENTER_FRAME, self.on_enter_frame, self)
end

function World:addActor(o)
	self:addChild(o)
	o.world = self
	o.b2world = self.b2world
	table.insert(self.actors, o)
end

function World:setPlayer(o)
	self.player = o
end

function World:on_enter_frame(event)
	for _, a in pairs(self.actors) do
		a:on_enter_frame(event)
	end
	
	self.b2world:step(1/application:getFps(), 8, 3)
end

function World:getPlayer()
	return self.player
end