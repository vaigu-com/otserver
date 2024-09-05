local teleportToCoords = TalkAction("/tp")

function teleportToCoords.onSay(player, words, param)
    local split = param:split(",")

    local x = tonumber(split[1])
    local y = tonumber(split[2])
    local z = tonumber(split[3])

    local toPos = Position(x, y, z)
    player:teleportTo(toPos)
    return false
end


teleportToCoords:separator(" ")
teleportToCoords:groupType("god")
teleportToCoords:register()
