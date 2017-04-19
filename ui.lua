
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
	
	self.touching = false
	self.touch = nil
	
	self:addEventListener(Event.ENTER_FRAME, self.on_enter_frame, self)
	self:addEventListener(Event.TOUCHES_BEGIN, self.on_touches_begin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.on_touches_move, self)
	self:addEventListener(Event.TOUCHES_END, self.on_touches_end, self)
end

function UI:on_enter_frame(event)
	self.counter.text:setText(round(os.clock() - self.starttime, 3))
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
end

function UI:on_touches_move(event)
	if self.touching and self.touch then
		if self.touch.id == event.touch.id then
			e = Event.new("move_input")
			e.vector = Vector2.new(event.touch.x - self.touch.x, event.touch.y - self.touch.y)
			uieventdispatcher:dispatchEvent(e)
		end
	end
end

function UI:on_touches_end(event)
	self.touch = nil
	self.touching = false
	
	e = Event.new("move_input")
	e.vector = Vector2.new(0, 0)
	uieventdispatcher:dispatchEvent(e)
end
