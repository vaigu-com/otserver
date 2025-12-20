Storage.CobraBastion = {
	GaltheinArmour = {},
	MirrorPillar = {},
}
MovableKeys:Add(Storage.CobraBastion.GaltheinArmour)

local armorId = 31482
local armorPos = Position(6812, 969, 6)

local function createArmor(id, amount, pos)
	local armor = Game.createItem(id, amount, pos)
	if armor then
		armor:setKey(Storage.CobraBastion.GaltheinArmour)
	end
end

local bossRoom = {
	corner1 = Position(6804, 971, 6),
	corner2 = Position(6816, 983, 6),
	mirrorsPillarIds = { 31474, 31475, 31476, 31477 },
}
local function scambleAllMirrorPillars()
	ItemExList():Area(Area(bossRoom.corner1, bossRoom.corner2)):FilterByIds(bossRoom.mirrorsPillarIds):ForEach(function(item)
		item:transform(table.random(bossRoom.mirrorsPillarIds))
		item:getPosition():sendMagicEffect(CONST_ME_POFF)
	end)
end

local config = {
	boss = {
		name = "Scarlett Etzel",
		createFunction = function()
			local scarlett = Game.createMonster("Scarlett Etzel", Position(6810, 971, 6), true, true)
			scarlett:setStorageValueByKey(Storage.Quest.U12_20.GraveDanger.CobraBastion.Questline, 1)
			return scarlett
		end,
	},
	playerPositions = {
		{ pos = Position(6809, 990, 6), teleport = Position(6814, 984, 6) },
		{ pos = Position(6808, 991, 6), teleport = Position(6813, 985, 6) },
		{ pos = Position(6809, 991, 6), teleport = Position(6814, 985, 6) },
		{ pos = Position(6810, 991, 6), teleport = Position(6815, 985, 6) },
		{ pos = Position(6809, 992, 6), teleport = Position(6814, 986, 6) },
	},
	specPos = {
		from = Position(6800, 968, 6),
		to = Position(6819, 988, 6),
	},
	onUseExtra = function()
		scambleAllMirrorPillars()
		SCARLETT_MAY_TRANSFORM = 0
	end,
	exit = Position(6809, 997, 6),
}

local lever = BossLever(config)
lever:position(Position(6809, 989, 6))
lever:register()

local transformTo = {
	[31474] = 31475,
	[31475] = 31476,
	[31476] = 31477,
	[31477] = 31474,
}

local mirrorPillar = Action()
function mirrorPillar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local pilar = transformTo[item.itemid]
	if pilar then
		item:transform(pilar)
		item:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end
mirrorPillar:key(Storage.CobraBastion.MirrorPillar)
mirrorPillar:register()

local graveScarlettAid = Action()
function graveScarlettAid.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
	item:remove(1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hold the old chestplate of Galthein in front of you. It does not fit and far too old to withstand any attack.")
	addEvent(createArmor, 5 * 1000, armorId, 1, armorPos)
	addEvent(scambleAllMirrorPillars, 10 * 1000)
	SCARLETT_MAY_TRANSFORM = 1
	addEvent(function()
		SCARLETT_MAY_TRANSFORM = 0
	end, 2000)

	return true
end
graveScarlettAid:key(Storage.CobraBastion.GaltheinArmour)
graveScarlettAid:register()
