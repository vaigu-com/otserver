local name = "Messenger of Heaven"
local outfit = {
	lookType = 714,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
}

local customDialogs = {
	[{ GREET }] = { text = "Greetings, Player! It's good to see you {alive}." },
	[{ "alive" }] = { text = "With the world in {peril}, everyone's life is at stake." },
	[{ "peril" }] = { text = "The actions of Ferumbras and the sinister minions of the {thing} from beyond have shattered the world. The thing is worming its way into our reality and its workings will cause further {damage}." },
	[{ "thing" }] = { text = "To name it is to give it power. Even to think about it gives it a hold. But it can't be helped and now that it is entering our world it doesn't worsen the matter significantly. ...\nYet, thinking about it might call for its attention and might give it a hold upon you. At least that was the case in the {past}." },
	[{ "past" }] = { text = "Through history several of those who were too curious became aware of its existence - or better its lack. They were touched and tainted by the knowledge. ...\nIt is assumed that the ancient Yalahari were the first to really grasp at least part of the concept of what it is. This knowledge gave it a tremendous hold over the Yalahari's minds and it even gave it a {name}." },
	[{ "name" }] = {
		text = "Names hold power. The gods called things into existence by naming them. By giving something a name, it becomes more real. Ideas become concepts, feelings become expressible and so on. ...\nIn the case of the thing that wasn't, the name gave it a hold on reality, gave it a glimpse at our world. By naming it, the Yalahari began to understand it, in a twisted way at least. ...\nA knowledge that was twisted in itself and twisted the minds of those who knew. At last, the Yalahari vanished from the world and even the gods don't know their fate for sure. ...\nNow that this thing - which was not meant to be - entered our world, its name might be old news, so to say. However, it's still dangerous and malignant, nothing to be spoken or thought of lightly, especially not by you mortals.",
	},
	[{ "ferumbras" }] = { text = "Probably his vain plea for ascension has brought upon him a fate worse than hell." },
	[{ "damage" }] = {
		text = "While the thing becomes more real, it sheds layers of destruction and negligence of reality. Those layers are becoming threats on their own. ...\nThey eat away matter as well as laws of nature. They are threatening the creation as a whole. Even without doing anything more than becoming more and more real, the thing might win by simply undoing creation. This has to be stopped!",
	},
	[{ "stopped" }] = {
		text = "The destruction that comes with that thing shares the intention of its progenitor to become more real. Therefore, the destruction has gathered into something that - under other circumstances - would be called avatars. ...\nSome destructive and unnatural forces have condensed themselves to highly dangerous constructs that are gnawing at existence itself. Even now their workings can be felt. ...\nAll over the world incursions like this one here can be encountered. They eat away matter, sanity and order - sucking them into nothingness. Behind these incursions, on the brink to nothingness and annihilation, the non-avatars are lurking. ...\nTheir most potent incarnation has been named Heart of Destruction. But there are others - less potent but disruptive on their own. The heart gives those mindless forces unity and purpose. ...\nIt unites them to the threat that they are. Every incursion itself it only restricted to time and space. Reality will eventually heal and recover, although not for an unlimited amount of time. ...\nIt is the heart what makes them so dangerous and gives them drive. Under the hunger and anger of the Heart of Destruction, the incursions are more potent and reality is breaking. ...\nTo stop them from devouring reality, the destruction has to be stopped by {destroying} its heart.",
	},
	[{ "destroying" }] = {
		text = "You will notice many incursions throughout the world. They are accompanied by waves of uncreated beings. By killing them, you weaken the incursion which they are part of. Yet, you will get tainted with their disruptive nature. ...\nA person of strong will might resist the taint and even use it to enter the incursions. Beyond them awaits only a thin layer of ... let's call it yet undigested reality in which the non-avatars nest. ...\nEach incursion, aside from similarities, hosts another of those things. All of them are kin to their source, the {Heart of Destruction}. ...\nIf you manage to destroy one of them, a part of its ungodly charge will be passed upon you. Again you might be able to use that to your advantage, though. ...\nIf you manage to slay the different masters of the greater incursions, you'll eventually blend in with their disruptive nature and might venture further into the incursions and challenge the heart itself. ...\nBut even getting to the masters of the incursions will not be an easy task. Each of them will be guarded by some kind of instinctive reaction that will have to be dealt with before you might advance to the incursion's master.",
	},
	[{ "Heart of Destruction" }] = {
		text = "One can only call this thing the world devourer. It eats away reality and feeds on the world itself. ...\nThe thing is as unfathomable as the thing that spawned it. It is doubtful that its creation was an act of will. Regardless it is the utmost threat that we face right now. ...\nAs long as the world devourer exists, the healing powers of reality will not suffice to contain the damage caused by the incursions. Likely sooner than later reality and its laws will begin to break. ...\nThe thing itself is nothing anyone has ever encountered yet. Its existence alone is an anathema to creation and is hurting the world. ...\nIt's something between existence and destruction, between force and creature. Its whole existence is a paradox itself and harmful to the world. We have no idea how it works or what are its weaknesses. ...\nIt will take a keen mind to figure this out and a {strong} heart and soul to endure the perils on the way.",
	},
	[{ "strong" }] = { text = "Your future is still not written because the forces of uncreation are still tearing on reality. For the sake of your world, please hurry! \n" },
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
