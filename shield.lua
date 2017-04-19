
Shield = Core.class(Sprite)

function Shield:init(texture, world)
	self.world = world
	self.world:addActor(self)
	
	self.sprite = Bitmap.new(texture)
	self.sprite:setPosition(-self.sprite:getWidth()/2, -self.sprite:getHeight()/2)
	self:addChild(self.sprite)
	
	self.body = self.world.b2world:createBody{type=b2.DYNAMIC_BODY, position={x=0,y=0}}
	self.body.shape = b2.CircleShape.new(0, 0, 24)
	self.body:createFixture{shape=self.body.shape}
	
	self.desired_vector = Vector2.new(0)
	self.moving_vector = Vector2.new(0)
	
	uieventdispatcher:addEventListener("move_input", self.on_ui_move_input, self)
end

Shield.setposition = Shield.setPosition
function Shield:setPosition(x, y)
	self.body:setPosition(x, y)
	self:setposition(x, y)
end

function Shield:on_ui_move_input(event)
	v = event.vector * SHIELD_SPEED_MULTIFLIER
	if v:magnitude() > SHIELD_MAX_SPEED then
		v = v:normalize() * SHIELD_MAX_SPEED
	end
	self.desired_vector = v
end

function Shield:on_enter_frame(event)
--[[
	pv = Vector2.new(self:getPosition())
	self:setPosition((pv + (self.desired_vector * event.deltaTime)):unpack())
]]--
	
	
	lv = Vector2.new(self.body:getLinearVelocity())
	
	--self:setPosition(self.body:getPosition())
end
