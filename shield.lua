
Shield = Core.class(Sprite)

function Shield:init(texture)
	self.sprite = Bitmap.new(texture)
	self.sprite:setPosition(-self.sprite:getWidth()/2, -self.sprite:getHeight()/2)
	self:addChild(self.sprite)
	
	self.moving_vector = Vector2.new(0)
	
	uieventdispatcher:addEventListener("move_input", self.on_ui_move_input, uieventdispatcher)
end

function Shield:on_ui_move_input(event)
	v = event.vector
	if v:magnitude() > SHIELD_MAX_SPEED then
		v = v:normalize() * SHIELD_MAX_SPEED
	end
	
	self.moving_vector = v
end

function Shield:on_enter_frame(event)
	pv = Vector2.new(self:getPosition())
	self:setPosition((pv + (self.moving_vector * event.deltatime)):unpack())
end
