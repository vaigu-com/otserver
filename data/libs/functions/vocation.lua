VOCATION = {
	ID = {
		NONE = 0,
		SORCERER = 1,
		DRUID = 2,
		PALADIN = 3,
		KNIGHT = 4,
		MASTER_SORCERER = 5,
		ELDER_DRUID = 6,
		ROYAL_PALADIN = 7,
		ELITE_KNIGHT = 8,
	},
	CLIENT_ID = {
		NONE = 0,
		KNIGHT = 1,
		PALADIN = 2,
		SORCERER = 3,
		DRUID = 4,
		ELITE_KNIGHT = 11,
		ROYAL_PALADIN = 12,
		MASTER_SORCERER = 13,
		ELDER_DRUID = 14,
	},
	BASE_ID = {
		NONE = 0,
		SORCERER = 1,
		DRUID = 2,
		PALADIN = 3,
		KNIGHT = 4,
	},
}

function Vocation.getBase(self)
	local base = self
	while base:getDemotion() do
		base = base:getDemotion()
	end
	return base
end

-- Vaigu custom
-- If player if of vocation
VOCATION_CHECKER = {
	[VOCATION.ID.DRUID] = Player.isDruid,
	[VOCATION.ID.ELDER_DRUID] = Player.isDruid,
	[VOCATION.ID.KNIGHT] = Player.isKnight,
	[VOCATION.ID.ELITE_KNIGHT] = Player.isKnight,
	[VOCATION.ID.SORCERER] = Player.isSorcerer,
	[VOCATION.ID.MASTER_SORCERER] = Player.isSorcerer,
	[VOCATION.ID.PALADIN] = Player.isPaladin,
	[VOCATION.ID.ROYAL_PALADIN] = Player.isPaladin,
}
function Player:isVocation(vocation)
	return VOCATION_CHECKER[vocation](self)
end
