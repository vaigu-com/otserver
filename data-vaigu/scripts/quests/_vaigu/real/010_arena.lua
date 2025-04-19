--dialogs are in old system
do
	return
end
local quest = Quest(LOCALIZERS.Arena)

quest
	:Storage(function() end)
	:Constant(function() end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "Arena",
			localizer = localizer,
			missions ={
				{
					name = "First arena",
					storage = 301,
					minState = 1,
					maxState = 2,
					description = "Kill:\nFrostfur\nBloodpaw\nBovinus\nAchad\nColerian the Barbarian\nThe Hairy One\nAxeitus Headbanger\nRocky\nCursed Gladiator\nOrcus the Cruel",
				},
				{
					name = "Second arena",
					storage = 302,
					minState = 1,
					maxState = 2,
					description = "Kill:\nAvalanche\nKreebosh the Exile\nThe Dark Dancer\nThe Hag\nSlim\nGrimgor Guteater\nDrasilla\nSpirit of Earth\nSpirit of Water\nSpirit of Fire",
				},
				{
					name = "Third arena",
					storage = 303,
					minState = 1,
					maxState = 2,
					description = "Kill:\nWebster\nDarakan the Executioner\nNorgle Glacierbeard\nThe Pit Lord\nSvoren the Mad\nThe Masked Marauder\nGnorre Chyllson\nFallen Mooh'Tah Master Ghar\nDeathbringer\nThe Obliverator",
				},
				{
					name = "Fourth arena",
					storage = 304,
					minState = 1,
					maxState = 2,
					description = "Arena, extreme level.",
				},
			},
		})
	end)
	:Register()
