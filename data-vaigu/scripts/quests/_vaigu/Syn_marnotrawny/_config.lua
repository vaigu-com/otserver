SYN_MARNOTRAWNY_KEY_ITEMS = {
	payslip = {
		id = 2818,
		aid = Storage.ProdigalSon.Payslip,
		desc = "A payslip.",
	},
	bookOne = {
		id = 2816,
		aid = Storage.ProdigalSon.EristicsBooks.One,
		desc = "Eristics for dummies\nPart 3",
	},
	bookTwo = {
		id = 2821,
		aid = Storage.ProdigalSon.EristicsBooks.Two,
		desc = "Eristics for dummies\nPart 5",
	},
	bookThree = {
		id = 2828,
		aid = Storage.ProdigalSon.EristicsBooks.Three,
		desc = "Eristics for dummies\nPart 8",
	},
	pot = {
		id = 3465,
		desc = "Every dish cooked in this pot can only make you more slim and fit.",
		aid = Storage.ProdigalSon.EristicsItems.Pot,
	},
	lovePotion = {
		id = 9173,
		desc = "This smart potion will make you a lovely person.",
		aid = Storage.ProdigalSon.EristicsItems.LovePotion,
	},
	herbs = {
		id = 12671,
		desc = "Assortment of herbs. They cure cancer within 24 hours.",
		aid = Storage.ProdigalSon.EristicsItems.Herbs,
	},
	loanDocument = {
		id = 2815,
		desc = "Loan agreement",
		aid = Storage.ProdigalSon.EristicsItems.LoanDocument,
	},
	diamondNecklace = {
		id = 35607,
		aid = Storage.ProdigalSon.DiamondNecklace,
	},
	frediBeer = {
		id = 6106,
	},
}

local obotTopLeft = JANUSZEX_ANCHOR:Moved(57, 13, 1)
local oboDownRight = JANUSZEX_ANCHOR:Moved(60, 16, 1)
local function accessObotExplosion()
	for i = 250, 5000, 250 do
		addEvent(function()
			IterateBetweenPositions(obotTopLeft, oboDownRight, function(context)
				local pos = context.pos
				pos:sendMagicEffect(CONST_ME_GROUNDSHAKER)
				local creature = Tile(pos):getTopCreature()
				if creature then
					doTargetCombatHealth(0, creature, COMBAT_FIREDAMAGE, -300, -300, CONST_ME_FIREAREA)
				end
			end)
		end, i)
	end
end

SYN_MARNOTRAWNY_SPECIAL_CONDITIONS = {
	frediIsNearby = function(context)
		local npcPos = context.npc:getPosition()
		local topLeft = npcPos:Moved(-7, -7, 0)
		local downRight = npcPos:Moved(7, 7, 0)
		local result = IterateBetweenPositions(topLeft, downRight, function(args2)
			local pos = args2.pos
			local tile = Tile(pos)
			if not tile then
				return false
			end
			local oldCreature = tile:getTopCreature()
			if not oldCreature then
				return false
			end
			if oldCreature:getName():lower() == "fredi kamionka" then
				return true
			end
			return false
		end, { stopCondition = STOP_CONDITIONS.isTrue })
		return result
	end,
	saidCorrectPassword = function(context)
		local player = context.player
		local correctPassword = tostring(player:getStorageValue(Storage.ProdigalSon.Blackboard))
		local saidPassword = context.msg
		if MsgContains(saidPassword, correctPassword) then
			return true
		end

		local npc = context.npc
		if npc:getOutfit().lookHead ~= 83 then
			return
		end
		npc:setOutfit({ lookType = 875, lookHead = 94, lookBody = 38, lookLegs = 114, lookFeet = 114, lookAddons = 2 })
		addEvent(function()
			npc:setOutfit({
				lookType = 875,
				lookHead = 83,
				lookBody = 38,
				lookLegs = 114,
				lookFeet = 114,
				lookAddons = 2,
			})
		end, 7000)

		addEvent(function()
			accessObotExplosion()
		end, 2000)
	end,
}
SYN_MARNOTRAWNY_SPECIAL_ACTIONS = {
	setPersonalBlackboardPassword = function(context)
		local player = context.player
		player:setStorageValue(Storage.ProdigalSon.Blackboard, math.random(10 ^ 6, 10 ^ 7 - 1))
	end,
}

SYN_MARNOTRAWNY_NORMAL_ITEMS = {
	--hammer
	rawHammer = 3459,
	paint = 7253,
	doneHammer = 3460,
	lever2 = 8911,
	--calculator
	stoneTable = 2346,
	stonePile = 7914,
	woodPile = 7919,
	woodTrash = 3135,
	stoneTrash = 3142,
	westMachine = 842,
	doneCalculator = 8156,
	--plier
	metalPile = 21149,
	metalPiece = 27270,
	southMachine = 845,
	donePliers = 22680,
	toiletSoap = 35595,
}

function testMagic()
	local player = Player("GOD")
	local playerPos = player:getPosition():Moved(-6, -6, 0)
	local counter = 0
	for i = 1, 10 do
		for j = 1, 10 do
			local pos = playerPos:Moved(i, j, 0)
			pos:sendMagicEffect(counter)
			counter = counter + 1
		end
	end
end
