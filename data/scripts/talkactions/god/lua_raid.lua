local luaRaid = TalkAction("/luaraid")

function luaRaid.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end

    local result = StartRaid(param)
    if result == false then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Could not find a raid with that name.")
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Raid Started.")
    end
    return false
end

luaRaid:separator(" ")
luaRaid:groupType("gamemaster")
luaRaid:register()