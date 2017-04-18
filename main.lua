
SHIELD_MAX_SPEED = 5



world = World.new()
world:setScale(application:getDeviceWidth()/600)
world:setPosition(application:getDeviceWidth()/2, application:getDeviceHeight()/2)

ui = UI.new()
uieventdispatcher = UIEventDispatcher.new()

shield = Shield.new(Texture.new("shield1.png"))
zweihander = Zweihander.new(Texture.new("zweihander.png"))

world:addChild(shield)
world:addChild(zweihander)

stage:addChild(world)
stage:addChild(ui)
