local function nameToId(name)
	local itemTypeId = ItemType(name):getId()
	if itemTypeId == 0 then
		return nil
	end
	return itemTypeId
end

local createItem = TalkAction("/i")

function createItem.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)

	local split = param:split(",")

	local nameOrId = split[1]
	local count = tonumber(split[2])
	local tier = tonumber(split[3])

	local id = nameToId(nameOrId) or tonumber(nameOrId)

	if not id then
		player:sendCancelMessage("There is no item with that id or name.")
		return true
	end

	if id < 100 then
		player:sendCancelMessage("Item id <100 are reserved.")
		return true
	end

	if tier and (tier <= 0 or tier > 10) then
		player:sendCancelMessage("Tier has to be between 0 and 10.")
		return true
	end

	player:AddCustomItem({ id = id, count = count, fluidtype = count, tier = tier })

	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true
end

createItem:separator(" ")
createItem:groupType("god")
createItem:register()
