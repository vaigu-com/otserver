local ACTION_RUN, ACTION_BREAK, ACTION_NONE, ACTION_ALL = 1, 2, 3, 4
local TYPE_MONSTER, TYPE_NPC, TYPE_ITEM, TYPE_ACTION, TYPE_UNIQUE = 1, 2, 3, 4, 5

local config = {
	[5907] = { NAME = "Bear", ID = 3, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = true, FAIL_MSG = { { 1, "The bear ran away." }, { 2, "Oh no! The slingshot broke." }, { 3, "The bear is trying to hit you with its claws." } }, SUCCESS_MSG = "You have tamed the bear." }, --moze zniknac item
	[12308] = { NAME = "Black Sheep", ID = 4, TYPE = TYPE_MONSTER, CHANCE = 25, BREAK = true, FAIL_MSG = { { 1, "The black sheep ran away." }, { 2, "Oh no! The reins were torn." }, { 3, "The black sheep is trying to run away." } }, SUCCESS_MSG = "You have tamed the sheep." }, --moze zniknac item
	[12306] = { NAME = "Midnight Panther", ID = 5, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "The panther has escaped." }, { 2, "The whip broke." } }, SUCCESS_MSG = "You have tamed the panther." }, --moze zniknac item
	[12311] = { NAME = "Terror Bird", ID = 2, TYPE = TYPE_MONSTER, CHANCE = 15, BREAK = true, FAIL_MSG = { { 1, "The bird ran away." }, { 3, "The terror bird is pecking you." } }, SUCCESS_MSG = "You have tamed the bird." },
	[12260] = { NAME = "Boar", ID = 10, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "The boar has run away" }, { 3, "The boar attacks you." } }, SUCCESS_MSG = "You have tamed the boar." },
	[12318] = { NAME = "Crustacea Gigantica", ID = 7, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "The crustacea has run away." }, { 3, "The gigantic creature is trying to pinch you." } }, SUCCESS_MSG = "You have tamed the crustacea." },
	[12304] = { NAME = "Undead Cavebear", ID = 12, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "The undead bear has run away." } }, SUCCESS_MSG = "You have tamed the skeleton." },
	[12320] = { NAME = "Wailing Widow", ID = 1, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "The widow has run away." }, { 2, "The widow has eaten the sweet bait." } }, SUCCESS_MSG = "You have tamed the widow." }, --moze zniknac item
	--[12305]	=	{NAME = 'Inoperative Tin Lizzard',		ID = 8,	TYPE = TYPE_ITEM,	CHANCE = 70,	BREAK = true,	FAIL_MSG = { {2, 'The key broke inside.'} }, SUCCESS_MSG = 'You wind up the tin lizzard.'},	--moze zniknac item
	[12307] = { NAME = "Draptor", ID = 6, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "The draptor has run away." }, { 3, "The draptor has fled." } }, SUCCESS_MSG = "You have tamed the draptor." },
	[12547] = { NAME = "Crystal Wolf", ID = 16, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "The wolf has run away." } }, SUCCESS_MSG = "You have tamed the wolf." },
	[12550] = { NAME = "Enraged White Deer", ID = 18, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 2, "The cone broke." }, { 3, "The deer has fled in fear." } }, SUCCESS_MSG = "You have tamed the deer." }, --moze zniknac item
	[12549] = { NAME = "Panda", ID = 19, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 4, "Panda ate the leaves and ran away." } }, SUCCESS_MSG = "You have tamed the panda." }, --moze zniknac item
	[12546] = { NAME = "Dromedary", ID = 20, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "Dromedary has run away." } }, SUCCESS_MSG = "You have tamed the dromedary." },
	[12509] = { NAME = "Sandstone Scorpion", ID = 21, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "The scorpion has vanished." } }, SUCCESS_MSG = "You have tamed the scorpion." },
	[12548] = { NAME = "Donkey", ID = 13, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "You did not manage to feed the donkey enough apple slices." } }, SUCCESS_MSG = "You have tamed the mule." },
	--[12801]	=	{NAME = 'Inoperative Uniwheel',	ID = 15,	TYPE = TYPE_ITEM,		CHANCE = 40,	BREAK = true,	FAIL_MSG = { {3, 'The oil have no effect.'} }, SUCCESS_MSG = 'The strange wheel seems to vibrate and slowly starts turning continuously.'},
	[12519] = { NAME = "Slug", ID = 14, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = true, FAIL_MSG = { { 1, "The slug has run away." }, { 3, "The drug had no effect." } }, SUCCESS_MSG = "You have tamed the slug." },
	[12802] = { NAME = "Wild Horse", ID = 17, TYPE = TYPE_MONSTER, CHANCE = 15, BREAK = true, FAIL_MSG = { { 1, "The horse runs away." }, { 2, "The horse ate the oats." } }, SUCCESS_MSG = "You have tamed the horse." }, --moze zniknac item
	[14142] = { NAME = "Manta Ray", ID = 28, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = true, FAIL_MSG = { { 1, "The manta ray fled." }, { 3, "The manta ray is trying to escape." } }, SUCCESS_MSG = "You have tamed the manta ray." },
	[14143] = { NAME = "Ladybug", ID = 27, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = true, FAIL_MSG = { { 1, "The ladybug got scared and ran away." }, { 3, "The ladybug is trying to nibble." } }, SUCCESS_MSG = "You tame a lady bug." },
	[16153] = { NAME = "Ironblight", ID = 29, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = true, FAIL_MSG = { { 1, "The ironblight managed to run away." }, { 2, "Oh no! The magnet lost its power!" }, { 3, "The ironblight is fighting against the magnetic force." } }, SUCCESS_MSG = "You tamed the ironblight." }, --moze zniknac item
	[16155] = { NAME = "Dragonling", ID = 31, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = true, FAIL_MSG = { { 1, "The dragonling got scared and ran away." }, { 3, "The dragonling is trying to nibble." } }, SUCCESS_MSG = "You tamed a dragonling." },
	[16154] = { NAME = "Magma Crawler", ID = 30, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = true, FAIL_MSG = { { 4, "The magma crawler refused to drink wine and vanishes into thin air." } }, SUCCESS_MSG = "The magma crawler will accompany you as a friend from now on." }, --moze zniknac item
	[16251] = { NAME = "Modified Gnarlhound", ID = 32, TYPE = TYPE_MONSTER, CHANCE = 100, BREAK = false, FAIL_MSG = {}, SUCCESS_MSG = "You now own a modified gnarlhound." },
	[19136] = { NAME = "Gravedigger", ID = 39, TYPE = TYPE_MONSTER, CHANCE = 40, BREAK = false, FAIL_MSG = { { 1, "The gravedigger got scared and ran away." }, { 3, "The gravedigger is trying to nibble." } }, SUCCESS_MSG = "You tamed the hellgrip." },
	[17858] = { NAME = "Water Buffalo", ID = 35, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = true, FAIL_MSG = { { 1, "The water buffalo got scared and ran away." }, { 3, "The water buffalo is trying to nibble." } }, SUCCESS_MSG = "You tamed a water buffalo." },
	[20274] = { NAME = "Shock Head", ID = 42, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = true, FAIL_MSG = { { 1, "The shock head ran away." }, { 3, "The shock head is growling at you." } }, SUCCESS_MSG = "You tamed the shock head." },
	[21186] = { NAME = "Walker", ID = 43, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = true, FAIL_MSG = { { 4, "This walker is incompatible with your control unit." } }, SUCCESS_MSG = "You tamed the walker." }, --moze zniknac item
	[21439] = { NAME = "Noble Lion", ID = 40, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = false, FAIL_MSG = { { 1, "The lion got scared and ran away." }, { 3, "The lion is trying to nibble." } }, SUCCESS_MSG = "You tamed the lion." },
	[27605] = { NAME = "Mole", ID = 119, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = true, FAIL_MSG = { { 1, "The mole is a bit capricious. Maybe I should leave it alone." } }, SUCCESS_MSG = "You have tamed a mole." },
	[28791] = { NAME = "Flying Book", ID = 126, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = false, FAIL_MSG = { { 1, "Flying book disappeared." } }, SUCCESS_MSG = "You have converted your library ticket and receive permission to ride a flying book." },
	[30170] = { NAME = "Lacewing Moth", ID = 130, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = false, FAIL_MSG = { { 1, "The lacewing moth is not interested in your lantern and flies away." } }, SUCCESS_MSG = "You have tamed a lancewing moth." },
	[30171] = { NAME = "Hibernal Moth", ID = 131, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = false, FAIL_MSG = { { 1, "The hibernal moth is not interested in your lantern and runs away." } }, SUCCESS_MSG = "You have tamed a hibernal moth." },
	[31576] = { NAME = "Gryphon", ID = 144, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = false, FAIL_MSG = { { 1, "Gryphon has run away." } }, SUCCESS_MSG = "You have tamed the gryphon." },
	[24960] = { NAME = "Stone Rhino", ID = 106, TYPE = TYPE_MONSTER, CHANCE = 30, BREAK = false, FAIL_MSG = { { 1, "The stone rhino ran away." }, { 3, "The stone rhino is growling at you." } }, SUCCESS_MSG = "You tamed the stone rhino." },
	[34258] = { NAME = "White Lion", ID = 174, TYPE = TYPE_MONSTER, CHANCE = 50, BREAK = true, FAIL_MSG = { { 1, "The White Lion runs away." }, { 2, "The White Lion ate the flower." } }, SUCCESS_MSG = "You have tamed the white lion.", ACHIEV = "Well Roared, Lion!" },
}

local function doFailAction(cid, mount, pos, item, itemEx, loseItem)
	local action, effect = mount.FAIL_MSG[math.random(#mount.FAIL_MSG)], CONST_ME_POFF
	if action[1] == ACTION_RUN then
		Creature(itemEx.uid):remove()
	elseif action[1] == ACTION_BREAK then
		effect = CONST_ME_BLOCKHIT
		if loseItem then
			Item(item.uid):remove(1)
		end
	elseif action[1] == ACTION_ALL then
		Creature(itemEx.uid):remove()
		if loseItem then
			Item(item.uid):remove(1)
		end
	end

	pos:sendMagicEffect(effect)
	Player(cid):say(action[2], TALKTYPE_MONSTER_SAY)
	return action
end

local mounts = Action()

function mounts.onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	local targetMonster = Monster(itemEx.uid)
	local targetNpc = Npc(itemEx.uid)
	local targetItem = Item(itemEx.uid)
	local mount = config[item.itemid]
	if mount == nil or player:hasMount(mount.ID) then
		return false
	end

	local rand = math.random(100)
	--Monster Mount
	if targetMonster ~= nil and mount.TYPE == TYPE_MONSTER then
		if Creature(itemEx.uid):getMaster() then
			player:say("You can't tame a summon!", TALKTYPE_MONSTER_SAY)
			return true
		end

		if mount.NAME == targetMonster:getName() then
			if rand > mount.CHANCE then
				doFailAction(cid, mount, toPosition, item, itemEx, mount.BREAK)
				return true
			end
			if mount.ACHIEV then
				player:addAchievement(mount.ACHIEV)
			end
			player:addAchievement("Jestem koniem")
			player:addMount(mount.ID)
			player:say(mount.SUCCESS_MSG, TALKTYPE_MONSTER_SAY)
			targetMonster:remove()
			toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			Item(item.uid):remove(1)
			return true
		end
	--NPC Mount
	elseif targetNpc ~= nil and mount.TYPE == TYPE_NPC then
		if mount.NAME == targetNpc:getName() then
			if rand > mount.CHANCE then
				doFailAction(cid, mount, toPosition, item, itemEx, mount.BREAK)
				return true
			end
			if mount.ACHIEV then
				player:addAchievement(mount.ACHIEV)
			end
			player:addAchievement("Jestem koniem")
			player:addMount(mount.ID)
			player:say(mount.SUCCESS_MSG, TALKTYPE_MONSTER_SAY)
			toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			Item(item.uid):remove(1)
			return true
		end
	--Item Mount
	elseif targetItem ~= nil and mount.TYPE == TYPE_ITEM then
		if mount.NAME == targetItem:getName() then
			if rand > mount.CHANCE then
				doFailAction(cid, mount, toPosition, item, itemEx, mount.BREAK)
				return true
			end
			if mount.ACHIEV then
				player:addAchievement(mount.ACHIEV)
			end
			player:addAchievement("Jestem koniem")
			player:addMount(mount.ID)
			player:say(mount.SUCCESS_MSG, TALKTYPE_MONSTER_SAY)
			toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			Item(item.uid):remove(1)
			return true
		end
	--Action Mount
	elseif itemEx.actionid > 0 and mount.TYPE == TYPE_ACTION then
		if mount.NAME == itemEx.actionid then
			if rand > mount.CHANCE then
				doFailAction(cid, mount, toPosition, item, itemEx, mount.BREAK)
				return true
			end
			if mount.ACHIEV then
				player:addAchievement(mount.ACHIEV)
			end
			player:addAchievement("Jestem koniem")
			player:addMount(mount.ID)
			player:say(mount.SUCCESS_MSG, TALKTYPE_MONSTER_SAY)
			toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			Item(item.uid):remove(1)
			return true
		end
	--Unique Mount
	elseif itemEx.uid <= 65535 and mount.TYPE == TYPE_UNIQUE then
		if mount.NAME == itemEx.uid then
			if rand > mount.CHANCE then
				doFailAction(cid, mount, toPosition, item, itemEx, mount.BREAK)
				return true
			end
			if mount.ACHIEV then
				player:addAchievement(mount.ACHIEV)
			end
			player:addAchievement("Jestem koniem")
			player:addMount(mount.ID)
			player:say(mount.SUCCESS_MSG, TALKTYPE_MONSTER_SAY)
			toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			Item(item.uid):remove(1)
			return true
		end
	end
	return false
end

for index, value in pairs(config) do
	mounts:id(index)
end

mounts:register()
