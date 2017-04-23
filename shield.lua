
Shield = Core.class(Sprite)
ShieldEventDispatcher = Core.class(EventDispatcher)

function Shield:init(texture, world)
	self.world = world
	self.world:addActor(self)
	
	self.eventdispatcher = ShieldEventDispatcher.new()
	
	self.sprite = Bitmap.new(texture)
	self.sprite:setPosition(-self.sprite:getWidth()/2, -self.sprite:getHeight()/2)
	self:addChild(self.sprite)
	
	self.body = self.world.b2world:createBody{type=b2.KINEMATIC_BODY, position={x=0,y=0}}
	self.body.shape = b2.CircleShape.new(0, 0, 24)
	self.body:createFixture{shape=self.body.shape, filter={categoryBits=MASK_SHIELD, maskBits=MASK_ZWEIHANDER}}
	self.body.parent = self
	
	self.desired_vector = Vector2.new(0)
	self.moving_vector = Vector2.new(0)
	
	uieventdispatcher:addEventListener("move_input", self.on_ui_move_input, self)
	self.world.b2world:addEventListener(Event.BEGIN_CONTACT, self.on_begin_contact, self)
end

Shield._setPosition = Shield.setPosition
function Shield:setPosition(x, y)
	self.body:setPosition(x, y)
	self:_setPosition(x, y)
end

Shield._setRotation = Shield.setRotation
function Shield:setRotation(r)
	self.body:setAngle(math.rad(r))
	self:_setRotation(r)
end

function Shield:setAngle(r)
	self.body:setAngle(r)
	self:_setRotation(math.deg(r))
end

function Shield:on_ui_move_input(event)
	v = event.vector * SHIELD_SPEED_MULTIFLIER
	if v:magnitude() > SHIELD_MAX_SPEED then
		v = v:normalize() * SHIELD_MAX_SPEED
	end
	self.desired_vector = v
end

function Shield:on_enter_frame(event)
	mv = (self.desired_vector - self.moving_vector):normalize() * SHIELD_SPEED_CHANGE * event.deltaTime
	self.moving_vector = self.moving_vector + mv
	pv = Vector2.new(self:getPosition())
	self:setPosition((pv + self.moving_vector):unpack())
	
	mr = self:getRotation()
	self:setRotation(mr + ((self.moving_vector.x / SHIELD_MAX_SPEED) * SHIELD_MAX_ROTATION_SPEED * event.deltaTime))
end

function Shield:on_begin_contact(event)
	event.fixtureA:getBody().parent:match_position()
	event.fixtureB:getBody().parent:match_position()
	self.eventdispatcher:dispatchEvent(Event.new("player_hit"))
end

function Shield:destroy()
	self.world.b2world:destroyBody(self.body)
	self.body = nil
	self.sprite:removeFromParent()
	self:removeFromParent()
	self.sprite = nil
	self.world.b2world:removeEventListener(Event.BEGIN_CONTACT, self.on_begin_contact, self)
	uieventdispatcher:removeEventListener("move_input", self.on_ui_move_input, self)
	self = nil
end

function Shield:match_position()
	self:_setPosition(self.body:getPosition())
end
