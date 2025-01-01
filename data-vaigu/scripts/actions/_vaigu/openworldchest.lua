if not worldchests then
	worldchests = {}
end

if not table.find then
	table.find = function(table, value)
		for i, v in pairs(table) do
			if v == value then
				return i
			end
		end
		return nil
	end
end

function Container:clear()
	for i = 0, self:getItemHoldingCount() - 1 do
		self:getItem(0):remove()
	end
	return true
end

local interval = math.random(5400, 10800) -- pomiedzy 1,5 a 3h
local chestAid = 7895 -- actionid to assign in RME
local allowDuplicates = false -- for default setting

-- uid will serve as chest identificator. It will prevent moving the chest and will allow to make every chest script unique.

local elfrewards = {
	minUid = 27100,
	maxUid = 27199,
	maxItems = 6,
	itemList = {
		-- id, chance(100000 = 100.000%), countmax(default 1)
		{ 3600, 26000, 2 }, -- bread
		{ 3031, 60000, 80 }, -- gold coin
		{ 3592, 25000, 3 }, -- grapes
		{ 9635, 10000, 1 }, -- elvish talisman
		{ 11464, 10000, 1 }, -- elven scouting glass
		{ 3350, 10000, 1 }, -- bow
		{ 7438, 500, 1 }, -- elvish bow
		{ 3447, 15000, 20 }, -- arrow
		{ 7364, 9000, 15 }, -- sniper arrow
		{ 774, 9000, 15 }, -- earth arrow
		{ 16142, 7000, 15 }, -- drill bolt
		{ 268, 15000, 1 }, -- mana potion
		{ 3061, 1000, 1 }, -- life crystal
		{ 5921, 2500, 1 }, -- heaven blossom
		{ 5922, 2500, 1 }, -- holy orchid
		{ 3082, 3000, 50 }, -- elven amulet
		{ 646, 600, 1 }, -- elvenhair rope
		{ 3399, 300, 1 }, -- elven mail
		{ 3401, 800, 1 }, -- elven legs
		{ 3070, 600, 1 }, -- moonlight rod
		{ 3075, 600, 1 }, -- wand of dragonbreath
	},
}

local orcrewards = {
	minUid = 27200,
	maxUid = 27299,
	maxItems = 6,
	itemList = {
		{ 3112, 20000, 2 }, -- rotten meat
		{ 3307, 700, 1 }, -- scimitar
		{ 3552, 1000, 1 }, -- leather boots
		{ 3391, 100, 1 }, -- crusader helmet
		{ 3358, 2000, 1 }, -- chain armor
		{ 3577, 20000, 2 }, -- meat
		{ 3031, 60000, 80 }, -- gold coin
		{ 3426, 10000, 1 }, -- studded shield
		{ 3362, 10000, 1 }, -- studded legs
		{ 3378, 10000, 1 }, -- studded armor
		{ 11480, 15000, 1 }, -- skull belt
		{ 3557, 1000, 1 }, -- plate legs
		{ 2920, 14000, 1 }, -- torch
		{ 7378, 6000, 3 }, -- royal spear
		{ 3316, 2000, 1 }, -- orcish axe
		{ 3322, 400, 1 }, -- dragon hammer
	},
}

local dwarfrewards = {
	minUid = 27300,
	maxUid = 27399,
	maxItems = 6,
	itemList = {
		{ 3031, 60000, 80 }, -- gold coin
		{ 3552, 1000, 1 }, -- leather boots
		{ 3375, 4000, 1 }, -- soldier helmet
		{ 3358, 2000, 1 }, -- chain armor
		{ 3097, 4000, 1 }, -- dwarven ring
		{ 3425, 4000, 1 }, -- dwarven shield
		{ 3723, 20000, 3 }, -- white mushroom
		{ 5880, 800, 1 }, -- iron ore
		{ 3430, 4000, 1 }, -- copper shield
		{ 3266, 4000, 1 }, -- battle axe
		{ 3274, 10000, 1 }, -- axe
		{ 3456, 15000, 1 }, -- pick
		{ 953, 15000, 3 }, -- nail
		{ 3351, 2000, 1 }, -- steel helmet
		{ 12600, 4000, 2 }, -- coal
		{ 3092, 2000, 1 }, -- axe ring
		{ 266, 13000, 1 }, -- health potion
		{ 3349, 3000, 1 }, -- crossbow
		{ 7363, 13000, 10 }, -- piercing bolt
		{ 2894, 16000, 1 }, -- broken flask
		{ 2920, 30000, 1 }, -- torch
		{ 3003, 30000, 1 }, -- rope
		{ 3323, 400, 1 }, -- dwarven axe
	},
}

local cycrewards = {
	minUid = 27400,
	maxUid = 27499,
	maxItems = 6,
	itemList = {
		{ 3031, 60000, 80 }, -- gold coin
		{ 3012, 4000, 1 }, -- wolf tooth chain
		{ 3413, 3200, 1 }, -- battle shield
		{ 3269, 3200, 1 }, -- halberd
		{ 3093, 4000, 1 }, -- club ring
		{ 3092, 4000, 1 }, -- axe ring
		{ 236, 14000, 1 }, -- strong health potion
		{ 3557, 1000, 1 }, -- plate legs
		{ 2892, 13000, 1 }, -- broken bottle
		{ 3115, 13000, 2 }, -- bone
		{ 3112, 12000, 1 }, -- rotten meat
		{ 3266, 4500, 1 }, -- battle axe
		{ 3305, 2000, 1 }, -- battle hammer
		{ 3577, 13000, 2 }, -- meat
		{ 3124, 7000, 1 }, -- burnt scroll
		{ 3409, 8000, 1 }, -- steel shield
		{ 2894, 16000, 1 }, -- broken flask
		{ 3113, 13000, 1 }, -- broken pottery
		{ 3003, 15000, 1 }, -- rope
	},
}

local lizardrewards = {
	minUid = 27500,
	maxUid = 27599,
	maxItems = 6,
	itemList = {
		{ 3031, 60000, 80 }, -- gold coin
		{ 3314, 500, 1 }, -- naginata
		{ 3377, 12000, 1 }, -- scale armor
		{ 3269, 3000, 1 }, -- halberd
		{ 3444, 4300, 1 }, -- sentinel shields
		{ 266, 12000, 2 }, -- health potion
		{ 3032, 2000, 2 }, -- small emerald
		{ 10418, 3000, 1 }, -- broken halberd
		{ 10328, 4000, 2 }, -- bunch of ripe rice
		{ 10406, 3000, 1 }, -- Zaoan halberd
		{ 10289, 3000, 1 }, -- red lantern
		{ 10386, 300, 1 }, -- Zaoan shoes
		{ 10386, 80, 1 }, -- Zaoan shoes
		{ 18339, 200, 1 }, -- Zaoan chess box
		{ 3035, 1000, 1 }, -- platinum coin
		{ 3065, 500, 1 }, -- terra rod
		{ 3052, 2000, 1 }, -- life ring
		{ 3098, 700, 1 }, -- ring of healing
		{ 10329, 700, 1 }, -- rice ball
		{ 3061, 700, 1 }, -- life crystal
		{ 3147, 13000, 1 }, -- blank rune
		{ 7378, 10000, 3 }, -- royal spear
		{ 3073, 300, 1 }, -- wand of cosmic energy
		{ 3066, 7000, 1 }, -- snakebite rod
		{ 12802, 2000, 1 }, -- sugar oat
	},
}

local magerewards = {
	minUid = 27600,
	maxUid = 27699,
	maxItems = 6,
	itemList = {
		{ 3031, 60000, 80 }, -- gold coin
		{ 3054, 700, 200 }, -- silver amulet
		{ 8042, 1000, 1 }, -- spirit cloak
		{ 268, 15000, 3 }, -- mana potion
		{ 237, 5000, 2 }, -- strong mana potion
		{ 238, 1000, 1 }, -- great mana potion
		{ 3059, 7000, 1 }, -- spellbook
		{ 3147, 20000, 2 }, -- blank rune
		{ 3148, 10000, 2 }, -- destroy field rune
		{ 3149, 5000, 2 }, -- energy bomb rune
		{ 3156, 5000, 2 }, -- wild growth rune
		{ 3180, 5000, 2 }, -- magic wall rune
		{ 3173, 5000, 2 }, -- poison bomb rune
		{ 3192, 5000, 2 }, -- fire bomb rune
		{ 3160, 7500, 2 }, -- ultimate healing rune
		{ 3177, 7500, 2 }, -- convince creature rune
		{ 3178, 7500, 2 }, -- chameleon rune
		{ 3074, 3000, 1 }, -- wand of vortex
		{ 3066, 3000, 1 }, -- snakebite rod
		{ 3072, 500, 1 }, -- wand of decay
		{ 3069, 500, 1 }, -- necrotic rod
		{ 675, 500, 1 }, -- small enchanted sapphire
		{ 676, 500, 1 }, -- small enchanted ruby
		{ 677, 500, 1 }, -- small enchanted emerald
		{ 678, 500, 1 }, -- small enchanted amethyst
		{ 3600, 25000, 2 }, -- bread
		{ 3592, 25000, 3 }, -- grapes
	},
}

local corymrewards = {
	minUid = 27700,
	maxUid = 27799,
	maxItems = 6,
	itemList = {
		{ 3031, 60000, 80 }, -- gold coin
		{ 17809, 6000, 1 }, -- bola
		{ 17817, 6000, 1 }, -- cheese cutter
		{ 17812, 600, 1 }, -- ratana
		{ 17820, 6000, 1 }, -- soft cheese
		{ 17846, 1000, 1 }, -- leather harness
		{ 17813, 3500, 1 }, -- life preserver
		{ 17819, 2700, 1 }, -- earflap
		{ 17810, 1200, 1 }, -- spike shield
		{ 3607, 18000, 1 }, -- cheese
		{ 3112, 21000, 1 }, -- rotten meat
		{ 17825, 200, 1 }, -- rat god doll
		{ 17859, 1000, 1 }, -- spiky club
		{ 2920, 24000, 1 }, -- torch
	},
}

local nomadrewards = {
	minUid = 27800,
	maxUid = 27899,
	maxItems = 6,
	itemList = {
		{ 3031, 60000, 80 }, -- gold coin
		{ 3307, 700, 1 }, -- scimitar
		{ 3432, 300, 1 }, -- ancient shield
		{ 3025, 800, 1 }, -- ancient amulet
		{ 3328, 300, 1 }, -- daramian waraxe
		{ 3018, 900, 1 }, -- scarab amulet
		{ 3042, 7800, 2 }, -- scarab coin
		{ 3354, 12000, 1 }, -- brass helmet
		{ 3359, 12000, 1 }, -- brass armor
		{ 3372, 12000, 1 }, -- brass legs
		{ 3411, 12000, 1 }, -- brass shield
		{ 11456, 16000, 1 }, -- dirty turban
		{ 3353, 10000, 1 }, -- iron helmet
		{ 3286, 10000, 1 }, -- mace
		{ 11492, 10000, 1 }, -- rope belt
		{ 3003, 16000, 1 }, -- rope
		{ 3274, 14000, 1 }, -- axe
		{ 12802, 7000, 1 }, -- sugar oat
		{ 3028, 600, 1 }, -- small diamond
		{ 3026, 600, 1 }, -- white pearl
	},
}

local trumnarewards = {
	minUid = 27900,
	maxUid = 27949,
	maxItems = 6,
	itemList = {
		{ 3031, 60000, 55 }, -- gold coin
		{ 3338, 400, 1 }, -- bone sword
		{ 3441, 400, 1 }, -- bone shield
		{ 3375, 2000, 1 }, -- soldier helmet
		{ 3358, 2000, 1 }, -- chain armor
		{ 3115, 13000, 2 }, -- bone
		{ 3116, 10000, 1 }, -- big bone
		{ 5925, 5000, 1 }, -- hardened bone
		{ 3207, 3000, 1 }, -- skull of Ratha
		{ 6525, 500, 1 }, -- skeleton decoration
		{ 3119, 15000, 1 }, -- broken sword
		{ 953, 5000, 2 }, -- nail
		{ 3124, 17000, 1 }, -- burnt scroll
	},
}

local sarcophagusrewards = {
	minUid = 27950,
	maxUid = 27999,
	maxItems = 6,
	itemList = {
		{ 3031, 33000, 100 }, -- gold coin
		{ 3048, 8000, 20 }, -- might ring
		{ 3440, 200, 1 }, -- scarab shield
		{ 3049, 1000, 1 }, -- stealth ring
		{ 2933, 16000, 1 }, -- small oil lamp
		{ 9057, 1000, 2 }, -- small topaz
		{ 3037, 800, 1 }, -- yellow gem
		{ 2903, 3000, 1 }, -- golden mug
		{ 3042, 16000, 2 }, -- scarab coin
		{ 3018, 20000, 1 }, -- scarab amulet
	},
}

local toolsrewards = {
	minUid = 28000,
	maxUid = 28099,
	maxItems = 6,
	itemList = {
		{ 3003, 6000, 1 }, -- rope
		{ 3453, 1000, 1 }, -- scythe
		{ 3293, 1000, 1 }, -- sickle
		{ 3457, 3000, 1 }, -- shovel
		{ 3461, 3000, 1 }, -- saw
		{ 3291, 500, 1 }, -- knife
		{ 3471, 6000, 1 }, -- cleaver
		{ 3460, 10000, 1 }, -- hammer
		{ 3456, 5000, 1 }, -- pick
		{ 5908, 200, 1 }, -- obsidian knife
		{ 2920, 25000, 1 }, -- torch
		{ 5880, 200, 1 }, -- iron ore
		{ 3446, 5000, 8 }, -- bolt
		{ 7364, 5000, 10 }, -- sniper arrow
		{ 7363, 3000, 8 }, -- piercing bolt
		{ 953, 15000, 2 }, -- nail
	},
}

local toolsrewards2 = {
	minUid = 28300,
	maxUid = 28399,
	maxItems = 6,
	itemList = {
		{ 3003, 6000, 1 }, -- rope
		{ 3453, 1000, 1 }, -- scythe
		{ 3293, 1000, 1 }, -- sickle
		{ 3457, 3000, 1 }, -- shovel
		{ 3461, 3000, 1 }, -- saw
		{ 3291, 500, 1 }, -- knife
		{ 3471, 6000, 1 }, -- cleaver
		{ 3460, 10000, 1 }, -- hammer
		{ 3456, 5000, 1 }, -- pick
		{ 5908, 200, 1 }, -- obsidian knife
		{ 2920, 25000, 1 }, -- torch
		{ 5880, 200, 1 }, -- iron ore
		{ 3446, 5000, 8 }, -- bolt
		{ 7364, 5000, 10 }, -- sniper arrow
		{ 7363, 3000, 8 }, -- piercing bolt
		{ 953, 15000, 2 }, -- nail
	},
}

local weaponsrewards = {
	minUid = 28100,
	maxUid = 28249,
	maxItems = 6,
	itemList = {
		{ 3264, 12000, 1 }, -- sword
		{ 3552, 1000, 1 }, -- leather boots
		{ 3295, 200, 1 }, -- bright sword
		{ 3415, 200, 1 }, -- guardian shield
		{ 3370, 80, 1 }, -- knight armor
		{ 3371, 80, 1 }, -- knight legs
		{ 3318, 80, 1 }, -- knight axe
		{ 3377, 2000, 1 }, -- scale armor
		{ 3358, 2000, 1 }, -- chain armor
		{ 3375, 2000, 1 }, -- soldier helmet
		{ 3286, 12000, 1 }, -- mace
		{ 3305, 2000, 1 }, -- battle hammer
		{ 3322, 150, 1 }, -- dragon hammer
		{ 3271, 2000, 1 }, -- spike sword
		{ 3297, 400, 1 }, -- serpent sword
		{ 3031, 18000, 36 }, -- gold coin
		{ 3357, 400, 1 }, -- plate armor
		{ 3557, 400, 1 }, -- plate legs
		{ 3558, 500, 1 }, -- chain legs
		{ 3091, 2000, 1 }, -- sword ring
		{ 3092, 2000, 1 }, -- axe ring
		{ 3093, 2000, 1 }, -- club ring
		{ 3446, 8000, 8 }, -- bolt
		{ 3349, 3000, 1 }, -- crossbow
		{ 3350, 2000, 1 }, -- bow
		{ 7378, 8000, 3 }, -- royal spear
		{ 3084, 2500, 250 }, -- protection amulet
		{ 2894, 15000, 1 }, -- broken flask
		{ 2996, 14000, 1 }, -- broken piggy bank
		{ 3409, 7000, 1 }, -- steel shield
		{ 3351, 2500, 1 }, -- steel helmet
		{ 3431, 200, 1 }, -- viking shield
	},
}

local treasurerewards = {
	minUid = 27001,
	maxUid = 27002,
	maxItems = 6,
	itemList = {
		{ 3031, 85000, 100 }, -- gold coin
		{ 3035, 75000, 4 }, -- platinum coin
		{ 5945, 1000, 1 }, -- coral comb
		{ 9205, 12000, 1 }, -- pirate treasure map
		{ 5926, 5000, 1 }, -- pirate backpack
		{ 5461, 5000, 1 }, -- pirate boots
		{ 6126, 20000, 1 }, -- peg leg
		{ 5792, 5000, 1 }, -- die
		{ 5552, 17000, 1 }, -- rum flask
		{ 12543, 5000, 1 }, -- golden hyaena pendant
		{ 3018, 20000, 1 }, -- scarab amulet
		{ 3056, 35000, 200 }, -- bronze amulet
		{ 3048, 12000, 20 }, -- might ring
		{ 3053, 12000, 1 }, -- time ring
		{ 16114, 1500, 1 }, -- prismatic ring
		{ 281, 12000, 1 }, -- giant shimmering pearl
		{ 282, 12000, 1 }, -- giant shimmering pearl
		{ 3026, 25000, 1 }, -- white pearl
		{ 3028, 25000, 1 }, -- small diamond
		{ 3032, 25000, 1 }, -- small emerald
		{ 3029, 25000, 1 }, -- small sapphire
	},
}

local smiecirewards = {
	--minUid = 28400,
	--maxUid = 28750, -- Replace with the appropriate maxUid if needed
	--maxItems = 4,
	itemList = {
		{ 3031, 15000, 50 }, -- gold coin
		{ 2894, 5000, 1 }, -- broken flask
		{ 3118, 5000, 1 }, -- broken green glass
		{ 3112, 5000, 1 }, -- rotten meat
		{ 3104, 5000, 1 }, -- banana skin
		{ 3113, 5000, 1 }, -- broken pottery
		{ 3117, 5000, 1 }, -- broken brown glass
		{ 2892, 5000, 1 }, -- broken bottle
		{ 3111, 5000, 1 }, -- fishbone
		{ 3120, 5000, 1 }, -- mouldy cheese
		{ 8275, 5000, 1 }, -- torn book
		{ 2875, 5000, 1 }, -- bottle
		{ 2885, 5000, 1 }, -- brown flask
		{ 268, 20000, 5 }, -- mana potion
		{ 266, 20000, 5 }, -- health potion
		{ 3124, 5000, 1 }, -- burnt scroll
		{ 2877, 5000, 1 }, -- green flask
		{ 285, 5000, 1 }, -- empty potion flask
		{ 19148, 5000, 1 }, -- torn magic cape
		{ 3119, 5000, 1 }, -- broken sword
		{ 3123, 5000, 1 }, -- worn leather boots
		{ 2876, 5000, 1 }, -- vase
		{ 283, 5000, 1 }, -- empty potion flask
		{ 3577, 10000, 4 }, -- meat
		{ 3578, 10000, 4 }, -- fish
		{ 3723, 10000, 4 }, -- white mushroom
		{ 3582, 10000, 4 }, -- ham
		{ 3583, 10000, 4 }, -- dragon ham
		{ 3725, 10000, 4 }, -- brown mushroom
		{ 2880, 5000, 1 }, -- mug
		{ 3466, 5000, 1 }, -- pan
		{ 3467, 5000, 1 }, -- fork
		{ 3473, 5000, 1 }, -- rolling pin
		{ 2905, 5000, 1 }, -- plate
	},
}

local rewards = {
	--trash
	[2014] = {
		{ id = 3031, chance = 15000, count = 50 }, -- gold coin
		{ id = 2894, chance = 5000, count = 1 }, -- broken flask
		{ id = 3118, chance = 5000, count = 1 }, -- broken green glass
		{ id = 3112, chance = 5000, count = 1 }, -- rotten meatz
		{ id = 3104, chance = 5000, count = 1 }, -- banana skin
		{ id = 3113, chance = 5000, count = 1 }, -- broken pottery
		{ id = 3117, chance = 5000, count = 1 }, -- broken brown glass
		{ id = 2892, chance = 5000, count = 1 }, -- broken bottle
		{ id = 3111, chance = 5000, count = 1 }, -- fishbone
		{ id = 3120, chance = 5000, count = 1 }, -- mouldy cheese
		{ id = 8275, chance = 5000, count = 1 }, -- torn book
		{ id = 2875, chance = 5000, count = 1 }, -- bottle
		{ id = 2885, chance = 5000, count = 1 }, -- brown flask
		{ id = 268, chance = 20000, count = 5 }, -- mana potion
		{ id = 266, chance = 20000, count = 5 }, -- health potion
		{ id = 3124, chance = 5000, count = 1 }, -- burnt scroll
		{ id = 2877, chance = 5000, count = 1 }, -- green flask
		{ id = 285, chance = 5000, count = 1 }, -- empty potion flask
		{ id = 19148, chance = 5000, count = 1 }, -- torn magic cape
		{ id = 3119, chance = 5000, count = 1 }, -- broken sword
		{ id = 3123, chance = 5000, count = 1 }, -- worn leather boots
		{ id = 2876, chance = 5000, count = 1 }, -- vase
		{ id = 283, chance = 5000, count = 1 }, -- empty potion flask
		{ id = 3577, chance = 10000, count = 4 }, -- meat
		{ id = 3578, chance = 10000, count = 4 }, -- fish
		{ id = 3723, chance = 10000, count = 4 }, -- white mushroom
		{ id = 3582, chance = 10000, count = 4 }, -- ham
		{ id = 3583, chance = 10000, count = 4 }, -- dragon ham
		{ id = 3725, chance = 10000, count = 4 }, -- brown mushroom
		{ id = 2880, chance = 5000, count = 1 }, -- mug
		{ id = 3466, chance = 5000, count = 1 }, -- pan
		{ id = 3467, chance = 5000, count = 1 }, -- fork
		{ id = 3473, chance = 5000, count = 1 }, -- rolling pin
		{ id = 2905, chance = 5000, count = 1 }, -- plate
	},
}

local function worldChestIndetifier(worldChest)
	return worldChest:getPosition():ToString()
end

local function wasGeneratedRecently(worldChest)
	return (worldchests[worldChestIndetifier(worldChest)] or 0) > os.time()
end

local function setGeneratedRecently(worldChest)
	worldchests[worldChestIndetifier(worldChest)] = os.time() + interval
end

local function worldChestRewardType(worldChest)
	return worldChest:getActionId()
end

local function generateChestRewards(worldChest)
	local selectedItems = {}
	local maxSelectedItems = worldChest:getCapacity()
	local selectThisManyItems = math.random(1, math.ceil(maxSelectedItems / 2))

	local possibleRewards = rewards[worldChestRewardType(worldChest)]
	for _, rewardItem in pairs(possibleRewards) do
		local roll = math.random(1, 10000)
		if roll < rewardItem.chance then
			local rolledCound = math.random(1, rewardItem.count)
			table.insert(selectedItems, { id = rewardItem.id, count = rolledCound })
		end
		if #selectedItems >= selectThisManyItems then
			break
		end
	end

	for _, rewardItem in pairs(selectedItems) do
		worldChest:addItem(rewardItem.id, rewardItem.count)
	end
end

local rewardChestClick = Action()
function rewardChestClick.onUse(player, worldchest, fromPosition, target, toPosition, isHotkey)
	if wasGeneratedRecently(worldchest) then
		return false
	end

	generateChestRewards(worldchest)
	setGeneratedRecently(worldchest)
	return false
end

rewardChestClick:aid(2014)
rewardChestClick:register()
