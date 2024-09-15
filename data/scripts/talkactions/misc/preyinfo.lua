local talkaction = TalkAction("!preyinfo")
function talkaction.onSay(player, words, param)
	if getPlayerLanguage(player) == "PL" then
		player:popupFYI(
			"Prey info:"
				.. "\n"
				.. "\n- Czas danego preya schodzi wylacznie podczas bicia danego potwora."
				.. "\n- Wildcardy mozna zakupic za gp w sklepach z magicznymi przedmiotami."
				.. "\n- Przelosowane potwory sa dostosowane do twojego poziomu."
				.. "\n"
				.. "\n- Dzialanie przyciskow:"
				.. "\n	- Przelosowanie typu/poziomu:"
				.. "\n		- Wzrost gwiazdki: szansa zalezy od aktualnego poziomu - im wiecej gwiazdek tym mniejsza szansa."
				.. "\n		- Spadek gwiazdki: gwiazdka spadnie tylko jesli mamy poziom 9 albo nizszy oraz nie wylosowalismy ulepszenia gwiazdki."
				.. "\n		- Zmiana typu preya: 75% szansy."
				.. "\n	- Losowe przelosowanie potwora: spadek gwiazdek o 1."
				.. "\n	- Wybranie potwora z listy: spadek gwiazdek o 3."
				.. "\n"
				.. "\n- Dzialanie checkboxow:"
				.. "\n	- Automatic Reroll: potwor jest zmieniany na losowego, a poziom obniza sie o maksymalnie 3 gwiazdki."
				.. "\n	- Lock Prey: potwor jest zachowany, a poziom obniza sie o maksymalnie 2 gwiazdki."
				.. "\n"
				.. "\n	- Zakres procentowy boostow to:"
				.. "\n		- Damage boost - 65%"
				.. "\n		- Damage reduction - 45%"
				.. "\n		- Experience boost - 50%"
				.. "\n		- Improved loot - 100%"
		)
	else
		player:popupFYI(
			"Prey info:"
				.. "\n"
				.. "\n- The duration of a prey decreases only while killing corresponding monster."
				.. "\n- You can purchase wildcard for gold coins at a Magic shop."
				.. "\n- Monster pool scales with your level."
				.. "\n"
				.. "\n- Prey buttons:"
				.. "\n	- Type/star reroll:"
				.. "\n		- Star upgrade: chance depends on current stars count - more stars means lower chance."
				.. "\n		- Star downgrade: star level can only decrease when prey is at level 9 or lower and the star was not upgraded."
				.. "\n		- Prey type change: 75% chance."
				.. "\n	- Reroll to random monster: lowers stars by 1."
				.. "\n	- Choose monster from list: lowers stars by 3."
				.. "\n"
				.. "\n- Prey checkboxes:"
				.. "\n	- Monster reroll: if level is higher than 4: lower stars by 33%, rounded in favor of the player"
				.. "\n	- Automatic Reroll: monster is rerolled, level is lowered by up to 3 stars."
				.. "\n	- Lock Prey: monster is kept, level is lowered by up to 2 stars."
				.. "\n"
				.. "\n	- The percentage ranges of each boost is:"
				.. "\n		- Damage boost: 29% - 65%"
				.. "\n		- Damage reduction: 18% - 45%"
				.. "\n		- Experience boost: 23% - 50%"
				.. "\n		- Improved loot: 27% - 100%"
		)
	end
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
