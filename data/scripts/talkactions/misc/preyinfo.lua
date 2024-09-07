local talkaction = TalkAction("!preyinfo")

function talkaction.onSay(player, words, param)
	if getPlayerLanguage(player) == "PL" then
		player:popupFYI(
			"Prey info:"
				.. "\n"
				.. "\n- Czas danego preya schodzi wylacznie podczas bicie danego potwora."
				.. "\n- Wildcard mozliwy do kupna za coiny w store oraz za gp u Fstaba."
				.. "\n- Pula losowanych potworow zmienia sie do 200 lvl."
				.. "\n"
				.. "\n- Dzialanie poziomow (gwiazdki):"
				.. "\n  - Uzycie wildcard:"
				.. "\n    - 20% szansy na spadek gwiazdki"
				.. "\n    - 60% szansy na wzrost gwiazdki"
				.. "\n    - 20% szansy na zmiane samego bonusu"
				.. "\n"
				.. "\n  - Utrata preya:"
				.. "\n    - spadek o 1 lub 2 gwiazdki od poprzedniej wartosci"
				.. "\n"
				.. "\n - Automatic Reroll dziala jak uzycie wildcard z zachowaniem moba"
				.. "\n - Lock Prey - standardowe dzialanie (zachowuje wszystko)"
				.. "\n"
				.. "\n- Maksymalny procentowy poziom danego boosta to:"
				.. "\n   - Damage boost - 25%"
				.. "\n   - Damage reduction - 30%"
				.. "\n   - Experience boost - 30%"
				.. "\n   - Improved loot - 40%"
		)
	else
		player:popupFYI(
			"Prey info:"
				.. "\n"
				.. "\n- The time of a given prey decreases only while killing given monster."
				.. "\n- Wildcard is available to purchase with coins in store and for gp's at Fstab."
				.. "\n- Monster pool is getting changed based on lvl until 200."
				.. "\n"
				.. "\n- Prey bonus mechanics:"
				.. "\n  - Using wildcard:"
				.. "\n    - 20% chance to get -1 star"
				.. "\n    - 60% chance to get +1 star"
				.. "\n    - 20% chance to only change bonus type"
				.. "\n"
				.. "\n  - Losing prey:"
				.. "\n    - losing 1 or 2 stars from previous value"
				.. "\n"
				.. "\n - Automatic Reroll works like wildcard while maintaining monster type"
				.. "\n - Lock Prey - keeps all the bonuses (only restore time)"
				.. "\n"
				.. "\n- The maximum percentage level of a given boost is:"
				.. "\n  - Damage boost - 25%"
				.. "\n  - Damage reduction - 30%"
				.. "\n  - Experience boost - 30%"
				.. "\n  - Improved loot - 40%"
		)
	end
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
