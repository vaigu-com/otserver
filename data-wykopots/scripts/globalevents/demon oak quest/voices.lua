local questArea = {
	Position(6091, 1066, 7), --{x = 6091, y = 1066, z = 7}
	Position(6110, 1078, 7), --{x = 6110, y = 1078, z = 7}
}

local sounds = {
	"Release me and you will be rewarded greatefully!",
	"What is this? Demon Legs lying here? Someone might have lost them!",
	"I'm trapped, come here and free me fast!!",
	"I can bring your beloved back from the dead, just release me!",
	"What a nice shiny golden armor. Come to me and you can have it!",
	"Find a way in here and release me! Pleeeease hurry!",
	"You can have my demon set, if you help me get out of here!",
}

local globalevent = GlobalEvent("DemonOakVoices")

function globalevent.onThink(...)
	local spectators, spectator = Game.getSpectators(DEMON_OAK_POSITION, false, true, 0, 15, 0, 15)
	local sound = sounds[math.random(#sounds)]
	for i = 1, #spectators do
		spectator = spectators[i]
		if isInRange(spectator:getPosition(), questArea[1], questArea[2]) then
			return true
		end

		spectator:say(sound, TALKTYPE_MONSTER_YELL, false, 0, DEMON_OAK_POSITION)
	end
	return true
end

globalevent:interval(10 * 60 * 1000) --10min
globalevent:register()
