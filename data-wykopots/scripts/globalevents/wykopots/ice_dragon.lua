local config = {
	position = { fromPosition = Position(6494, 1865, 8), toPosition = Position(6559, 1905, 10) },
}
--local spawnDay = 13
--local currentDay = os.date("%d")
local monsters = {}

function Game.createRandom(position)
	local tile = Tile(position)
	if not tile or Tile(position):getItemById(486) then
		return false
	end

	local ground = tile:getGround()
	if not ground or ground:hasProperty(CONST_PROP_BLOCKSOLID) or tile:getTopCreature() then
		return false
	end
	local monsterName = monsters[math.random(#monsters)]
	local monster = Game.createMonster(monsterName, position)
	if monster then
		monster:setSpawnPosition()
		monster:remove()
	end
	return true
end

local iceDragonRespawn = GlobalEvent("ice dragon spawn")
function iceDragonRespawn.onStartup()
	local contador = 1
	table.insert(monsters, "ice dragon")
	for x = config.position.fromPosition.x, config.position.toPosition.x do
		for y = config.position.fromPosition.y, config.position.toPosition.y do
			for z = config.position.fromPosition.z, config.position.toPosition.z do
				if math.random(1000) >= 996 then
					if Game.createRandom(Position(x, y, z)) then
					end
				end
			end
		end
	end
	return true
end
iceDragonRespawn:register()
