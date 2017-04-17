
world = World.new()
world:setScale(0.5)

shield = Shield.new(Texture.new("shield1.png"))
shield:setPosition(shield:getWidth()/2, shield:getHeight()/2)

world:addChild(shield)

stage:addChild(world)