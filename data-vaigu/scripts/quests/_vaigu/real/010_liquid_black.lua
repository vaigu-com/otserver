local quest = Quest(LOCALIZERS)

quest:Storage(function ()
    
end)
:Constant(function ()
    
end)
:Questlog(function ()
    Quests[NextQuestId()] = {
        name = "Liquid Black",
        missions = {
            [Storage.LiquidBlack] = {
                name = "Visitor",
                states = {
                    [2] = "You have found notes and coordinates. Try to find out what they are for.",
                    [3] = "You got teleported to Mezamir by a strange teleporter. Ask him about this machine.",
                    [4] = "Mezamir let you dive into the place he tried to discover years ago. Find a large staircase heading underwater on Pirate Island and find out what's below.",
                    [5] = "You have found a shortcut to the deeplings' underwater base.",
                },
            },
        },
    }
end)
:Mission(PH_MISSION)
:STATE(PH_STATE,
QuestFactory.Dialog("PH_NAME", {}))