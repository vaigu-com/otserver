local config = {
	[7738] = {
		storage = GlobalStorage.ElementalSphere.KnightBoss,
		corpse = 8139,
		charged = 2126,
		inactive = 0,
		boss = "Energy Overlord",
		effect = CONST_ME_BIGCLOUDS,
		summonPos = Position(6098, 1063, 12), --{x = 6098, y = 1063, z = 12}
		positions = {
			Position(6097, 1058, 12), --{x = 6097, y = 1058, z = 12}
			Position(6100, 1058, 12), --{x = 6100, y = 1058, z = 12}
			Position(6102, 1060, 12), --{x = 6102, y = 1060, z = 12}
			Position(6102, 1063, 12), --{x = 6102, y = 1063, z = 12}
			Position(6100, 1065, 12), --{x = 6100, y = 1065, z = 12}
			Position(6097, 1065, 12), --{x = 6097, y = 1065, z = 12}
			Position(6095, 1063, 12), --{x = 6095, y = 1063, z = 12}
			Position(6095, 1060, 12), --{x = 6095, y = 1060, z = 12}
		},
	},
	[7739] = {
		storage = GlobalStorage.ElementalSphere.SorcererBoss,
		corpse = 8141,
		charged = 7745,
		inactive = 7743,
		boss = "Fire Overlord",
		effect = CONST_ME_FIREAREA,
		summonPos = Position(6202, 972, 12), --{x = 6202, y = 972, z = 12}
		positions = {
			Position(6201, 971, 12), --{x = 6201, y = 971, z = 12}
			Position(6204, 971, 12), --{x = 6204, y = 971, z = 12}
			Position(6206, 973, 12), --{x = 6206, y = 973, z = 12}
			Position(6206, 976, 12), --{x = 6206, y = 976, z = 12}
			Position(6204, 978, 12), --{x = 6204, y = 978, z = 12}
			Position(6201, 978, 12), --{x = 6201, y = 978, z = 12}
			Position(6199, 976, 12), --{x = 6199, y = 976, z = 12}
			Position(6199, 973, 12), --{x = 6199, y = 973, z = 12}
		},
	},
	[7740] = {
		storage = GlobalStorage.ElementalSphere.PaladinBoss,
		corpse = 8140,
		charged = 7744,
		inactive = 7741,
		boss = "Ice Overlord",
		effect = CONST_ME_ICETORNADO,
		summonEffect = CONST_ME_ICEAREA,
		summonPos = Position(6289, 971, 12), --{x = 6289, y = 971, z = 12}
		positions = {
			Position(6288, 966, 12), --{x = 6288, y = 966, z = 12}
			Position(6291, 966, 12), --{x = 6291, y = 966, z = 12}
			Position(6293, 968, 12), --{x = 6293, y = 968, z = 12}
			Position(6293, 971, 12), --{x = 6293, y = 971, z = 12}
			Position(6291, 973, 12), --{x = 6291, y = 973, z = 12}
			Position(6288, 973, 12), --{x = 6288, y = 973, z = 12}
			Position(6286, 971, 12), --{x = 6286, y = 971, z = 12}
			Position(6286, 968, 12), --{x = 6286, y = 968, z = 12}
		},
	},
	[7748] = {
		storage = GlobalStorage.ElementalSphere.DruidBoss,
		corpse = 8106,
		charged = 7746,
		inactive = 7742,
		boss = "Earth Overlord",
		effect = CONST_ME_BIGPLANTS,
		summonPos = Position(6350, 1077, 12), --{x = 6350, y = 1077, z = 12}
		positions = {
			Position(6349, 1072, 12), --{x = 6349, y = 1072, z = 12}
			Position(6352, 1072, 12), --{x = 6352, y = 1072, z = 12}
			Position(6354, 1074, 12), --{x = 6354, y = 1074, z = 12}
			Position(6354, 1077, 12), --{x = 6354, y = 1077, z = 12}
			Position(6352, 1079, 12), --{x = 6352, y = 1079, z = 12}
			Position(6349, 1079, 12), --{x = 6349, y = 1079, z = 12}
			Position(6347, 1077, 12), --{x = 6347, y = 1077, z = 12}
			Position(6347, 1074, 12), --{x = 6347, y = 1074, z = 12}
		},
	},
}
local movement = MoveEvent()

function movement:onAddItem(moveitem, tileitem, position)
	local target = config[tileitem.itemid]
	if not target then
		return true
	end

	local cStorage = target.storage
	if target.corpse ~= moveitem.itemid or Game.getStorageValue(cStorage) == 1 then
		return true
	end

	for i = 1, #target.positions do
		if not Tile(target.positions[i]):getItemById(target.charged) then
			return true
		end
	end

	moveitem:remove()
	position:sendMagicEffect(target.effect)
	target.summonPos:sendMagicEffect(target.summonEffect or target.effect)
	Game.createMonster(target.boss, target.summonPos)
	Game.setStorageValue(cStorage, 1)
	return true
end

movement:type("additem")
movement:id(7738, 7739, 7740, 7748)
movement:register()
