local config = {
	[8894] = { -- heavily rusted armor
		[1] = { id = 3358, chance = 8924 }, -- chain armor
		[2] = { id = 3377, chance = 4952 }, -- scale armor
		[3] = { id = 3359, chance = 3502 }, -- brass armor
		[4] = { id = 3357, chance = 1497 }, -- plate armor
		[5] = { id = 17829, chance = 637 }, -- buckle
		[7] = { id = 3402, chance = 200 }, -- native armor
	},
	[8895] = { -- rusted armor
		[1] = { id = 3377, chance = 8737 }, -- scale armor
		[2] = { id = 3359, chance = 7329 }, -- brass armor
		[3] = { id = 3357, chance = 5559 }, -- plate armor
		[4] = { id = 3370, chance = 3595 }, -- knight armor
		[5] = { id = 3381, chance = 1749 }, -- crown armor
		[6] = { id = 8063, chance = 683 }, -- paladin armor
		[7] = { id = 3360, chance = 449 }, -- golden armor
		[8] = { id = 7993, chance = 198 }, -- Witchhunter's Coat
	},
	[8896] = { -- slightly rusted armor
		[1] = { id = 3357, chance = 8967 }, -- plate armor
		[2] = { id = 3370, chance = 4832 }, -- knight armor
		[3] = { id = 3567, chance = 1377 }, -- blue robe
		[4] = { id = 8063, chance = 818 }, -- paladin armor
		[5] = { id = 3360, chance = 509 }, -- golden armor
		[6] = { id = 25779, chance = 225 }, -- Swan Feather Cloak
	},
	[8897] = { -- heavily rusted legs
		[1] = { id = 3558, chance = 9549 }, -- chain legs
		[2] = { id = 3372, chance = 7307 }, -- brass legs
		[3] = { id = 3557, chance = 5133 }, -- plate legs
	},
	[8898] = { -- rusted legs
		[1] = { id = 3372, chance = 9174 }, -- brass legs
		[2] = { id = 3557, chance = 6242 }, -- plate legs
		[3] = { id = 3371, chance = 2286 }, -- knight legs
		[4] = { id = 21168, chance = 886 }, -- Alloy Legs
	},
	[8899] = { -- slightly rusted legs
		[1] = { id = 3557, chance = 9800 }, -- plate legs
		[2] = { id = 3382, chance = 4002 }, -- crown legs
		[3] = { id = 3364, chance = 850 }, -- golden legs
		[4] = { id = 14087, chance = 680 }, -- Grasshopper Legs
	},
	[8902] = { -- slightly rusted shield
		[1] = { id = 3432, chance = 8887 }, -- ancient shield
		[2] = { id = 7460, chance = 6929 }, -- norse shield
		[3] = { id = 3419, chance = 4523 }, -- crown shield
		[4] = { id = 3434, chance = 1210 }, -- vampire shield
		[5] = { id = 3438, chance = 610 }, -- eagle shield
		[6] = { id = 8076, chance = 438 }, -- Spellscroll of Prophecies
	},
	[8907] = { -- rusted helmet
		[1] = { id = 3353, chance = 8490 }, -- iron helmet
		[2] = { id = 3351, chance = 6010 }, -- steel helmet
		[3] = { id = 3385, chance = 4190 }, -- crown helmet
		[4] = { id = 3391, chance = 2210 }, -- crusader helmet
		[5] = { id = 5460, chance = 1210 }, -- Helmet of the Deep
	},
	[8908] = { -- slightly rusted helmet
		[1] = { id = 3351, chance = 9676 }, -- steel helmet
		[2] = { id = 3385, chance = 7263 }, -- crown helmet
		[3] = { id = 3391, chance = 5210 }, -- crusader helmet
		[4] = { id = 3392, chance = 817 }, -- royal helmet
		[5] = { id = 10451, chance = 377 }, -- Jade Hat
	},
}

local rustRemover = Action()

function rustRemover.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetItem = config[target.itemid]
	if not targetItem then
		return true
	end

	local randomChance = math.random(10000)
	local index = false

	if targetItem[1].chance >= randomChance then
		while not index do
			local randomIndex = math.random(#targetItem)
			if targetItem[randomIndex].chance >= randomChance then
				index = randomIndex
			end
		end
	end

	if not index then
		local msg = nil
		if table.contains({ 8894, 8895, 8896 }, target.itemid) then
			msg = "The armor was already damaged so badly that it broke when you tried to clean it."
		elseif table.contains({ 8897, 8898, 8899 }, target.itemid) then
			msg = "The legs were already damaged so badly that they broke when you tried to clean them."
		elseif table.contains({ 8902 }, target.itemid) then
			msg = "The shield was already damaged so badly that it broke when you tried to clean it."
		elseif table.contains({ 8907, 8908 }, target.itemid) then
			msg = "The helmet was already damaged so badly that it broke when you tried to clean it."
		end

		player:say(msg, TALKTYPE_MONSTER_SAY)
		target:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
		target:remove()
	else
		target:transform(targetItem[index].id)
		target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:addAchievementProgress("Polisher", 1000)
	end

	item:remove(1)
	return true
end

rustRemover:id(9016)
rustRemover:register()
