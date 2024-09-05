local config = nil
local lang_to_config = {
	["PL"] = {
		["SE"] = "Idz na poludniowy-wschod!",
		["NE"] = "Idz na polnocny-wschod!",
		["E"] = "Idz na wschod!",
		["SW"] = "Idz na poludniowy-zachod!",
		["NW"] = "Idz na polnocny-zachod!",
		["W"] = "Idz na zachod!",
		["S"] = "Idz na poludnie!",
		["N"] = "Idz na polnoc!",
		["X"] = "Jestes na miejscu!",
	},
	["EN"] = {
		["SE"] = "Go to south east!",
		["NE"] = "Go to north east!",
		["E"] = "Go to east!",
		["SW"] = "Go to south west!",
		["NW"] = "Go to north west!",
		["W"] = "Go to west!",
		["S"] = "Go to south!",
		["N"] = "Go to north!",
		["X"] = "You are there!",
	},
}

local niggerMap = Action()

function niggerMap.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lang = getPlayerLanguage(player)
	config = lang_to_config[lang]

	local x = 6677
	local y = 967
	local playerPosition = player:getPosition()
	local xRes = x - playerPosition.x
	local yRes = y - playerPosition.y
	if xRes > 0 then
		if yRes > 0 then
			doCreatureSay(player, config["SE"], TALKTYPE_ORANGE_1)
		elseif yRes < 0 then
			doCreatureSay(player, config["NE"], TALKTYPE_ORANGE_1)
		else
			doCreatureSay(player, config["E"], TALKTYPE_ORANGE_1)
		end
	elseif xRes < 0 then
		if yRes > 0 then
			doCreatureSay(player, config["SW"], TALKTYPE_ORANGE_1)
		elseif yRes < 0 then
			doCreatureSay(player, config["NW"], TALKTYPE_ORANGE_1)
		else
			doCreatureSay(player, config["W"], TALKTYPE_ORANGE_1)
		end
	else
		if yRes > 0 then
			doCreatureSay(player, config["S"], TALKTYPE_ORANGE_1)
		elseif yRes < 0 then
			doCreatureSay(player, config["N"], TALKTYPE_ORANGE_1)
		else
			doCreatureSay(player, config["X"], TALKTYPE_ORANGE_1)
		end
	end
	return true
end

niggerMap:aid(11082)
niggerMap:register()

local szczuroMap = Action()

function szczuroMap.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lang = getPlayerLanguage(player)
	config = lang_to_config[lang]

	local x = 6184
	local y = 1019
	local playerPosition = player:getPosition()
	local xRes = x - playerPosition.x
	local yRes = y - playerPosition.y
	if xRes > 0 then
		if yRes > 0 then
			doCreatureSay(player, config["SE"], TALKTYPE_ORANGE_1)
		elseif yRes < 0 then
			doCreatureSay(player, config["NE"], TALKTYPE_ORANGE_1)
		else
			doCreatureSay(player, config["E"], TALKTYPE_ORANGE_1)
		end
	elseif xRes < 0 then
		if yRes > 0 then
			doCreatureSay(player, config["SW"], TALKTYPE_ORANGE_1)
		elseif yRes < 0 then
			doCreatureSay(player, config["NW"], TALKTYPE_ORANGE_1)
		else
			doCreatureSay(player, config["W"], TALKTYPE_ORANGE_1)
		end
	else
		if yRes > 0 then
			doCreatureSay(player, config["S"], TALKTYPE_ORANGE_1)
		elseif yRes < 0 then
			doCreatureSay(player, config["N"], TALKTYPE_ORANGE_1)
		else
			doCreatureSay(player, config["X"], TALKTYPE_ORANGE_1)
		end
	end
	return true
end

szczuroMap:aid(11083)
szczuroMap:register()
