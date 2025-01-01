return {
	["Hello, you need some help? Check {services} that I offer..."] = "Hello, you need some help? Check {services} that I offer...",
	["You are in the MirkoTown temple. If you wish, I can {bless} you, {heal}, {promote} and {mark} most important civilians of this city on your map.\nYou can also get a {marriage} here."] = "You are in the MirkoTown temple. If you wish, I can {bless} you, {heal}, {promote} and {mark} most important civilians of this city on your map.\nYou can also get a {marriage} here.",
	["I marked few points of interest on your map."] = "I marked few points of interest on your map.",
	["Thank you."] = "Thank you.",
	["You have been blessed already."] = "You have been blessed already.",
	["You have been healed."] = "You have been healed.",
	["BLESS_PRICE_TEXT"] = function(context)
		local player = context.player
		local finalString = T("Blessing for you will cost :blessPrice: gold. It will protect you from losing equipment after death, and will reduce your death penatly. So, you want to get blessed?", {
			blessPrice = getBlessingsCost(player:getLevel()) * 5,
		})
		return finalString
	end,
	["BLESS_INSUFFICIENT_MONEY"] = function(context)
		local player = context.player
		local finalString = T("Sorry, but you need just.. :blessPrice: of gold for that.", {
			blessPrice = getBlessingsCost(player:getLevel()) * 5,
		})
		return finalString
	end,
	["PROMOTION_INSUFFICIENT_MONEY"] = function()
		local finalString = T("You need :price: gold for that!", { price = PROMOTION_PRICE })
		return finalString
	end,
	["You need at least 20 level to get promoted!"] = "You need at least 20 level to get promoted!",
	["PROMOTION_TEXT"] = function()
		local finalString = T("Are you sure? It will cost you :price: gold.", { price = PROMOTION_PRICE })
		return finalString
	end,
	["Here is your promotion, good luck!"] = "Here is your promotion, good luck!",
	["NO_PROPOSAL_RESPONSE"] = function(context)
		local finalString = T("{:spouse:} still didn't answer your proposal. Do you want to {cancel} your proposal?", {
			spouse = getPlayerNameById(getPlayerSpouse(context.player:getGuid())),
		})
		return finalString
	end,
	["INITIATE_PROPOSAL"] = function(context)
		local finalString = T("Great. Now we need to wait for {:spouse:} to accept your proposal.", {
			spouse = getPlayerNameById(getPlayerSpouse(context.player:getGuid())),
		})
		return finalString
	end,
	["You are already promoted!"] = "You are already promoted!",
	["Just ask me to get a {wedding} ceremony!"] = "Just ask me to get a {wedding} ceremony!",
	["At least one of you doens't have their wedding ring or wedding outfit box."] = "At least one of you doens't have their wedding ring or wedding outfit box.",
	["Would you like to get married? Make sure you have a {wedding ring} and the {wedding outfit box} with you."] = "Would you like to get married? Make sure you have a {wedding ring} and the {wedding outfit box} with you.",
	["You are married already. Do you want to get a {divorce} now?"] = "You are married already. Do you want to get a {divorce} now?",
	["My chronicles suggest that you are married already. Do you want to get a {divorce} now?"] = "My chronicles suggest that you are married already. Do you want to get a {divorce} now?",
	["Thats great! So you want to {marry} someone?"] = "Thats great! So you want to {marry} someone?",
	["And who would you like to marry?"] = "And who would you like to marry?",
	["You can buy wedding ring from local jewellery store, and wedding outfit box from Michael Dumplings clothing store."] = "You can buy wedding ring from local jewellery store, and wedding outfit box from Michael Dumplings clothing store.",
	["That person is already married"] = "That person is already married",
	["That person is someone else's fiance/fiancee."] = "That person is someone else's fiance/fiancee.",
	["I dont think thats the correct name."] = "I dont think thats the correct name.",
	["Thats not funny.."] = "Thats not funny..",
	["That's fine."] = "That's fine.",
	["You need to get {wedding ring} and {wedding outfit box} first. Then we can continue."] = "You need to get {wedding ring} and {wedding outfit box} first. Then we can continue.",
	["Since both young souls are willing to marry - get ready. Let me know if you are willing to start the {celebration}."] = "Since both young souls are willing to marry - get ready. Let me know if you are willing to start the {celebration}.",
	["Is your soulmate and friends here with you for the celebration?"] = "Is your soulmate and friends here with you for the celebration?",
	["Then go bring them here!"] = "Then go bring them here!",
	["Good, let's {begin} then!"] = "Good, let's {begin} then!",
	["MARRIAGE_TROPHY_DESC"] = function(context)
		local finalString = T("This trophy belongs to :player:, given to them by Ks. Natanek in memory of their wedding.", { player = context.player:getName() })
		return finalString
	end,
	["MARRIAGE_RING_DESC"] = function(context)
		local finalString = T(":player: and :spouse: forever and ever, since :date:", {
			player = context.player:getName(),
			spouse = getPlayerNameById(getPlayerSpouse(context.player:getGuid())),
			date = os.date("%B %d, %Y."),
		})
		return finalString
	end,
	["CONFIRM_DIVORCE"] = function(context)
		local finalString = T("So you want to get a divorce with :spouse:?", {
			spouse = getPlayerNameById(getPlayerSpouse(context.player:getGuid())),
		})
		return finalString
	end,
	["I'm very happy with your decision."] = "I'm very happy with your decision.",
	["You are not married to anyone."] = "You are not married to anyone.",
	["Well. I hope you wont regret it."] = "Well. I hope you wont regret it.",
	["You are not proposed to anyone."] = "You are not proposed to anyone.",
	["I won't be doing anything about that then."] = "I won't be doing anything about that then.",
	["It's cancelled."] = "It's cancelled.",
	["Are sure you want to cancel your proposal?"] = "Are sure you want to cancel your proposal?",
	["Your partner did not accept your proposal yet. You can {cancel} them if you like."] = "Your partner did not accept your proposal yet. You can {cancel} them if you like.",
	["MARRIAGE_TALKTYPE_SAY_TEXT"] = function(context)
		return T(
			"Dear friends and family, we are gathered here today to witness and celebrate the union of :player: and :spouse: in marriage.\n Through their time together, they have come to realize that their personal dreams, hopes, and goals are more attainable and more meaningful through the combined effort and mutual support provided in love, commitment, and family;and so they have decided to live together as husband and wife. And now, by the power vested in me by the Gods of Tibia, I hereby pronounce you husband and wife.\n*After a whispered blessing opens an hand towards :player:* Take these two engraved wedding rings and give one of them to your spouse.\nYou may now kiss your bride",
			{
				player = context.player:getName(),
				spouse = getPlayerNameById(getPlayerSpouse(context.player:getGuid())),
			}
		)
	end,
}
