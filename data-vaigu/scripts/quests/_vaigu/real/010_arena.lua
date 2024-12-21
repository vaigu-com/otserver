--dialogs are in old system 
do
	return
end
local quest = Quest(LOCALIZERS.BigfootBurden)

quest
	:Storage(function() end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Arena",
			missions = {
				[301] = {
					name = "First arena",
					minState = 1,
					maxState = 2,
					description = "Kill:\nFrostfur\nBloodpaw\nBovinus\nAchad\nColerian the Barbarian\nThe Hairy One\nAxeitus Headbanger\nRocky\nCursed Gladiator\nOrcus the Cruel",
				},
				[302] = {
					name = "Second arena",
					minState = 1,
					maxState = 2,
					description = "Kill:\nAvalanche\nKreebosh the Exile\nThe Dark Dancer\nThe Hag\nSlim\nGrimgor Guteater\nDrasilla\nSpirit of Earth\nSpirit of Water\nSpirit of Fire",
				},
				[303] = {
					name = "Third arena",
					minState = 1,
					maxState = 2,
					description = "Kill:\nWebster\nDarakan the Executioner\nNorgle Glacierbeard\nThe Pit Lord\nSvoren the Mad\nThe Masked Marauder\nGnorre Chyllson\nFallen Mooh'Tah Master Ghar\nDeathbringer\nThe Obliverator",
				},
				[304] = {
					name = "Fourth arena",
					minState = 1,
					maxState = 2,
					description = "Arena, extreme level.",
				},
			},
		}
	end)
	:Register()
