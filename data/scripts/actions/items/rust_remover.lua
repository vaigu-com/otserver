local config = {
	[8894] = { -- heavily rusted armor
		[1] = { id = 3358, chance = 9994 }, -- chain armor
		[2] = { id = 3377, chance = 5952 }, -- scale armor
		[3] = { id = 3359, chance = 3502 }, -- brass armor
		[4] = { id = 3357, chance = 1197 }, -- plate armor
		[5] = { id = 17829, chance = 437 }, -- buckle
		[7] = { id = 3402, chance = 100 }, -- native armor
	},
	[8895] = { -- rusted armor
		[1] = { id = 3377, chance = 10237 }, -- scale armor
		[2] = { id = 3359, chance = 9329 }, -- brass armor
		[3] = { id = 3357, chance = 7559 }, -- plate armor
		[4] = { id = 3370, chance = 3595 }, -- knight armor
		[5] = { id = 3381, chance = 1749 }, -- crown armor
		[6] = { id = 8063, chance = 683 }, -- paladin armor
		[7] = { id = 3360, chance = 449 }, -- golden armor
		[8] = { id = 7993, chance = 158 }, -- Witchhunter's Coat
	},
	[8896] = { -- slightly rusted armor
		[1] = { id = 3357, chance = 13767 }, -- plate armor
		[2] = { id = 3370, chance = 7832 }, -- knight armor
		[3] = { id = 3567, chance = 1677 }, -- blue robe
		[4] = { id = 8063, chance = 710 }, -- paladin armor
		[5] = { id = 3360, chance = 500 }, -- golden armor
		[6] = { id = 25779, chance = 145 }, -- Swan Feather Cloak
	},
	[8897] = { -- heavily rusted legs
		[1] = { id = 3558, chance = 16949 }, -- chain legs
		[2] = { id = 3372, chance = 11307 }, -- brass legs
		[3] = { id = 3557, chance = 8133 }, -- plate legs
	},
	[8898] = { -- rusted legs
		[1] = { id = 3372, chance = 12174 }, -- brass legs
		[2] = { id = 3557, chance = 8242 }, -- plate legs
		[3] = { id = 3371, chance = 2286 }, -- knight legs
		[4] = { id = 21168, chance = 586 }, -- Alloy Legs
	},
	[8899] = { -- slightly rusted legs
		[1] = { id = 3557, chance = 13800 }, -- plate legs
		[2] = { id = 3382, chance = 5002 }, -- crown legs
		[3] = { id = 3364, chance = 1130 }, -- golden legs
		[4] = { id = 14087, chance = 1130 }, -- Grasshopper Legs
	},
	[8902] = { -- slightly rusted shield
		[1] = { id = 3432, chance = 12887 }, -- ancient shield
		[2] = { id = 7460, chance = 8929 }, -- norse shield
		[3] = { id = 3419, chance = 5523 }, -- crown shield
		[4] = { id = 3434, chance = 1110 }, -- vampire shield
		[5] = { id = 3438, chance = 510 }, -- eagle shield
		[6] = { id = 8076, chance = 138 }, -- Spellscroll of Prophecies
	},
	[8907] = { -- rusted helmet
		[1] = { id = 3353, chance = 15490 }, -- iron helmet
		[2] = { id = 3351, chance = 10010 }, -- steel helmet
		[3] = { id = 3385, chance = 7190 }, -- crown helmet
		[4] = { id = 3391, chance = 4210 }, -- crusader helmet
		[5] = { id = 5460, chance = 1210 }, -- Helmet of the Deep
	},
	[8908] = { -- slightly rusted helmet
		[1] = { id = 3351, chance = 17976 }, -- steel helmet
		[2] = { id = 3385, chance = 11263 }, -- crown helmet
		[3] = { id = 3391, chance = 6210 }, -- crusader helmet
		[4] = { id = 3392, chance = 1027 }, -- royal helmet
		[5] = { id = 10451, chance = 177 }, -- Jade Hat
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
