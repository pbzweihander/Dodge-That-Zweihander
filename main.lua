
require "box2d"

SHIELD_MAX_SPEED = 4
SHIELD_SPEED_MULTIFLIER = 0.2
SHIELD_SPEED_CHANGE = 15
SHIELD_MAX_ROTATION_SPEED = 90
--ZWEIHANDER_ROTATION_SPEED = 30
--ZWEIHANDER_SPEED = 300
SHIELD_GRAVITY = 600
SIM_FRAME_MULTIFLIER = 1.5
LEVEL_SPAWN_DELAY = 5
LEVEL_FORCE_ON_SPAWN = 2000

MASK_NONE = 1
MASK_SHIELD = 2
MASK_ZWEIHANDER = 4

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

uieventdispatcher = UIEventDispatcher.new()
ui = UI.new()

level = {}

stage:addChild(ui)

function init_level()
	level = Level.new(Shield, Zweihander, World)
end

--[[
local debugDraw = b2.DebugDraw.new()
level.world.b2world:setDebugDraw(debugDraw)
debugDraw:setPosition(application:getDeviceWidth()/2, application:getDeviceHeight()/2)
stage:addChild(debugDraw)
]]--
