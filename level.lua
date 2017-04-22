
Level = Core.class(Sprite)

function Level:init(cplayer, cenemy, cworld)
	self.world = cworld.new()
	self.world:setScale(application:getDeviceWidth()/600 * (1/2))
	--self.world:setScale(0.2)
	self.world:setPosition(application:getDeviceWidth()/2, application:getDeviceHeight()/2)

	self.cplayer = cplayer
	self.cenemy = cenemy
	self.enemies = {}
	self.lastenemy = nil
	self.gameover = false
	
	--table.insert(self.enemies, self:spawn_enemy(Texture.new("zweihander.png")))
	--self.enemies[1]:setPosition(300, 400)
	
	local pt = {"shield1.png", "shield2.png", "shield3.png", "shield4.png"}
	self.player = self:spawn_player(Texture.new(pt[math.random(1, 4)]))
	
	self.world:setPlayer(self.player)
	
	stage:addChild(self.world)
	--[[
	local debugDraw = b2.DebugDraw.new()
	self.world.b2world:setDebugDraw(debugDraw)
	--debugDraw:setPosition(application:getDeviceWidth()/2, application:getDeviceHeight()/2)
	self.world:addChild(debugDraw)
	]]--
	self.lastspawntime = os.clock() - LEVEL_SPAWN_DELAY
	
	self:addEventListener(Event.ENTER_FRAME, self.on_enter_frame, self)
	uieventdispatcher:addEventListener("game_over", self.on_game_over, self)
end

function Level:on_enter_frame(event)
	if not self.gameover then
		self.world:on_enter_frame(event)
		
		if os.clock() - self.lastspawntime >= LEVEL_SPAWN_DELAY then
			e = self:spawn_enemy(Texture.new("zweihander.png"))
			if self.lastenemy then
				lex, ley = self.lastenemy:getPosition()
				px, py = self.player:getPosition()
				lepv = Vector2.new(px - lex, py - ley)
				fv = lepv:normalize() * LEVEL_FORCE_ON_SPAWN
				e:setPosition(lex, ley)
				e:applyForce(fv.x, fv.y, lex, ley)
				table.insert(self.enemies, e)
				self.lastenemy = e
				self.lastspawntime = os.clock()
			else
				ex, ey = Vector2.new(800, 0):rotate(math.rad(math.random(0, 360))):unpack()
				e:setPosition(ex, ey)
				table.insert(self.enemies, e)
				self.lastenemy = e
				self.lastspawntime = os.clock()
			end
		end
	end
end

function Level:spawn_enemy(texture)
	return self.cenemy.new(texture, self.world)
end

function Level:spawn_player(texture)
	return self.cplayer.new(texture, self.world)
end

function Level:on_game_over(event)
	self.gameover = true
end
