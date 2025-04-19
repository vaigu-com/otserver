JOB_GREETINGS = {
	[JOB_DISTANCE_SOULORB] = { text = "Hello, |PLAYERNAME|. My offers are bows, crossbows and ammunition. If you'd like to see, ask me for a {trade}. I can also exchange your {soul orbs}." },
	[JOB_ARMOR_WEAPON] = { text = "Hello, I buy various equipment like armors, weapons, and.. well ask about {trade} to see my whole offer." },
	[JOB_MAGIC_WILDCARD] = { text = "Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard}, which will increase your prey powers!" },
	[JOB_MAGIC]  = {text = "Hello |PLAYERNAME|. My offer mainly contains supplies for mages."},
	[JOB_CREATURE_PRODUCT] = { text = "Hi, Im buying all kinds of creature products. Ask me for {trade} to browse through my offer." },
	[JOB_FURNITURE] = { text = "Welcome to my workshop. If you would like to see my furniture and other wares, just ask me for {trade}." },
	[JOB_JEWELLER] = { text = "Hello |PLAYERNAME|. As a jeweler store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}" },
	[JOB_UTILITY] = { text = "Hello. My offer constists of tools that any cave explorer has to have to get around. Ask me for {trade} if you are interested." },
	[JOB_DAILYTASKS_GOLDENOUTFIT] = { text = "Hello |PLAYERNAME|. You already finished a daily {task} from the notice board? You can {cancel} it whenever you want. I also have some {outfit} for the most generous donors." },
	[JOB_FISHER] = { text = "Hello, I {trade} with fishing equipment, take a look at my offer if you want." },
	[JOB_SOFT_BOOTS_RECHARGE] = { text = "Hello! You want to {trade}, or repair your worn {soft boots}? I can also exchange your {medicine pouch}." },
	[JOB_FOOD] = { text = "Oh hello! Check out my new recipes, we can {trade} a little.", "Hello! You look really hungry.. Ask about {trade} to see my offer." },
	[JOB_TASKS_IMBUING] = {
		text = "Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!",
		specialRequirements = {
			{
				requirement = SPECIAL_REQUIREMENTS_TASKS.hasDoneAnyTask,
				requiredOutcome = true,
				textFailedRequirement = "Hello, I have some {tasks} for you. You can also ask for {trade}, if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}.",
			},
		},
	},
	[JOB_AOL] = {
		text = "Siemano siemanko, |PLAYERNAME| ja jestem Jurek i sprzedaje zabezpieczenie przed zbyt ostrym imprezowaniem! Napisz {trade} to zobaczysz o co mi chodzi!"
	},
	[JOB_POST] = { 
		text = {
			"Hello, |PLAYERNAME|. You want to buy parcel, letter, or make a bank transfer? Im here to help you.",
			"I am local postman, ask about {trade} if you want to buy some parcel or letter.",
		},
	},
	[JOB_BANK] = { text = "Yes? What may I do for you, |PLAYERNAME|? Bank business, perhaps?" },
}
