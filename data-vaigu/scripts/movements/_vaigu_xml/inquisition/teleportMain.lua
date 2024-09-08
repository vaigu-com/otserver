local teleports = {
	[2150] = { text = "Entering Ushuriel's ward.", newPos = Position(6764, 1824, 10), storage = 0, alwaysSetStorage = true }, -- to ushuriel ward {x = 6730, y = 1788, z = 10} {x = 6764, y = 1824, z = 10}
	[2151] = { text = "Entering the Crystal Caves.", bossStorage = GlobalStorage.ushurielTimer, newPos = Position(6675, 1878, 12), storage = 1 }, -- from ushuriel ward {x = 6675, y = 1878, z = 12}
	[2152] = { text = "Escaping back to the Retreat.", newPos = Position(6771, 1805, 13) }, -- from crystal caves {x = 6771, y = 1805, z = 13}
	[2153] = { text = "Entering the Crystal Caves.", newPos = Position(6675, 1879, 12), storage = 1 }, -- to crystal caves {x = 6675, y = 1878, z = 12}
	[2154] = { text = "Entering the Sunken Caves.", newPos = Position(6775, 1851, 12) }, -- to sunken caves {x = 6775, y = 1851, z = 12}
	[2155] = { text = "Entering the Mirror Maze of Madness.", newPos = Position(6671, 1868, 9) }, -- from sunken caves {x = 6671, y = 1868, z = 9}
	[2156] = { text = "Entering Zugurosh's ward.", newPos = Position(6730, 1788, 10) }, -- to zugurosh ward {x = 6730, y = 1788, z = 10}
	[2157] = { text = "Entering the Blood Halls.", bossStorage = GlobalStorage.zuguroshTimer, newPos = Position(6978, 1709, 13), storage = 2 }, -- from zugurosh ward {x = 6978, y = 1709, z = 13}
	[2158] = { text = "Escaping back to the Retreat.", newPos = Position(6771, 1805, 13) }, -- from blood halls
	[2159] = { text = "Entering the Blood Halls.", newPos = Position(6978, 1709, 13), storage = 2 }, -- to blood halls {x = 6978, y = 1709, z = 13}
	[2160] = { text = "Entering the Foundry.", newPos = Position(6962, 1685, 10) }, -- to foundry {x = 6962, y = 1685, z = 10}
	[2161] = { text = "Entering Madareth's ward.", newPos = Position(6804, 1863, 10) }, -- to madareth ward {x = 6803, y = 1863, z = 10}
	[2162] = { text = "Entering the Vats.", bossStorage = GlobalStorage.madarethTimer, newPos = Position(6759, 1878, 11), storage = 3 }, -- from madareth ward {x = 6759, y = 1878, z = 11}
	[2163] = { text = "Escaping back to the Retreat.", newPos = Position(6771, 1805, 13) }, -- from vats
	[2164] = { text = "Entering the Vats.", newPos = Position(6759, 1878, 11), storage = 3 }, -- to vats {x = 6759, y = 1878, z = 11}
	[2165] = { text = "Entering the Battlefield.", newPos = Position(6856, 1728, 12) }, -- to battlefield {x = 6856, y = 1728, z = 12}
	[2166] = { text = "Entering the Vats.", newPos = Position(6839, 1854, 11) }, -- from battlefield {x = 6839, y = 1854, z = 11}
	[2167] = { text = "Entering the Demon Forge.", newPos = Position(6846, 1831, 10) }, -- to brothers ward {x = 6845, y = 1831, z = 10}
	[2168] = { text = "Entering the Arcanum.", bossStorage = GlobalStorage.latrivanTimer, newPos = Position(6687, 1922, 12), storage = 4 }, -- from demon forge {x = 6687, y = 1922, z = 12}
	[2169] = { text = "Escaping back to the Retreat.", newPos = Position(6771, 1805, 13) }, -- from arcanum
	[2170] = { text = "Entering the Arcanum.", newPos = Position(6687, 1922, 12), storage = 4 }, -- to arcanum {x = 6687, y = 1922, z = 12}
	[2171] = { text = "Entering the Soul Wells.", newPos = Position(6699, 1671, 10) }, -- to soul wells {x = 6699, y = 1671, z = 10}
	[2172] = { text = "Entering the Arcanum.", newPos = Position(6835, 1928, 12) }, -- from soul wells {x = 6835, y = 1928, z = 12}
	[2173] = { text = "Entering the Annihilon's ward.", newPos = Position(6803, 1799, 10) }, -- to annihilon ward  {x = 6803, y = 1799, z = 10}
	[2174] = { text = "Entering the Hive.", bossStorage = GlobalStorage.annihilonTimer, newPos = Position(6806, 1782, 11), storage = 5 }, -- from annihilon ward {x = 6803, y = 1799, z = 10}
	[2175] = { text = "Escaping back to the Retreat.", newPos = Position(6771, 1805, 13) }, -- from hive
	[2176] = { text = "Entering the Hive.", newPos = Position(6806, 1782, 11), storage = 5 }, -- to hive {x = 6805, y = 1782, z = 11}
	[2177] = { text = "Entering the Hellgorak's ward.", newPos = Position(6710, 1830, 10) }, -- to hellgorak ward {x = 6710, y = 1830, z = 10}
	[2178] = { text = "Entering the Shadow Nexus. Abandon all Hope.", bossStorage = GlobalStorage.hellgorakTimer, newPos = Position(6716, 1778, 11), storage = 6 }, -- from hellgorak ward {x = 6716, y = 1778, z = 11}
	[2179] = { text = "Escaping back to the Retreat.", newPos = Position(6771, 1805, 13) }, -- from shadow nexus
	[2180] = { text = "Entering the Blood Halls.", newPos = Position(6964, 1684, 11) }, -- from foundry to blood halls {x = 6964, y = 1684, z = 11}
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = teleports[item.uid]
	if teleport.alwaysSetStorage and player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
		player:setStorageValue(Storage.TheInquisition.EnterTeleport, teleport.storage)
	end

	if teleport.bossStorage then
		if item.uid == 2168 then
		end
		if Game.getStorageValue(teleport.bossStorage) == 2 then
			if player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
				if item.uid == 2168 then
				end
				player:setStorageValue(Storage.TheInquisition.EnterTeleport, teleport.storage)
			end
		else
			player:teleportTo(Position(6771, 1805, 13))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:say("Powracasz..", TALKTYPE_MONSTER_SAY)
			return true
		end
	elseif teleport.storage and player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("Nie posiadasz wystarczajacej energii, aby wejsc w portal.", TALKTYPE_MONSTER_SAY)
		return true
	end

	if player:getCondition(CONDITION_DROWN) then
		player:removeCondition(CONDITION_DROWN)
	end
	player:teleportTo(teleport.newPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:say(teleport.text, TALKTYPE_MONSTER_SAY)
	return true
end

movement:type("stepin")
for uniqueRange = 2150, 2180 do
	movement:uid(uniqueRange)
end
movement:register()
