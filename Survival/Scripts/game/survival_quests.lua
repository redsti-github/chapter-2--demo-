quest_use_terminal = "be627075-4fc5-4c7d-a3b8-aec040b9776f"
quest_pickup_logbook = "bfb6e5b6-3ee3-4310-a1b3-7608eb3ecb8d"
quest_restore_power = "bfb6e5b6-3ee3-4310-a1b3-7608eb3ecb8e"

SurvivalQuests = {
	[quest_use_terminal] = {
		followup = quest_pickup_logbook
	},

	[quest_restore_power] = {},

	[quest_pickup_logbook] = {
		followup = quest_restore_power
	},

	
}