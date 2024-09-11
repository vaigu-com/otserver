local talkaction = TalkAction("!preyinfo")

function talkaction.onSay(player, words, param)
	if getPlayerLanguage(player) == "PL" then
		player:popupFYI(
			"Prey info:"
				.. "\n"
				.. "\n- Czas danego preya schodzi wylacznie podczas bicie danego potwora."
				.. "\n- Wildcard mozliwy do kupna za coiny w store oraz za gp w sklepach z magicznymi przedmiotami."
				.. "\n- Przelosowane potwory dostosowane sa do twojego poziomu."
				.. "\n"
				.. "\n- Dzialanie poziomow (gwiazdki):"
				.. "\n  - Uzycie wildcard:"
				.. "\n    - Wzrost gwiazdki: szansa zalezy od aktualnego poziomu: 1~5 - 80%; 6~7 - 25%; 8-9 - 15%"
				.. "\n    - Spadek gwiazdki: 20% szansy, jesli poziom nie wzrósł oraz masz mniej niz 10 gwiazdek."
				.. "\n    - Zmiana typu bonusu: 75% szansy."
				.. "\n"
				.. "\n- Zmiana preya:"
				.. "\n    - Przelosowanie zwykle: spadek poziomu o 50% za zaokragleniem do gory"
				.. "\n    - Automatic Reroll: potwor jest zmieniany na losowego, a poziom obniza sie o maksymalnie 3 gwiazdki."
				.. "\n 	  - Lock Prey: potwor jest zachowany, a poziom obniza sie o maksymalnie 3 gwiazdki."
				.. "\n"
				.. "\n- Maksymalny procentowy poziom danego boosta to:"
				.. "\n  - Damage boost - 70%"
				.. "\n  - Damage reduction - 50%"
				.. "\n  - Experience boost - 60%"
				.. "\n  - Improved loot - 100%"
		)
	else
		player:popupFYI(
			"Prey info:"
				.. "\n"
				.. "\n- The duration of a prey decreases only while killing corresponding monster."
				.. "\n- You can purchase wildcard for gold coins at a Magic shop."
				.. "\n- Monster pool scales with your level."
				.. "\n"
				.. "\n- Prey bonus mechanics:"
				.. "\n  - Using wildcard:"
				.. "\n    - Star upgrade: chance depends on current stars: 1~5 - 80%; 6~7 - 25%; 8-9 - 15%"
				.. "\n    - Star downgrade: 20% chance, is upgrade didnt occur and you have less than 10 star."
				.. "\n    - Bonus type change: 75% chance."
				.. "\n"
				.. "\n-  Chaning prey:"
				.. "\n    - Regular reroll: stars reduced by 50%, rounded up."
				.. "\n    - Automatic Reroll: monster is rerolled, level is lowered by up to 3 stars"
				.. "\n 	  - Lock Prey: monster is kept, level is lowered by up to 3 stars"
				.. "\n"
				.. "\n- The maximum percentage level of a given boost is:"
				.. "\n  - Damage boost - 70%"
				.. "\n  - Damage reduction - 50%"
				.. "\n  - Experience boost - 60%"
				.. "\n  - Improved loot - 100%"
		)
	end
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
