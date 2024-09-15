local dialogs = {
	[Storage.SciezkaNieumarlych.Questline] = {
		[2] = {
			[{ "krag", "kregi", "circles", "cromlech" }] = {
				text = "Well, the stone cromlech is on top of the mountain neat Mirko Town's north gate. The second cromlech is in the Misguided Thief village south of Knurow.",
			},
		},
	},
	[Storage.TrudnePoczatki.FstabAsked] = {
		[{ max = 0 }] = {
			[{ "help", "pomoc" }] = {
				text = "Everything is fine, but some journeyman could come in handy. Id say that you look promising.",
				requiredState = { [Storage.TrudnePoczatki.Rozeznanie] = 2 },
				nextState = {
					[Storage.TrudnePoczatki.FstabAsked] = 1,
					[Storage.TrudnePoczatki.Rozeznanie] = "+1",
				},
				textNoRequiredState = "What do you want? Better meet Commissioner Fisher first..",
			},
		},
	},
	[Storage.TrudnePoczatki.PoczatkiReward] = {
		[1] = {
			[{ "nagroda", "reward" }] = {
				text = "Well, thank you on behalf of our City for your help, get some of these potions.",
				nextState = { [Storage.TrudnePoczatki.PoczatkiReward] = 4 },
				rewards = { { id = 266, count = 20 }, { id = 268, count = 15 } },
			},
		},
		[2] = {
			[{ "nagroda", "reward" }] = {
				text = "Well, thank you on behalf of our City for your help, get some of these potions.",
				nextState = { [Storage.TrudnePoczatki.PoczatkiReward] = 4 },
				rewards = { { id = 268, count = 40 } },
			},
		},
		[3] = {
			[{ "nagroda", "reward" }] = {
				text = "Well, thank you on behalf of our City for your help, get some of these potions.",
				nextState = { [Storage.TrudnePoczatki.PoczatkiReward] = 4 },
				rewards = { { id = 266, count = 30 }, { id = 268, count = 25 } },
			},
		},
	},
}
local voices = {
	interval = 15000,
	chance = 50,
	{
		text = "Szwagier jak ostatnio eliksir wypil to dwa dni nieprzytomny lezal takiego ma kopa...",
	},
	{ text = "Przyjdz do mnie z kolegami, pohandlujemy uhami." },
	{
		text = "Prawda jest taka ze Panoramix bral ode mnie przepisy na magiczny napoj...",
	},
	{
		text = "Runy magiczne, mikstury syntetyczne, pelen wybor w najnizszych cenach!",
	},
	{ text = "Jesli szukasz magicznej rozdzki to u mnie masz pelen wybor." },
}

local additionalJob = nil
if DAY_SINCE_START >= 7 then
	additionalJob = JOB_EXERCISE
end

local outfit = {
	lookType = 130,
	lookHead = 39,
	lookBody = 122,
	lookLegs = 125,
	lookFeet = 57,
	lookAddons = 0,
}
local context = {
	name = "Fstab",
	greetJob = JOB_MAGIC_WILDCARD,
	jobs = { JOB_WILDCARD, JOB_MAGIC, additionalJob },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
