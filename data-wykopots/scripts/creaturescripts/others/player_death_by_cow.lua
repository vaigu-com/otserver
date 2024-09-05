local cowNames = {
	"Cow",
	"Minotaur",
	"Minotaur Archer",
	"Minotaur Guard",
	"Minotaur Mage",
	"Execowtioner",
	"Minotaur Hunter",
	"Minotaur Amazon",
	"Moohtant",
	"Mooh'Tah Warrior",
	"Worm Priestess",
}

local guillotinePartId = {
	5771,
	5772,
	2695,
	2694,
	1612,
	4969,
}

local guillotineCorners = {
	Position(7954, 1462, 5),
	Position(7954, 1463, 5),
}

local guillotine = {}

local function loadGuillotine()
	for _, id in pairs(guillotinePartId) do
		for _, pos in pairs(guillotineCorners) do
			local item = Tile(pos):getItemById(id)
			if item then
				guillotine[#guillotine + 1] = item
			end
		end
	end
end

local function moveGuillotine(dir)
	local z = 0
	if dir == "down" then
		z = 1
	end
	if dir == "up" then
		z = -1
	end

	for _, item in pairs(guillotine) do
		local originalPos = item:getPosition()
		local newPos = originalPos:Moved(0, 0, z)
		item:moveTo(newPos)
	end
end

local execowtionerPos = Position(7952, 1465, 7)
local execowtionerName = "Execowtioner"

local layingHumanOutfit = Condition(CONDITION_OUTFIT)
layingHumanOutfit:setTicks(8110)
layingHumanOutfit:setOutfit({ lookTypeEx = 5496 }) -- skeleton looktype

local guillotineIsReserved = false

local playerDeathByCow = CreatureEvent("PlayerDeathByCow")
function playerDeathByCow.onPrepareDeath(player, killer)
	local _, _, internalname = GetKillerDetails(killer)
	if not internalname then
		return true
	end
	if not table.contains(cowNames, internalname) then
		return true
	end
	if guillotineIsReserved then
		return true
	end
	GENERAL_SPECIAL_ACTIONS.clearConditions({ player = player })
	guillotineIsReserved = true
	local originalDeathPos = player:getPosition()
	player:teleportTo(Position(7954, 1463, 7))
	player:addCondition(layingHumanOutfit)
	local executionPos = player:getPosition()

	local execowtioner = Game.createMonster(execowtionerName, execowtionerPos)
	addEvent(function()
		execowtioner:say("Mooo")
	end, 500)
	addEvent(function()
		execowtioner:say("Moooooo")
	end, 2000)
	addEvent(function()
		execowtioner:say("Moooo! Moooo!")
	end, 7000)
	addEvent(function()
		moveGuillotine("down")
	end, 7750)
	addEvent(function()
		moveGuillotine("down")
	end, 8000)
	addEvent(function()
		player:setHealth(0)
	end, 8030)
	addEvent(function()
		moveGuillotine("up")
		moveGuillotine("up")
		execowtioner:remove()
	end, 9000)
	addEvent(function()
		guillotineIsReserved = false
		local corpse = Tile(executionPos):getItemById(4240)
		corpse:moveTo(originalDeathPos)
	end, 12000)
	return false
end

playerDeathByCow:register()

local cowDeathInit = GlobalEvent("cowDeathInit")
function cowDeathInit.onStartup()
	--loadGuillotine()
end
cowDeathInit:register()
