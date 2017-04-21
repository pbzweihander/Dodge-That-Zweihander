
World = Core.class(Stage)

function World:init()
	self.b2world = b2.World.new(0, 0)
	self.actors = {}
	self.player = nil
	self.gameover = false
end

function World:addActor(o)
	self:addChild(o)
	o.world = self
	o.b2world = self.b2world
	table.insert(self.actors, o)
end

function World:setPlayer(o)
	self.player = o
	self.player.eventdispatcher:addEventListener("player_hit", self.on_player_hit, self)
end

function World:on_enter_frame(event)
	if not self.gameover then
		for _, a in pairs(self.actors) do
			a:on_enter_frame(event)
		end
		
		self.b2world:step(1/application:getFps()*SIM_FRAME_MULTIFLIER, 8, 3)
	end
end

function World:getPlayer()
	return self.player
end

function World:on_player_hit()
	self.gameover = true
	px, py = self.player:getPosition()
	px = px * application:getDeviceWidth()/600 *2
	py = py * application:getDeviceWidth()/600 *2
	self:setPosition(application:getDeviceWidth()/2 - px, application:getDeviceHeight()/2 - py)
	self:setScale(application:getDeviceWidth()/600*2)
	uieventdispatcher:dispatchEvent(Event.new("game_over"))
end
