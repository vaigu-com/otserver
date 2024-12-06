local dialogs = {
	[Storage.StickyBeginning.LebesgueAsked] = {
		[{ max = 0 }] = {
			[{ "help", "pomoc" }] = {
				text = "Everything is in perfect order, only if you could check what is going on with this wood delivery.. I'm almost out of my stock, I don't want to disappoint my customers.",
				requiredState = { [Storage.StickyBeginning.Discernment] = 2 },
				nextState = {
					[Storage.StickyBeginning.LebesgueAsked] = 1,
					[Storage.StickyBeginning.Discernment] = "+1",
				},
				textNoRequiredState = {
					"What do you want? Better visit Commissioner Fisher first.",
				},
			},
		},
	},
	[Storage.StickyBeginning.RewardState] = {
		[{ max = 0 }] = {
			[{ "belty", "bolts" }] = {
				text = "Here are bolts for you. You should visit Fstab for a potion supply.",
				nextState = { [Storage.StickyBeginning.RewardState] = 3 },
				rewards = { { id = 7364, count = 300 } },
			},
			[{ "strzaly", "arrows" }] = {
				text = "Here are arrows for you. You should visit Fstab for a potion supply.",
				nextState = { [Storage.StickyBeginning.RewardState] = 3 },
				rewards = { { id = 7364, count = 300 } },
			},
		},
	},
	[Storage.StickyBeginning.WoodDelivery] = {
		[6] = {
			[{ "nagroda", "reward" }] = {
				text = "Trollsky sent you there? What you prefer to get, {bolts} or {arrows}?",
				nextTopic = 1,
				requiredState = { [Storage.StickyBeginning.RewardState] = -1 },
				textNoRequiredState = "You got your reward already, visit Fstab for a potion supply.",
			},
		},
	},
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Luki, kusze, amunicja to moj chleb powszedni" },
	{ text = "Codziennie z rana ostrze grot kazdej wloczni" },
	{ text = "Co drugi przychodzi i krzyczy daaaaaj kamieniaaaaaa" },
	{ text = "Za Tuska to sie dobrze krecil interes a teraz..." },
	{ text = "Kusza czy luk? Zapraszam do debaty..." },
}
local outfit = {
	lookType = 134,
	lookHead = 57,
	lookBody = 59,
	lookLegs = 40,
	lookFeet = 76,
	lookAddons = 0,
}
local context = {
	name = "Lebesgue The Philosopher",
	greetJob = JOB_DISTANCE_SOULORB,
	jobs = { JOB_SOULORB, JOB_DISTANCE },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}

NpcRegistry:AppendNpcData(context)
