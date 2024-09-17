local baseBoltsPerOrb = 1
local additionalBoltsChance = 0.1
local additionalBoltsNumber = 6
local averageAdditionalBoltsMultiplier = (additionalBoltsChance * additionalBoltsNumber) + (1 - additionalBoltsChance) * baseBoltsPerOrb

SPECIAL_ACTIONS_UNIVERSAL = {
	clearConditions = function(context)
		local player = context.player
		local conditions = context.conditions or ALL_CONDITIONS
		for _, condition in pairs(conditions) do
			player:removeCondition(condition)
		end
	end,
	endDialog = function(context)
		local player = context.player
		local npcHandler = context.npcHandler
		local npc = context.npc
		if not (player and npcHandler) then
			return
		end
		addEvent(function()
			npcHandler:removeInteraction(npc, player)
		end, 10)
	end,
	dealDamageNonLethal = function(context)
		local target = context.target or context.monster or context.player
		local minDmg = context.minDMG or context.dmg or context.damage
		local maxDmg = context.maxDMG or context.dmg or context.damage
		if maxDmg >= target:getHealth() then
			return
		end
		local damageType = context.damageType or COMBAT_ENERGYDAMAGE
		local magicEffect = context.magicEffect or context.me or CONST_ME_NONE
		doTargetCombatHealth(0, target, damageType, -minDmg, -maxDmg, magicEffect)
	end,
	npcSay = function(context)
		local talkType = context.talkType or context.npc
		local player = context.player
		local aid = context.questlineAid
		local text = context.text
		local npc = context.npc
		local npcHandler = context.npcHandler

		local translatedMessage = player:Localizer(aid):Get(text)

		addEvent(function()
			npcHandler:say(translatedMessage, npc, player, nil, talkType)
		end, 50)
	end,
	teleportToTemple = function(context)
		local player = context.player
		player:teleportTo(player:getTown():getTemplePosition(), true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end,
	createMonstersAtPlayer = function(context)
		local player = context.player
		local monsters = context.monsters
		for _, monsterconfig in pairs(monsters) do
			SpawnMonstersAtPlayer(monsterconfig.name, player, monsterconfig.count or 1)
		end
	end,
	teleportPlayer = function(context)
		local player = context.player
		local toPos = context.pos or context.toPos or context.topos or context.destination
		player:teleportTo(toPos)
	end,
	-- twist is 1
	-- first regular is 2
	-- last regular is 6
	-- two new are 7 and 8 (blood and heart of the mountain)
	grantBless = function(context)
		local player = context.player
		player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		local min, max = context.min, context.max
		for i = min, max do
			player:addBlessing(i, 1)
		end
	end,
	removeMoneyBank = function(context)
		local player = context.player
		local price = context.price
		player:removeMoneyBank(price)
	end,
	despawnEscortee = function(context)
		local escorteeName = context.escorteeName
		local despawnAfterSeconds = context.despawnAfterSeconds

		addEvent(function()
			local creature = Creature(EscortRegistry():GetState(escorteeName).escortee)
			if not creature then
				return
			end
			creature:remove()
		end, despawnAfterSeconds * 1000)
	end,
	buyPromotion = function(context)
		local player = context.player
		local vocation = player:getVocation()
		local promotion = vocation:getPromotion()
		if player:removeMoney(15000) then
			player:setVocation(promotion)
			player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		end
	end,
	heal = function(context)
		local player = context.player
		player:addHealth(20000)
		player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
	end,
	SetCustomDialogDataAsNumber = function(context)
		PlayerCustomDialogDataRegistry():Get(context.player)[context.key] = tonumber(context.msg)
	end,
	cancelMarriage = function(context)
		local player = context.player
		setPlayerMarriageStatus(player:getGuid(), 0)
		setPlayerSpouse(player:getGuid(), -1)
	end,
	divorce = function(context)
		local player = context.player
		local spouse = getPlayerSpouse(player:getGuid())
		setPlayerMarriageStatus(player:getGuid(), 0)
		setPlayerSpouse(player:getGuid(), -1)
		setPlayerMarriageStatus(spouse, 0)
		setPlayerSpouse(spouse, -1)
	end,
	setStorageRandomNumber = function(context)
		local randomVal = math.random(context.min, context.max)
		context.player:setStorageValue(context.storage, randomVal)
	end,
	openTradeWindow = function(context)
		context.npcHandler:onTradeRequest(context.npc, context.player, context.msg)
	end,
	sendMagicEffect = function(context)
		local player = context.player
		if player then
			player:getPosition():sendMagicEffect(context.effect or CONST_ME_HOLYAREA)
		end
	end,
}

SPECIAL_ACTIONS_SOULORB = {
	soulOrbToInfernalBolt = function(context)
		local player = context.player
		local count = player:CountItem(5944, 0)
		local totalBoltsGranted = (count - count % additionalBoltsNumber) * averageAdditionalBoltsMultiplier
		local uncertainBolts = count - totalBoltsGranted
		for _ = 1, uncertainBolts do
			if math.random(1, 100) < additionalBoltsChance * 100 then
				totalBoltsGranted = totalBoltsGranted + additionalBoltsNumber
			else
				totalBoltsGranted = totalBoltsGranted + baseBoltsPerOrb
			end
		end
		player:AddCustomItem({ id = 6528, count = totalBoltsGranted })
	end,
}

SPECIAL_ACTIONS_WILDCARD = {
	addWilcard = function(context)
		local player = context.player
		local orderedCards = PlayerCustomDialogDataRegistry():Get(context.player).orderedCards
		player:addPreyCards(orderedCards)
	end,
	removeMoneyPreycards = function(context)
		local player = context.player
		local orderedCards = PlayerCustomDialogDataRegistry():Get(context.player).orderedCards
		local requiredMoney = player:GetWildcardPrice() * orderedCards
		player:removeMoney(requiredMoney)
	end,
}

SPECIAL_ACTIONS_JEWELER = {
	exchangeLifeCrystal = function(context)
		local player = context.player
		local crystalCount = player:CountItem(3051, 0)
		player:AddCustomItem({ id = 3052, count = crystalCount })
	end,
}

SPECIAL_ACTIONS_TASKS = {
	grantTaskRewards = function(context)
		local player = context.player
		player:GrantRewardsForAllTasks(context)
	end,
	openTaskWindow = function(context)
		OpenTaskWindow(context)
	end,
	openTaskCancelWindow = function(context)
		OpenTaskCancelWindow(context)
	end,
}

SPECIAL_ACTIONS_DAILY_TASK = {
	grantDailyTaskRewards = function(context)
		local player = context.player
		player:GrantRewardsForAllDailyTasks(context)
	end,
	openDailyTaskCancelWindow = function(context)
		OpenDailyTaskCancelWindow(context)
	end,
	openDailyTaskWindow = function(context)
		OpenDailyTaskWindow(context)
	end,
}

SPECIAL_ACTIONS_IMBUING = {
	removeTaskPointsByImbuing = function(context)
		local bundleData = PlayerCustomDialogDataRegistry():Get(context.player).bundleData

		local player = context.player
		player:AddItems(bundleData.items)
		player:removeMoney(bundleData.moneyPrice)
		player:IncrementStorage(Storage.taskPoints, -bundleData.taskPointsCost)
	end,
}

SPECIAL_ACTIONS_COOK = {
	setDishData = function(context)
		local dishName = context.msg
		local dishStorage = COOKING_DISH_NAMES[dishName]
		local dishData = COOKING_INGREDIENT_DATA[dishStorage]
		PlayerCustomDialogDataRegistry():Get(context.player).dishData = dishData
	end,
}

SPECIAL_ACTIONS_BANK = {

}