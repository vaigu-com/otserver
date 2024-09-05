local messages = {
	"Gnomedix: So let the examination begin! Now don't move. Don't be afraid. The good doctor gnome won't hurt you - hopefully!",
	"Gnomedix: Now! Now! Don't panic! It's all over soon!",
	"Gnomedix: Let me try a bigger chisel!",
	"Gnomedix: We're almost don... holy gnome! What's THIS???",
	"Gnomedix: I need a drill! Gnomenursey, quick!",
	"Gnomedix: Hold still now! This might tickle a little..",
	"Gnomedix: Take this, you evil ... whatever you are!",
	"Gnomedix: I got it! Yikes! What was that? Uhm, well ... you passed the ear examination. Talk to Gnomaticus for your next test.",
}

local function sendTextMessages(cid, text, position)
	local player = Player(cid)
	if not player then
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, text)
	position:sendMagicEffect(CONST_ME_STUN)
end

local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(2000)
condition:setOutfit({ lookType = 33 }) -- skeleton looktype

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if item.uid == 3122 then
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) == 4 then
			player:addCondition(condition)
			player:getPosition():sendMagicEffect(CONST_ME_ENERGYHIT)
			player:setStorageValue(Storage.BigfootBurden.QuestLine, 5)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been succesfully g-rayed. Now let Doctor Gnomedix inspect your ears!")
			player:say("*Rrrrrrrrrrr...*", TALKTYPE_MONSTER_SAY)
		elseif player:getStorageValue(Storage.BigfootBurden.QuestLine) < 4 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The x-ray is not ready.")
			player:teleportTo(fromPosition, true)
		end
	elseif item.uid == 3123 then
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) < 6 then
			player:teleportTo(fromPosition, true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Najpierw popros doktora.")
			return true
		end
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) >= 7 then
			return true
		end

		for i = 1, #messages do
			addEvent(sendTextMessages, (i - 1) * 2000, player.uid, messages[i], player:getPosition())
		end

		player:setStorageValue(Storage.BigfootBurden.QuestLine, 7)
		addEvent(Game.createMonster, 14 * 1000, "Strange Slime", fromPosition:Moved(0, 1, 0))
	end
	return true
end

movement:type("stepin")
movement:uid(3122, 3123)
movement:register()
