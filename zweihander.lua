
Zweihander = Core.class(Sprite)

function Zweihander:init(texture, world)
	self.world = world
	self.world:addActor(self)
	
	self.sprite = Bitmap.new(texture)
	self.sprite:setPosition(-self.sprite:getWidth() * math.sqrt(2) / 2, 0)
	self.sprite:setRotation(-45)
	self:addChild(self.sprite)
	
	self.hitbox = self.world.b2world:createBody{type=b2.DYNAMIC_BODY, position={x=0,y=0}}
	self.hitbox.shape = b2.PolygonShape.new()
	self.hitbox.shape:setAsBox(2 * math.sqrt(2), 56 * math.sqrt(2))
	self.hitbox:createFixture{shape=self.hitbox.shape, density=0, filter={categoryBits=MASK_ZWEIHANDER, maskBits=MASK_SHIELD}}
	
	self.body = self.world.b2world:createBody{type=b2.DYNAMIC_BODY, position={x=0,y=0}}
	self.body.shape = b2.CircleShape.new(0, 0, 2 * math.sqrt(2))
	self.body:createFixture{shape=self.body.shape, filter={categoryBits=MASK_NONE, maskBits=0}}
	
	self.world.b2world:createJoint(b2.createRevoluteJointDef(self.hitbox, self.body, 0, 0))
end

Zweihander._setPosition = Zweihander.setPosition
function Zweihander:setPosition(x, y)
	self.body:setPosition(x, y)
	self.hitbox:setPosition(x, y)
	self:_setPosition(x, y)
end

function Zweihander:applyForce(a, b, c, d)
	self.body:applyForce(a, b, c, d)
end

function Zweihander:on_enter_frame(event)
--[[
	px, py = self.world:getPlayer():getPosition()
	mx, my = self:getPosition()
	
	tx, ty = px - mx, py - my
	ta = (math.deg(math.atan2(tx, -ty)) - self:getRotation()) % 360
	
	rs = ZWEIHANDER_ROTATION_SPEED
	if self:getDistance(self.world:getPlayer()) > application:getDeviceHeight() then
		self:setRotation(math.deg(math.atan2(tx, -ty)))
	end
	
	if (ta > rs / 2 or 360 - ta > rs / 2) and (ta < 90 or ta > 270) then
		if ta < 180 then
			self:setRotation(self:getRotation() + (rs * event.deltaTime))
		else
			self:setRotation(self:getRotation() - (rs * event.deltaTime))
		end
	end
	
	self:setPosition(mx + (math.cos(math.rad(self:getRotation() - 90)) * ZWEIHANDER_SPEED * event.deltaTime),
					 my + (math.sin(math.rad(self:getRotation() - 90)) * ZWEIHANDER_SPEED * event.deltaTime))
]]--
	
	px, py = self.world:getPlayer():getPosition()
	mx, my = self.body:getPosition()
	tv = Vector2.new(px - mx, py - my)
	fv = tv:normalize() * SHIELD_GRAVITY / math.sqrt(tv:magnitude())
	
	self.body:applyForce(fv.x, fv.y, mx, my)
	
	self:setPosition(self.hitbox:getPosition())
	self.hitbox:setAngle(-math.atan2(self.body:getLinearVelocity()))
	self:setRotation(math.deg(self.hitbox:getAngle()) + 180)
end
