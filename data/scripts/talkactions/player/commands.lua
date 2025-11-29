local function getPermittedCommands(player)
	local playerGroupId = player:getGroup():getId()
	local allTalkActions = Game.getTalkActions()

	local commands = {}
	for _, talkaction in pairs(allTalkActions) do
		if talkaction:getGroupType() ~= 0 then
			if talkaction:getGroupType() <= playerGroupId then
				table.insert(commands, talkaction)
			end
		end
	end
	return commands
end

local function buildAvailableCommandsText(talkActionsData)
	local text = "Available commands:\n\n"
	for key, talkActionData in pairs(talkActionsData) do
		text = text .. talkActionData.name .. talkActionData.description
	end
	return text
end

local commands = TalkAction("!commands")

function commands.onSay(player, words, param)
	local talkActionsData = {}

	for _, talkaction in pairs(getPermittedCommands(player)) do
		table.insert(talkActionsData, { name = talkaction:getName(), description = " " .. (talkaction:getDescription() or "") })
	end

	table.sort(talkActionsData, function(a, b)
		return a.name > b.name
	end)

	player:showTextDialog(639, buildAvailableCommandsText(talkActionsData))

	return true
end

commands:setDescription("[Usage]: !commands to see each command with its description")
commands:groupType("normal")
commands:register()
