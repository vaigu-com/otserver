local feature = TalkAction("!autoloot")

local validValues = {
	-- "all",
	"on",
	"off",
}

local function playerCanUseAutoloot(player)
	if configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) then
		return false
	end
	if configManager.getBoolean(configKeys.VIP_AUTOLOOT_VIP_ONLY) then
		return false
	end
	if not player:isVip() then
		return false
	end

	return true
end

function feature.onSay(player, words, param)
	if not configManager.getBoolean(configKeys.AUTOLOOT) then
		return true
	end
	
	if not playerCanUseAutoloot(player) then
		player:sendCancelMessage("You need to be VIP to use this command!")
		return
	end

	if not table.contains(validValues, param) then
		local validValuesStr = table.concat(validValues, "/")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Invalid param specified. Usage: !feature [" .. validValuesStr .. "]")
		return true
	end

	if param == "all" then
		player:setFeature(Features.AutoLoot, 2)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "AutoLoot is now enabled for all kills (including bosses).")
	elseif param == "on" then
		player:setFeature(Features.AutoLoot, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "AutoLoot is now enabled for all regular kills (no bosses).")
	elseif param == "off" then
		player:setFeature(Features.AutoLoot, 0)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "AutoLoot is now disabled.")
	end
	return true
end

feature:separator(" ")
feature:groupType("normal")
feature:register()
