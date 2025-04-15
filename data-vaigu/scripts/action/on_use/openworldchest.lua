if not openWorldChestCooldownExpiry then
	openWorldChestCooldownExpiry = {}
end

local openworldchestScope = Scope("	")
-- eg. OpenWorldChest-Elf
local specificOpenworldchestScopes = {
	Weapons = openworldchestScope:Get("Weapons"),
	Armour = openworldchestScope:Get("Armour"),
	Magic = openworldchestScope:Get("Mage"),
	Distance = openworldchestScope:Get("Distance"),

	Trash = openworldchestScope:Get("Trash"),
	Tools = openworldchestScope:Get("Tools"),
	Treasure = openworldchestScope:Get("Treasure"),
	Food = openworldchestScope:Get("Food"),
	Rural = openworldchestScope:Get("Rural"),

	Coffin = openworldchestScope:Get("Coffin"),
	Sarcophagus = openworldchestScope:Get("Sarcophagus"),

	Elf = openworldchestScope:Get("Elf"),
	Orc = openworldchestScope:Get("Orc"),
	Dwarf = openworldchestScope:Get("Dwarf"),
	Nomad = openworldchestScope:Get("Nomad"),
	Cyclops = openworldchestScope:Get("Cyclops"),
	Lizard = openworldchestScope:Get("Lizard"),
	Corym = openworldchestScope:Get("Corym"),
}

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
	for _ = 0, self:getItemHoldingCount() - 1 do
		self:getItem(0):remove()
	end
	return true
end

local openWorldChestRewardCategories = {
	[specificOpenworldchestScopes.Food] = {
		{ id = 3606, chance = 20000, count = 3 }, -- egg
		{ id = 3582, chance = 20000, count = 3 }, -- meat
		{ id = 3577, chance = 20000, count = 3 }, -- ham
	},
	[specificOpenworldchestScopes.Rural] = {
		{ id = 3606, chance = 20000, count = 3 }, -- egg
		{ id = 3542, chance = 2000, count = 1 }, -- rake
		{ id = 345, chance = 2000, count = 1 }, -- hoe
		{ id = 3003, chance = 6000, count = 1 }, -- rope
		{ id = 3453, chance = 1000, count = 1 }, -- scythe
		{ id = 5964, chance = 1000, count = 1 }, -- dead rat
		{ id = 3293, chance = 1000, count = 1 }, -- sickle
		{ id = 3457, chance = 3000, count = 1 }, -- shovel
		{ id = 3461, chance = 3000, count = 1 }, -- saw
		{ id = 3291, chance = 500, count = 1 }, -- knife
		{ id = 3471, chance = 6000, count = 1 }, -- cleaver
		{ id = 3460, chance = 10000, count = 1 }, -- hammer
	},
	[specificOpenworldchestScopes.Armour] = {
		{ id = 3552, chance = 1000, count = 1 }, -- leather boots
		{ id = 3415, chance = 200, count = 1 }, -- guardian shield
		{ id = 3370, chance = 80, count = 1 }, -- knight armor
		{ id = 3371, chance = 80, count = 1 }, -- knight legs
		{ id = 3377, chance = 2000, count = 1 }, -- scale armor
		{ id = 3358, chance = 2000, count = 1 }, -- chain armor
		{ id = 3375, chance = 2000, count = 1 }, -- soldier helmet
		{ id = 3031, chance = 18000, count = 36 }, -- gold coin
		{ id = 3357, chance = 400, count = 1 }, -- plate armor
		{ id = 3557, chance = 400, count = 1 }, -- plate legs
		{ id = 3558, chance = 500, count = 1 }, -- chain legs
		{ id = 3084, chance = 2500, count = 250 }, -- protection amulet
		{ id = 2894, chance = 15000, count = 1 }, -- broken flask
		{ id = 2996, chance = 14000, count = 1 }, -- broken piggy bank
		{ id = 3409, chance = 7000, count = 1 }, -- steel shield
		{ id = 3351, chance = 2500, count = 1 }, -- steel helmet
		{ id = 3431, chance = 200, count = 1 }, -- viking shield
	},
	[specificOpenworldchestScopes.Distance] = {
		{ id = 3031, chance = 18000, count = 36 }, -- gold coin
		{ id = 3446, chance = 8000, count = 8 }, -- bolt
		{ id = 3447, chance = 4000, count = 16 }, -- arrow
		{ id = 3349, chance = 3000, count = 1 }, -- crossbow
		{ id = 3350, chance = 2000, count = 1 }, -- bow
		{ id = 7378, chance = 8000, count = 3 }, -- royal spear
		{ id = 2894, chance = 15000, count = 1 }, -- broken flask
		{ id = 2996, chance = 14000, count = 1 }, -- broken piggy bank
	},
	[specificOpenworldchestScopes.Elf] = {
		{ id = 3600, chance = 26000, count = 2 }, -- bread
		{ id = 3031, chance = 60000, count = 80 }, -- gold coin
		{ id = 3592, chance = 25000, count = 3 }, -- grapes
		{ id = 9635, chance = 10000, count = 1 }, -- elvish talisman
		{ id = 11464, chance = 10000, count = 1 }, -- elven scouting glass
		{ id = 3350, chance = 10000, count = 1 }, -- bow
		{ id = 7438, chance = 500, count = 1 }, -- elvish bow
		{ id = 3447, chance = 15000, count = 20 }, -- arrow
		{ id = 7364, chance = 9000, count = 15 }, -- sniper arrow
		{ id = 774, chance = 9000, count = 15 }, -- earth arrow
		{ id = 16142, chance = 7000, count = 15 }, -- drill bolt
		{ id = 268, chance = 15000, count = 1 }, -- mana potion
		{ id = 3061, chance = 1000, count = 1 }, -- life crystal
		{ id = 5921, chance = 2500, count = 1 }, -- heaven blossom
		{ id = 5922, chance = 2500, count = 1 }, -- holy orchid
		{ id = 3082, chance = 3000, count = 50 }, -- elven amulet
		{ id = 646, chance = 600, count = 1 }, -- elvenhair rope
		{ id = 3399, chance = 300, count = 1 }, -- elven mail
		{ id = 3401, chance = 800, count = 1 }, -- elven legs
		{ id = 3070, chance = 600, count = 1 }, -- moonlight rod
		{ id = 3075, chance = 600, count = 1 }, -- wand of dragonbreath
	},
	[specificOpenworldchestScopes.Orc] = {
		{ id = 3112, chance = 20000, count = 2 }, -- rotten meat
		{ id = 3307, chance = 700, count = 1 }, -- scimitar
		{ id = 3552, chance = 1000, count = 1 }, -- leather boots
		{ id = 3391, chance = 100, count = 1 }, -- crusader helmet
		{ id = 3358, chance = 2000, count = 1 }, -- chain armor
		{ id = 3577, chance = 20000, count = 2 }, -- meat
		{ id = 3031, chance = 60000, count = 80 }, -- gold coin
		{ id = 3426, chance = 10000, count = 1 }, -- studded shield
		{ id = 3362, chance = 10000, count = 1 }, -- studded legs
		{ id = 3378, chance = 10000, count = 1 }, -- studded armor
		{ id = 11480, chance = 15000, count = 1 }, -- skull belt
		{ id = 3557, chance = 1000, count = 1 }, -- plate legs
		{ id = 2920, chance = 14000, count = 1 }, -- torch
		{ id = 7378, chance = 6000, count = 3 }, -- royal spear
		{ id = 3316, chance = 2000, count = 1 }, -- orcish axe
		{ id = 3322, chance = 400, count = 1 }, -- dragon hammer
	},
	[specificOpenworldchestScopes.Dwarf] = {
		{ id = 3031, chance = 60000, count = 80 }, -- gold coin
		{ id = 3552, chance = 1000, count = 1 }, -- leather boots
		{ id = 3375, chance = 4000, count = 1 }, -- soldier helmet
		{ id = 3358, chance = 2000, count = 1 }, -- chain armor
		{ id = 3097, chance = 4000, count = 1 }, -- dwarven ring
		{ id = 3425, chance = 4000, count = 1 }, -- dwarven shield
		{ id = 3723, chance = 20000, count = 3 }, -- white mushroom
		{ id = 5880, chance = 800, count = 1 }, -- iron ore
		{ id = 3430, chance = 4000, count = 1 }, -- copper shield
		{ id = 3266, chance = 4000, count = 1 }, -- battle axe
		{ id = 3274, chance = 10000, count = 1 }, -- axe
		{ id = 3456, chance = 15000, count = 1 }, -- pick
		{ id = 953, chance = 15000, count = 3 }, -- nail
		{ id = 3351, chance = 2000, count = 1 }, -- steel helmet
		{ id = 12600, chance = 4000, count = 2 }, -- coal
		{ id = 3092, chance = 2000, count = 1 }, -- axe ring
		{ id = 266, chance = 13000, count = 1 }, -- health potion
		{ id = 3349, chance = 3000, count = 1 }, -- crossbow
		{ id = 7363, chance = 13000, count = 10 }, -- piercing bolt
		{ id = 2894, chance = 16000, count = 1 }, -- broken flask
		{ id = 2920, chance = 30000, count = 1 }, -- torch
		{ id = 3003, chance = 30000, count = 1 }, -- rope
		{ id = 3323, chance = 400, count = 1 }, -- dwarven axe
	},
	[specificOpenworldchestScopes.Cyclops] = {
		{ id = 3031, chance = 60000, count = 80 }, -- gold coin
		{ id = 3012, chance = 4000, count = 1 }, -- wolf tooth chain
		{ id = 3413, chance = 3200, count = 1 }, -- battle shield
		{ id = 3269, chance = 3200, count = 1 }, -- halberd
		{ id = 3093, chance = 4000, count = 1 }, -- club ring
		{ id = 3092, chance = 4000, count = 1 }, -- axe ring
		{ id = 236, chance = 14000, count = 1 }, -- strong health potion
		{ id = 3557, chance = 1000, count = 1 }, -- plate legs
		{ id = 2892, chance = 13000, count = 1 }, -- broken bottle
		{ id = 3115, chance = 13000, count = 2 }, -- bone
		{ id = 3112, chance = 12000, count = 1 }, -- rotten meat
		{ id = 3266, chance = 4500, count = 1 }, -- battle axe
		{ id = 3305, chance = 2000, count = 1 }, -- battle hammer
		{ id = 3577, chance = 13000, count = 2 }, -- meat
		{ id = 3124, chance = 7000, count = 1 }, -- burnt scroll
		{ id = 3409, chance = 8000, count = 1 }, -- steel shield
		{ id = 2894, chance = 16000, count = 1 }, -- broken flask
		{ id = 3113, chance = 13000, count = 1 }, -- broken pottery
		{ id = 3003, chance = 15000, count = 1 }, -- rope
	},
	[specificOpenworldchestScopes.Lizard] = {
		{ id = 3031, chance = 60000, count = 80 }, -- gold coin
		{ id = 3314, chance = 500, count = 1 }, -- naginata
		{ id = 3377, chance = 12000, count = 1 }, -- scale armor
		{ id = 3269, chance = 3000, count = 1 }, -- halberd
		{ id = 3444, chance = 4300, count = 1 }, -- sentinel shields
		{ id = 266, chance = 12000, count = 2 }, -- health potion
		{ id = 3032, chance = 2000, count = 2 }, -- small emerald
		{ id = 10418, chance = 3000, count = 1 }, -- broken halberd
		{ id = 10328, chance = 4000, count = 2 }, -- bunch of ripe rice
		{ id = 10406, chance = 3000, count = 1 }, -- Zaoan halberd
		{ id = 10289, chance = 3000, count = 1 }, -- red lantern
		{ id = 10386, chance = 300, count = 1 }, -- Zaoan shoes
		{ id = 10386, chance = 80, count = 1 }, -- Zaoan shoes
		{ id = 18339, chance = 200, count = 1 }, -- Zaoan chess box
		{ id = 3035, chance = 1000, count = 1 }, -- platinum coin
		{ id = 3065, chance = 500, count = 1 }, -- terra rod
		{ id = 3052, chance = 2000, count = 1 }, -- life ring
		{ id = 3098, chance = 700, count = 1 }, -- ring of healing
		{ id = 10329, chance = 700, count = 1 }, -- rice ball
		{ id = 3061, chance = 700, count = 1 }, -- life crystal
		{ id = 3147, chance = 13000, count = 1 }, -- blank rune
		{ id = 7378, chance = 10000, count = 3 }, -- royal spear
		{ id = 3073, chance = 300, count = 1 }, -- wand of cosmic energy
		{ id = 3066, chance = 7000, count = 1 }, -- snakebite rod
		{ id = 12802, chance = 2000, count = 1 }, -- sugar oat
	},
	[specificOpenworldchestScopes.Magic] = {
		{ id = 3031, chance = 60000, count = 80 }, -- gold coin
		{ id = 3054, chance = 700, count = 200 }, -- silver amulet
		{ id = 8042, chance = 1000, count = 1 }, -- spirit cloak
		{ id = 268, chance = 15000, count = 3 }, -- mana potion
		{ id = 237, chance = 5000, count = 2 }, -- strong mana potion
		{ id = 238, chance = 1000, count = 1 }, -- great mana potion
		{ id = 3059, chance = 7000, count = 1 }, -- spellbook
		{ id = 3147, chance = 20000, count = 2 }, -- blank rune
		{ id = 3148, chance = 10000, count = 2 }, -- destroy field rune
		{ id = 3149, chance = 5000, count = 2 }, -- energy bomb rune
		{ id = 3156, chance = 5000, count = 2 }, -- wild growth rune
		{ id = 3180, chance = 5000, count = 2 }, -- magic wall rune
		{ id = 3173, chance = 5000, count = 2 }, -- poison bomb rune
		{ id = 3192, chance = 5000, count = 2 }, -- fire bomb rune
		{ id = 3160, chance = 7500, count = 2 }, -- ultimate healing rune
		{ id = 3177, chance = 7500, count = 2 }, -- convince creature rune
		{ id = 3178, chance = 7500, count = 2 }, -- chameleon rune
		{ id = 3074, chance = 3000, count = 1 }, -- wand of vortex
		{ id = 3066, chance = 3000, count = 1 }, -- snakebite rod
		{ id = 3072, chance = 500, count = 1 }, -- wand of decay
		{ id = 3069, chance = 500, count = 1 }, -- necrotic rod
		{ id = 675, chance = 500, count = 1 }, -- small enchanted sapphire
		{ id = 676, chance = 500, count = 1 }, -- small enchanted ruby
		{ id = 677, chance = 500, count = 1 }, -- small enchanted emerald
		{ id = 678, chance = 500, count = 1 }, -- small enchanted amethyst
		{ id = 3600, chance = 25000, count = 2 }, -- bread
		{ id = 3592, chance = 25000, count = 3 }, -- grapes
	},
	[specificOpenworldchestScopes.Corym] = {
		{ id = 3031, chance = 60000, count = 80 }, -- gold coin
		{ id = 17809, chance = 6000, count = 1 }, -- bola
		{ id = 17817, chance = 6000, count = 1 }, -- cheese cutter
		{ id = 17812, chance = 600, count = 1 }, -- ratana
		{ id = 17820, chance = 6000, count = 1 }, -- soft cheese
		{ id = 17846, chance = 1000, count = 1 }, -- leather harness
		{ id = 17813, chance = 3500, count = 1 }, -- life preserver
		{ id = 17819, chance = 2700, count = 1 }, -- earflap
		{ id = 17810, chance = 1200, count = 1 }, -- spike shield
		{ id = 3607, chance = 18000, count = 1 }, -- cheese
		{ id = 3112, chance = 21000, count = 1 }, -- rotten meat
		{ id = 17825, chance = 200, count = 1 }, -- rat god doll
		{ id = 17859, chance = 1000, count = 1 }, -- spiky club
		{ id = 2920, chance = 24000, count = 1 }, -- torch
	},
	[specificOpenworldchestScopes.Nomad] = {
		{ id = 3031, chance = 60000, count = 80 }, -- gold coin
		{ id = 3307, chance = 700, count = 1 }, -- scimitar
		{ id = 3432, chance = 300, count = 1 }, -- ancient shield
		{ id = 3025, chance = 800, count = 1 }, -- ancient amulet
		{ id = 3328, chance = 300, count = 1 }, -- daramian waraxe
		{ id = 3018, chance = 900, count = 1 }, -- scarab amulet
		{ id = 3042, chance = 7800, count = 2 }, -- scarab coin
		{ id = 3354, chance = 12000, count = 1 }, -- brass helmet
		{ id = 3359, chance = 12000, count = 1 }, -- brass armor
		{ id = 3372, chance = 12000, count = 1 }, -- brass legs
		{ id = 3411, chance = 12000, count = 1 }, -- brass shield
		{ id = 11456, chance = 16000, count = 1 }, -- dirty turban
		{ id = 3353, chance = 10000, count = 1 }, -- iron helmet
		{ id = 3286, chance = 10000, count = 1 }, -- mace
		{ id = 11492, chance = 10000, count = 1 }, -- rope belt
		{ id = 3003, chance = 16000, count = 1 }, -- rope
		{ id = 3274, chance = 14000, count = 1 }, -- axe
		{ id = 12802, chance = 7000, count = 1 }, -- sugar oat
		{ id = 3028, chance = 600, count = 1 }, -- small diamond
		{ id = 3026, chance = 600, count = 1 }, -- white pearl
	},
	[specificOpenworldchestScopes.Coffin] = {
		{ id = 3031, chance = 60000, count = 55 }, -- gold coin
		{ id = 3338, chance = 400, count = 1 }, -- bone sword
		{ id = 3441, chance = 400, count = 1 }, -- bone shield
		{ id = 3375, chance = 2000, count = 1 }, -- soldier helmet
		{ id = 3358, chance = 2000, count = 1 }, -- chain armor
		{ id = 3115, chance = 13000, count = 2 }, -- bone
		{ id = 3116, chance = 10000, count = 1 }, -- big bone
		{ id = 5925, chance = 5000, count = 1 }, -- hardened bone
		{ id = 3207, chance = 3000, count = 1 }, -- skull of Ratha
		{ id = 6525, chance = 500, count = 1 }, -- skeleton decoration
		{ id = 3119, chance = 15000, count = 1 }, -- broken sword
		{ id = 953, chance = 5000, count = 2 }, -- nail
		{ id = 3124, chance = 17000, count = 1 }, -- burnt scroll
	},
	[specificOpenworldchestScopes.Sarcophagus] = {
		{ id = 3031, chance = 33000, count = 100 }, -- gold coin
		{ id = 3048, chance = 8000, count = 20 }, -- might ring
		{ id = 3440, chance = 200, count = 1 }, -- scarab shield
		{ id = 3049, chance = 1000, count = 1 }, -- stealth ring
		{ id = 2933, chance = 16000, count = 1 }, -- small oil lamp
		{ id = 9057, chance = 1000, count = 2 }, -- small topaz
		{ id = 3037, chance = 800, count = 1 }, -- yellow gem
		{ id = 2903, chance = 3000, count = 1 }, -- golden mug
		{ id = 3042, chance = 16000, count = 2 }, -- scarab coin
		{ id = 3018, chance = 20000, count = 1 }, -- scarab amulet
	},
	[specificOpenworldchestScopes.Tools] = {
		{ id = 3003, chance = 6000, count = 1 }, -- rope
		{ id = 3453, chance = 1000, count = 1 }, -- scythe
		{ id = 3293, chance = 1000, count = 1 }, -- sickle
		{ id = 3457, chance = 3000, count = 1 }, -- shovel
		{ id = 3461, chance = 3000, count = 1 }, -- saw
		{ id = 3291, chance = 500, count = 1 }, -- knife
		{ id = 3471, chance = 6000, count = 1 }, -- cleaver
		{ id = 3460, chance = 10000, count = 1 }, -- hammer
		{ id = 3456, chance = 5000, count = 1 }, -- pick
		{ id = 5908, chance = 200, count = 1 }, -- obsidian knife
		{ id = 2920, chance = 25000, count = 1 }, -- torch
		{ id = 5880, chance = 200, count = 1 }, -- iron ore
		{ id = 3446, chance = 5000, count = 8 }, -- bolt
		{ id = 7364, chance = 5000, count = 10 }, -- sniper arrow
		{ id = 7363, chance = 3000, count = 8 }, -- piercing bolt
		{ id = 953, chance = 15000, count = 2 }, -- nail
	},
	[specificOpenworldchestScopes.Weapons] = {
		{ id = 3264, chance = 12000, count = 1 }, -- sword
		{ id = 3295, chance = 200, count = 1 }, -- bright sword
		{ id = 3318, chance = 80, count = 1 }, -- knight axe
		{ id = 3377, chance = 2000, count = 1 }, -- scale armor
		{ id = 3286, chance = 12000, count = 1 }, -- mace
		{ id = 3305, chance = 2000, count = 1 }, -- battle hammer
		{ id = 3322, chance = 150, count = 1 }, -- dragon hammer
		{ id = 3271, chance = 2000, count = 1 }, -- spike sword
		{ id = 3297, chance = 400, count = 1 }, -- serpent sword
		{ id = 3031, chance = 18000, count = 36 }, -- gold coin
		{ id = 3091, chance = 2000, count = 1 }, -- sword ring
		{ id = 3092, chance = 2000, count = 1 }, -- axe ring
		{ id = 3093, chance = 2000, count = 1 }, -- club ring
		{ id = 2894, chance = 15000, count = 1 }, -- broken flask
		{ id = 2996, chance = 14000, count = 1 }, -- broken piggy bank
	},
	[specificOpenworldchestScopes.Treasure] = {
		{ id = 3031, chance = 85000, count = 100 }, -- gold coin
		{ id = 3035, chance = 75000, count = 4 }, -- platinum coin
		{ id = 5945, chance = 1000, count = 1 }, -- coral comb
		{ id = 9205, chance = 12000, count = 1 }, -- pirate treasure map
		{ id = 5926, chance = 5000, count = 1 }, -- pirate backpack
		{ id = 5461, chance = 5000, count = 1 }, -- pirate boots
		{ id = 6126, chance = 20000, count = 1 }, -- peg leg
		{ id = 5792, chance = 5000, count = 1 }, -- die
		{ id = 5552, chance = 17000, count = 1 }, -- rum flask
		{ id = 12543, chance = 5000, count = 1 }, -- golden hyaena pendant
		{ id = 3018, chance = 20000, count = 1 }, -- scarab amulet
		{ id = 3056, chance = 35000, count = 200 }, -- bronze amulet
		{ id = 3048, chance = 12000, count = 20 }, -- might ring
		{ id = 3053, chance = 12000, count = 1 }, -- time ring
		{ id = 16114, chance = 1500, count = 1 }, -- prismatic ring
		{ id = 281, chance = 12000, count = 1 }, -- giant shimmering pearl
		{ id = 282, chance = 12000, count = 1 }, -- giant shimmering pearl
		{ id = 3026, chance = 25000, count = 1 }, -- white pearl
		{ id = 3028, chance = 25000, count = 1 }, -- small diamond
		{ id = 3032, chance = 25000, count = 1 }, -- small emerald
		{ id = 3029, chance = 25000, count = 1 }, -- small sapphire
	},
	[specificOpenworldchestScopes.Trash] = {
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

local function worldChestIdentifier(chest)
	return openworldchestScope:Get(chest:getPosition():ToString())
end

local function wasGeneratedRecently(chest)
	local cooldownExpiry = openWorldChestCooldownExpiry[worldChestIdentifier(chest)] or 0
	return cooldownExpiry > os.time()
end

local refreshAfterSeconds = {
	min = 1800,
	max = 7200,
}

local function setGeneratedRecently(chest)
	openWorldChestCooldownExpiry[worldChestIdentifier(chest)] = os.time() + math.random(refreshAfterSeconds.min, refreshAfterSeconds.max)
end

local function generateChestRewards(chest)
	local selectedItems = {}
	local maxSelectedItems = chest:getCapacity()
	local selectThisManyItems = math.random(1, math.ceil(maxSelectedItems / 2))

	local possibleRewards = openWorldChestRewardCategories[chest:getKey()]
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
		chest:addItem(rewardItem.id, rewardItem.count)
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

for key in pairs(openWorldChestRewardCategories) do
	rewardChestClick:key(key)
end
rewardChestClick:register()
