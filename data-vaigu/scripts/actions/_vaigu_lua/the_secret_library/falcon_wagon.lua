local teleportplayer = { x = 6346, y = 1897, z = 9 } --

local falconWagon1 = Action()

function falconWagon1.onUse(player, item, frompos, item2, topos)
	player:teleportTo(teleportplayer)
	item:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

falconWagon1:uid(7953)
falconWagon1:register()

local teleportplayer2 = { x = 6351, y = 1876, z = 9 } --

local falconWagon2 = Action()

function falconWagon2.onUse(player, item, frompos, item2, topos)
	player:teleportTo(teleportplayer2)
	item:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

falconWagon2:uid(7954)
falconWagon2:register()
