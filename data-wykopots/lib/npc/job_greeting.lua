JOBS_GREETINGS = {
	[JOB_DISTANCE_SOULORB] = "Hello, |PLAYERNAME|. My offers are bows, crossbows and ammunition. If you'd like to see, ask me for a {trade}. I can also exchange your {soul orbs}.",
	[JOB_ARMOR_WEAPON] = "Hello, I buy various equipment like armors, weapons, and.. well ask about {trade} to see my whole offer.",
	[JOB_MAGIC_WILDCARD] = "Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard}, which will increase your prey powers!",
	[JOB_CREATURE_PRODUCT] = "Hi, Im buying all kinds of creature products. Ask me for {trade} to browse through my offer.",
	[JOB_FURNITURE] = "Welcome to my workshop. If you would like to see my furniture and other wares, just ask me for {trade}.",
	[JOB_JEWELER] = "Hello |PLAYERNAME|. As a jeweler store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}",
	[JOB_UTILITY] = "Hello. My offer constists of tools that any cave explorer has to have to get around. Ask me for {trade} if you are interested.",
	[JOB_POST] = "I am local postman, ask about {trade} if you want to buy some parcel or letter.",
	[JOB_SOFT_BOOTS_RECHARGE] = "Hello! You want to {trade}, or repair your worn {soft boots}? I can also exchange your {medicine pouch}.",
	[JOB_FOOD] = "Oh hello! Check out my new recipes, we can {trade} a little.",
	[JOB_TASKS_IMBUING] = {
		text = "Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!",
		specialConditions = {
			[TASK_SPECIAL_CONDITIONS.hasDoneAnyTask] = {
				requiredOutcome = true,
				textOnFailedCondition = "Hello, I have some {tasks} for you. You can also ask for {trade}, if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}.",
			},
		},
	},
	[JOB_DAILYTASKS_GOLDENOUTFIT] = "Hello |PLAYERNAME|. You already finished a daily {task} from the notice board? You can {cancel} it whenever you want. I also have some {outfit} for the most generous donors.",
	[JOB_FISHER] = "Hello, I {trade} with fishing equipment, take a look at my offer if you want.",
	[JOB_AOL] = nil, -- 38f
}
