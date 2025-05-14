local talkaction = TalkAction("!bosses", "!bosy")

function talkaction.onSay(player, words, param)
	local dreamboss = Game.getStorageValueByKey(Storage.DreamBoss) or "Unknown"
	local deeplingboss = Game.getStorageValueByKey(Storage.DeeplingBoss) or "Unknown"
	local wereboss = Game.getStorageValueByKey(Storage.WereBoss) or "Unknown"

	player:popupFYI("Daily bosses available:\n" .. "\nDeepling: " .. deeplingboss .. "\nWerecreature: " .. wereboss .. "\nDream Court: " .. dreamboss)
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
