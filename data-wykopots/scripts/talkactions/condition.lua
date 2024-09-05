local addCondition = TalkAction("/condition")

local conditions = {
	CONDITION_POISON, --utori pox
	CONDITION_FIRE, --utori flam
	CONDITION_ENERGY, --utori vis

	CONDITION_BLEEDING, --utori kor
	CONDITION_HASTE, --utani hur
	CONDITION_INVISIBLE, --utana vid/stealth ring

	CONDITION_MANASHIELD, --utamo vita/ering
	CONDITION_INFIGHT, -- any attack spell
	CONDITION_DRUNK, -- drink beer

	CONDITION_DROWN, -- special chest
	CONDITION_MUTED, -- spam
	CONDITION_FREEZING, -- special chest

	CONDITION_DAZZLED, --utori san
	CONDITIONCURSED, --utori mort
}

function addCondition.onSay(player, words, param)
	local usage = "/condition PLAYER NAME"
	if param == "" then
		player:sendCancelMessage("Command param required. Usage: " .. usage)
		return false
	end

	local target = Player(param)
	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	for _, identifier in pairs(conditions) do
		local condition = Condition(identifier)
		condition:setParameter(CONDITION_PARAM_DELAYED, 1)
		condition:addDamage(5000, 2000, -50)
		target:addCondition(condition)
	end
end

addCondition:separator(" ")
addCondition:groupType("gamemaster")
addCondition:register()
