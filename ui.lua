
UI = Core.class(Sprite)
UIEventDispatcher = Core.class(EventDispatcher)

function UI:init()
	self.starttime = os.clock()
	self.counter = Sprite.new()
	self.counter.text = TextField.new(nil, "0.000")
	self.counter.text:setScale(application:getDeviceWidth()/600*2)
	self.counter.text:setPosition(-self.counter.text:getWidth()/2, self.counter.text:getHeight())
	self.counter:setPosition(application:getDeviceWidth()/2, 0)
	self.counter:addChild(self.counter.text)
	self:addChild(self.counter)
	
	self.arrow = Sprite.new()
	self.arrow.sprite = Bitmap.new(Texture.new("arrow.png"))
	self.arrow.sprite:setPosition(-self.arrow.sprite:getWidth()/2, -self.arrow.sprite:getHeight()/2)
	self.arrow:addChild(self.arrow.sprite)
	self:addChild(self.arrow)
	self.arrow:setAlpha(0)
	
	self.gameovertext = TextField.new(nil, "Game Over")
	self.gameovertext:setScale(application:getDeviceWidth()/600*5)
	self.gameovertext:setPosition(-self.gameovertext:getWidth()/2 + application:getDeviceWidth()/2, application:getDeviceHeight()*(1/4))
	self.gameovertext:setAlpha(0)
	self:addChild(self.gameovertext)
	
	self.gameover = false
	self.touching = false
	self.touch = nil
	
	self:addEventListener(Event.ENTER_FRAME, self.on_enter_frame, self)
	self:addEventListener(Event.TOUCHES_BEGIN, self.on_touches_begin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.on_touches_move, self)
	self:addEventListener(Event.TOUCHES_END, self.on_touches_end, self)
	uieventdispatcher:addEventListener("game_over", self.on_game_over, self)
end

function UI:on_enter_frame(event)
	if not self.gameover then
		self.counter.text:setText(round(os.clock() - self.starttime, 3))
	end
end

function UI:on_touches_begin(event)
	self.touching = true
	self.touch = {}
	self.touch.x = event.touch.x
	self.touch.y = event.touch.y
	self.touch.id = event.touch.id
	
	e = Event.new("move_input")
	e.vector = Vector2.new(0, 0)
	uieventdispatcher:dispatchEvent(e)
	
	self.arrow:setPosition(self.touch.x, self.touch.y)
	self.arrow:setRotation(0)
	self.arrow:setAlpha(0.5)
end

function UI:on_touches_move(event)
	if self.touching and self.touch then
		if self.touch.id == event.touch.id then
			e = Event.new("move_input")
			e.vector = Vector2.new(event.touch.x - self.touch.x, event.touch.y - self.touch.y)
			uieventdispatcher:dispatchEvent(e)
			
			self.arrow:setPosition(self.touch.x, self.touch.y)
			self.arrow:setRotation(-math.deg(math.atan2(e.vector:unpack())) + 180)
			self.arrow:setAlpha(0.5)
		end
	end
end

function UI:on_touches_end(event)
	self.touch = nil
	self.touching = false
	
	e = Event.new("move_input")
	e.vector = Vector2.new(0, 0)
	uieventdispatcher:dispatchEvent(e)
	
	self.arrow:setAlpha(0)
end

function UI:on_game_over(event)
	self.gameover = true
	self.gameovertext:setAlpha(1)
end
