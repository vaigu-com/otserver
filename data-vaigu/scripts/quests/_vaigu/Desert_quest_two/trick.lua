	:Script(function(storageToRequiredState)
local function killingCurse(player)
	if player:hasCondition(CONDITION_DAZZLED) then
		return
	end
	local condition = Condition(CONDITION_DAZZLED)
	local damage = 10
	condition:addDamage(1, 4000, -damage)
	for _ = 1, 40 do
		damage = damage * 1.2
		condition:addDamage(1, 4000, -damage)
	end
	player:addCondition(condition)
end

local trickTeleport = MoveEvent()
function trickTeleport.onStepIn(creature, item, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	player:teleportTo(DESERT_QUEST_TWO_ANCHOR:Moved(34, -69, 0))
	return false
end
trickTeleport:type("stepin")
trickTeleport:aid(Storage.DesertQuestTwo.Puzzles.TrickTeleport)
trickTeleport:register()

local desertQuestTwoTrickSign = function(context)
	local user = context.player
	if not user:isPlayer() then
		return false
	end
	local localizer = user:Localizer(Storage.DesertQuestTwo.Questline)
	local resultReal = localizer:Get("DO NOT ROPE HERE! THIS SIGN WILL TRY TO TRICK AND KILL YOUR TEAMMATES")
	local resultTrick = localizer:Get("the sign says that knight and druid should use rope")
	if not user:isPaladin() then
		return localizer:Get("Only paladins can read the sacred texts.")
	end
	user:say(resultTrick, TALKTYPE_SAY)

	return resultReal
end
RegisterOnLook(desertQuestTwoTrickSign, "TRICK_SIGN", Storage.DesertQuestTwo.Questline)

local desertQuestTwoTrickGrave = function(context)
	local user = context.player
	if not user:isPlayer() then
		return false
	end
	local localizer = user:Localizer(Storage.DesertQuestTwo.Questline)
	local hereWillLie = localizer:Get("Here will lie ")
	local dateOfDeath = localizer:Get("Date of death")
	local name = user:getName()

	local now = os.time()
	local dateTable = os.date("*t", now)
	local year = dateTable.year
	local month = dateTable.month
	local day = dateTable.day

	local finalString = T(":hereWillLie::playerName:. \n\n:dateOfDeath:: :day:-:month:-:year:", { hereWillLie = hereWillLie, playerName = name, dateOfDeath = dateOfDeath, day = day, month = month, year = year })
	killingCurse(user)
	return finalString
end
RegisterOnLook(desertQuestTwoTrickGrave, "TRICK_GRAVE", Storage.DesertQuestTwo.Questline)
end)
