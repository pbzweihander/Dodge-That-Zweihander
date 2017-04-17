
Shield = Core.class(Sprite)

function Shield:init(texture)
	self.sprite = Bitmap.new(texture)
	self.sprite:setPosition(-self.sprite:getWidth()/2, -self.sprite:getHeight()/2)
	self:addChild(self.sprite)
	
end