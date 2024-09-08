TOP_CHEF_STATES = {
	RotwormStew = 1,
	HydraTongueSalad = 2,
	RoastedDragonWings = 3,
	TropicalFriedTerrorbird = 4,
	BananaChocolateShake = 5,
	VeggieCasserole = 6,
	FilledJalapenoPeppers = 7,
	BlessedSteak = 8,
	NorthernFishburger = 9,
	CarrotCake = 10,
	CoconutShrimpBake = 11,
	PotofBlackjack = 12,
	DemonicCandyBall = 13,
	SweetMangonaiseElixir = 14,
}

COOKING_INGREDIENT_DATA = {
	[TOP_CHEF_STATES.RotwormStew] = { dishName = "Rotworm Stew", items = { { id = 3577, count = 2 }, { id = 8010, count = 20 }, { id = 8015, count = 1 }, { id = 8197, count = 1 }, { id = 3603, count = 5 }, { id = 2874, count = 2, fluidType = 3 } } },
	[TOP_CHEF_STATES.HydraTongueSalad] = { dishName = "Hydra Tongue Salad", items = { { id = 7250, count = 2 }, { id = 3596, count = 2 }, { id = 8014, count = 1 }, { id = 3606, count = 2 }, { id = 3741, count = 1 }, { id = 2874, count = 1, fluidType = 2 } } },
	[TOP_CHEF_STATES.RoastedDragonWings] = { dishName = "Roasted Dragon Wings", items = { { id = 4363, count = 1 }, { id = 8016, count = 3 }, { id = 3602, count = 5 }, { id = 3606, count = 2 }, { id = 3739, count = 1 }, { id = 3724, count = 5 } } },
	[TOP_CHEF_STATES.TropicalFriedTerrorbird] = { dishName = "Tropical Fried Terrorbird", items = { { id = 4330, count = 1 }, { id = 8013, count = 2 }, { id = 3586, count = 2 }, { id = 5096, count = 2 }, { id = 2874, count = 2, fluidType = 15 }, { id = 3735, count = 1 } } },
	[TOP_CHEF_STATES.BananaChocolateShake] = { dishName = "Banana Chocolate Shake", items = { { id = 6574, count = 1 }, { id = 6393, count = 1 }, { id = 3587, count = 2 }, { id = 2874, count = 2, fluidType = 9 }, { id = 3738, count = 1 }, { id = 3736, count = 1 } } },
	[TOP_CHEF_STATES.VeggieCasserole] = { dishName = "Veggie Casserole", items = { { id = 3595, count = 2 }, { id = 3596, count = 2 }, { id = 3597, count = 2 }, { id = 8014, count = 2 }, { id = 8015, count = 1 }, { id = 8197, count = 1 }, { id = 3607, count = 1 }, { id = 3723, count = 20 }, { id = 3725, count = 5 } } },
	[TOP_CHEF_STATES.FilledJalapenoPeppers] = { dishName = "Filled Jalapeno Peppers", items = { { id = 8016, count = 10 }, { id = 3607, count = 2 }, { id = 3741, count = 1 }, { id = 3740, count = 1 }, { id = 7141, count = 1 }, { id = 3606, count = 2 } } },
	[TOP_CHEF_STATES.BlessedSteak] = { dishName = "Blessed Steak", items = { { id = 3582, count = 1 }, { id = 8011, count = 5 }, { id = 8015, count = 1 }, { id = 8017, count = 2 }, { id = 3594, count = 1 }, { id = 8016, count = 2 } } },
	[TOP_CHEF_STATES.NorthernFishburger] = { dishName = "Northern Fishburger", items = { { id = 3580, count = 1 }, { id = 7158, count = 1 }, { id = 7159, count = 1 }, { id = 3581, count = 5 }, { id = 3601, count = 2 }, { id = 3737, count = 1 } } },
	[TOP_CHEF_STATES.CarrotCake] = { dishName = "Carrot Cake", items = { { id = 3595, count = 5 }, { id = 2874, count = 1, fluidType = 9 }, { id = 8013, count = 1 }, { id = 3603, count = 10 }, { id = 3606, count = 2 }, { id = 3598, count = 10 }, { id = 841, count = 2 } } },
	[TOP_CHEF_STATES.CoconutShrimpBake] = { dishName = "Coconut Shrimp Bake", items = { { id = 2874, count = 5, fluidType = 15 }, { id = 3725, count = 5 }, { id = 3724, count = 5 }, { id = 10329, count = 10 }, { id = 3581, count = 10 } } },
	[TOP_CHEF_STATES.PotofBlackjack] = { dishName = "Pot of Blackjack", items = { { id = 10456, count = 5 }, { id = 2874, count = 2, fluidType = 1 }, { id = 3595, count = 20 }, { id = 8010, count = 10 }, { id = 8016, count = 3 } } },
	[TOP_CHEF_STATES.DemonicCandyBall] = { dishName = "Demonic Candy Ball", items = { { id = 6569, count = 3 }, { id = 3599, count = 3 }, { id = 6574, count = 2 }, { id = 6500, count = 15 }, { id = 6558, count = 1 } } },
	[TOP_CHEF_STATES.SweetMangonaiseElixir] = { dishName = "Sweet Mangonaise Elixir", items = { { id = 3606, count = 40 }, { id = 5096, count = 20 }, { id = 5902, count = 10 }, { id = 8758, count = 1 }, { id = 5942, count = 1 } } },
}

COOKING_DISH_NAMES = {}

FLUID_ENUM_TO_NAME = {
	[FLUID_NONE] = "void",
	[FLUID_WATER] = "water",
	[FLUID_WINE] = "wine",
	[FLUID_BEER] = "beer",
	[FLUID_MUD] = "mud",
	[FLUID_BLOOD] = "blood",
	[FLUID_SLIME] = "slime",
	[FLUID_OIL] = "oil",
	[FLUID_URINE] = "urine",
	[FLUID_MILK] = "milk",
	[FLUID_MANA] = "mana",
	[FLUID_LIFE] = "life",
	[FLUID_LEMONADE] = "lemonade",
	[FLUID_RUM] = "rum",
	[FLUID_FRUITJUICE] = "fruit juice",
	[FLUID_COCONUTMILK] = "coconut milk",
	[FLUID_MEAD] = "mead",
	[FLUID_TEA] = "tea",
}

LAST_TOP_CHEF_DISH_INDEX = TOP_CHEF_STATES.SweetMangonaiseElixir
LAST_TOP_CHEF_STATE = 16 --ehh

local ingredientStrings = {
	[TOP_CHEF_STATES.RotwormStew] = "",
	[TOP_CHEF_STATES.HydraTongueSalad] = "",
	[TOP_CHEF_STATES.RoastedDragonWings] = "",
	[TOP_CHEF_STATES.TropicalFriedTerrorbird] = "",
	[TOP_CHEF_STATES.BananaChocolateShake] = "",
	[TOP_CHEF_STATES.VeggieCasserole] = "",
	[TOP_CHEF_STATES.FilledJalapenoPeppers] = "",
	[TOP_CHEF_STATES.BlessedSteak] = "",
	[TOP_CHEF_STATES.NorthernFishburger] = "",
	[TOP_CHEF_STATES.CarrotCake] = "",
	[TOP_CHEF_STATES.CoconutShrimpBake] = "",
	[TOP_CHEF_STATES.PotofBlackjack] = "",
	[TOP_CHEF_STATES.DemonicCandyBall] = "",
	[TOP_CHEF_STATES.SweetMangonaiseElixir] = "",
}

function IngredientsToString(dishData)
	return ingredientStrings[dishData.storage]
end

local cookBook = Action()
function cookBook.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local fullText = {}
	for _, dishText in pairs(ingredientStrings) do
		table.insert(fullText, dishText)
	end
	player:showTextDialog(item.itemid, table.concat(fullText))
	return true
end

cookBook:id(9093)
cookBook:register()

local function generateCookingAuxillaryData()
	for storage, dishData in pairs(COOKING_INGREDIENT_DATA) do
		local requiredItemsString = ""
		for _, item in pairs(dishData.items) do
			local id = item.id
			local count = item.count
			local name = ItemType(id):getName()
			requiredItemsString = requiredItemsString .. T("\n:count: :name:", { name = name, count = count })

			local fluidType = item.fluidType
			local fluidName = FLUID_ENUM_TO_NAME[fluidType]
			if fluidType then
				requiredItemsString = requiredItemsString .. T(" of :fluidName:", { fluidName = fluidName })
			end
		end
		ingredientStrings[storage] = requiredItemsString
		COOKING_INGREDIENT_DATA[storage].storage = storage
		COOKING_DISH_NAMES[dishData.dishName] = storage
		COOKING_DISH_NAMES[dishData.dishName:lower()] = storage
	end
end

local cooking = GlobalEvent("generateCookingAuxillaryData")
function cooking.onStartup()
	generateCookingAuxillaryData()
end
cooking:register()
