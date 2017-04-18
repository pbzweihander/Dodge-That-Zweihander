
Zweihander = Core.class(Sprite)

function Zweihander:init(texture)
	self.sprite = Bitmap.new(texture)
	self.sprite:setPosition(-self.sprite:getWidth() * math.sqrt(2) / 2, 0)
	self.sprite:setRotation(-45)
	self:addChild(self.sprite)
end
