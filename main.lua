
require "box2d"

SHIELD_MAX_SPEED = 100
SHIELD_SPEED_MULTIFLIER = 1
--ZWEIHANDER_ROTATION_SPEED = 30
--ZWEIHANDER_SPEED = 300
SHIELD_GRAVITY = 6000

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function Sprite:getDistance(target)
	mx, my = self:getPosition()
	tx, ty = target:getPosition()
	return math.sqrt((mx - tx)^2, (my - ty)^2)
end

b2.setScale(application:getDeviceWidth()/60)

world = World.new()
--world:setScale(application:getDeviceWidth()/600)
world:setScale(0.2)
world:setPosition(application:getDeviceWidth()/2, application:getDeviceHeight()/2)

ui = UI.new()
uieventdispatcher = UIEventDispatcher.new()

shield = Shield.new(Texture.new("shield1.png"), world)
zweihander = Zweihander.new(Texture.new("zweihander.png"), world)
zweihander:setPosition(100, -500)

world:setPlayer(shield)

stage:addChild(world)
stage:addChild(ui)

local debugDraw = b2.DebugDraw.new()
world.b2world:setDebugDraw(debugDraw)
debugDraw:setPosition(application:getDeviceWidth()/2, application:getDeviceHeight()/2)
stage:addChild(debugDraw)
