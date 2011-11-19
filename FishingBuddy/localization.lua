-- default to American English

FishingTranslations = {};

FishingTranslations["Inject"] = {
	DESCRIPTION = "#DESCRIPTION1# #DESCRIPTION2#",
	WINDOW_TITLE = "#NAME# v#VERSION#",
	WATCHERCLICKHELP = "#LEFTCLICKTODRAG#\n#RIGHTCLICKFORMENU#",
	BINDING_HEADER_FISHINGBUDDY_BINDINGS = "#NAME#",

	FISHCAUGHT = "%d/%d %s",
	
	BR = "\n",
	BRSPCS = "\n    ",
	DASH = " -- ",
	
	AUTHOR = "Sutorix (sutorix@hotmail.com)",
	COPYRIGHT = "(c) 2005-2010 by The Software Cobbler",
};

FishingTranslations["enUS"] = {
	NAME = "Fishing Buddy",
	
	-- we can (should?) translate everything below here
	DESCRIPTION1 = "Keep track of the fish you've caught",
	DESCRIPTION2 = "and manage your fishing gear.",

	-- Tab labels and tooltips
	LOCATIONS_INFO = "Shows where you've caught fish by either Area or Fish Type",
	LOCATIONS_TAB = "Locations",
	OPTIONS_INFO = "Set #NAME# options",
	OPTIONS_TAB = "Options",

	ABOUT_TAB = "About",
	WATCHER_TAB = "Watcher",

	POINT = "point",
	POINTS = "points",

	RAW = "Raw",
	FISH = "Fish",
	RANDOM = "Random",

	BOBBER_NAME = "Fishing Bobber",
	HELP = "help",
	SWITCH = "switch",
	UPDATEDB = "updatedb",
	FORCE = "force",

	OUTFITS = "Outfits",
	ELAPSED = "Elapsed",
	TOTAL = "Total",
	TOTALS = "Totals",

	SCHOOL = "School",  -- e.g. 'Oily Blackmouth School'
	FLOATING_WRECKAGE = "Floating Wreckage",
	FLOATING_DEBRIS = "Floating Debris",
	ELEM_WATER = "Elemental Water",
	OIL_SPILL = "Oil Spill",
	
	GOLD_COIN = "Gold coin",
	SILVER_COIN = "Silver coin",
	COPPER_COIN = "Copper coin",

	LAGER = "Captain Rumsey's Lager",
	
	ADD = "add",
	REPLACE = "replace",
	UPDATE = "update",
	CURRENT = "current",
	RESET = "reset",
	CLEANUP = "cleanup",
	CHECK = "check",
	NOW = "now",
	TIMER = "timer",
	CAST = "cast",

	NOREALM = "unknown realm",

	WATCHER = "watcher",
	WATCHER_LOCK = "lock",
	WATCHER_UNLOCK = "unlock",

	WEEKLY = "weekly",
	HOURLY = "hourly",

	OFFSET_LABEL_TEXT = "Offset:";

	KEYS_LABEL_TEXT = "Modifiers:",
	KEYS_NONE_TEXT = "None",
	KEYS_SHIFT_TEXT = "Shift",
	KEYS_CTRL_TEXT = "Control",
	KEYS_ALT_TEXT = "Alt",

	SHOWFISHIES = "Show fish",
	SHOWFISHIES_INFO = "Display fishing history grouped by fish type.",

	SHOWLOCATIONS = "Locations",
	SHOWLOCATIONS_INFO = "Display fishing history grouped by area caught.",

	ALLZOMGPETS = "Include all pets",

	-- Option names and tooltips
	CONFIG_SHOWNEWFISHIES_ONOFF	= "Show new fish",
	CONFIG_SHOWNEWFISHIES_INFO		= "Display a message in the chat area when a new fish for the current location is caught.",
	CONFIG_FISHWATCH_ONOFF			= "Fish watcher",
	CONFIG_FISHWATCH_INFO		 = "Display a text overlay with the fish caught in the current location.",
	CONFIG_FISHWATCHTIME_ONOFF		= "Show elapsed time",
	CONFIG_FISHWATCHTIME_INFO		= "Display the amount of time since you last equipped a fishing pole",
	CONFIG_FISHWATCHONLY_ONOFF		= "Only while fishing",
	CONFIG_FISHWATCHONLY_INFO	 = "Only show the Fish Watcher when we're actually fishing",
	CONFIG_FISHWATCHSKILL_ONOFF	= "Current skill",
	CONFIG_FISHWATCHSKILL_INFO	 = "Display the current fishing skill and mods in the fish watch area.",
	CONFIG_FISHWATCHZONE_ONOFF		= "Current zone",
	CONFIG_FISHWATCHZONE_INFO	 = "Display the current zone in the fish watch area.",
	CONFIG_FISHWATCHPERCENT_ONOFF = "Show percentages",
	CONFIG_FISHWATCHPERCENT_INFO	 = "Display the percentage of each kind of fish on the watch display.",

	CONFIG_EASYCAST_ONOFF	 = "Easy Cast",
	CONFIG_EASYCAST_INFO		 = "Enable double-right-click casting.",
	CONFIG_AUTOLOOT_ONOFF	 = "Auto Loot",
	CONFIG_AUTOLOOT_INFO		  = "If enabled, automatic looting is turned on while fishing.",
	CONFIG_USEACTION_ONOFF	 = "Use Action",
	CONFIG_USEACTION_INFO	 = "If enabled, #NAME# will look for an action bar button to use for casting.",
	CONFIG_MOUNTEDCAST_ONOFF = "Mounted",
	CONFIG_MOUNTEDCAST_INFO  = "If enabled, allow casting while mounted.",
	
	CONFIG_EASYLURES_ONOFF	 = "Easy Lures",
	CONFIG_EASYLURES_INFO	 = "If enabled, a lure will applied to your fishing pole before you start fishing, whenever you need one.",
	CONFIG_ALWAYSLURE_ONOFF	  = "Always Lure",
	CONFIG_ALWAYSLURE_INFO	  = "If enabled, put a lure on every time the pole doesn't have one.",
	CONFIG_LASTRESORT_ONOFF   = "Lure of last resort",
	CONFIG_LASTRESORT_INFO    = "If enabled, add the biggest lure we have even if it doesn't get us to 100% chance of a catch.",

	CONFIG_SHOWLOCATIONZONES_ONOFF	= "Show Zones",
	CONFIG_SHOWLOCATIONZONES_INFO = "Display both zones and subzones.",
	CONFIG_SORTBYPERCENT_ONOFF = "Sort by number caught",
	CONFIG_SORTBYPERCENT_INFO = "Order displays by the number of fish caught instead of by name.",
	CONFIG_TOOLTIPS_ONOFF	  = "Show fishing info in tooltips",
	CONFIG_TOOLTIPS_INFO	  = "If enabled, information about caught fish will be displayed in item tooltips.",
	CONFIG_ONLYMINE_ONOFF	  = "Outfit Pole Only",
	CONFIG_ONLYMINE_INFO      = "If enabled, easy cast will only check for your outfit's fishing pole (i.e. it won't search all possible poles for a match).",
	CONFIG_TURNOFFPVP_ONOFF	  = "Turn off PVP",
	CONFIG_TURNOFFPVP_INFO	  = "If enabled, PVP will be turned off while a fishing pole is equipped.",


	CONFIG_ENHANCESOUNDS_ONOFF	= "Enhance fishing sounds",
	CONFIG_ENHANCESOUNDS_INFO	= "When enabled, maximize sound volume and minimize ambient volume to make the bobber noise more noticeable while fishing.",

	CONFIG_BGSOUNDS_ONOFF	  = "Background sound",
	CONFIG_BGSOUNDS_INFO	  = "If enabled, sound will be enabled while WoW is in the background.",
	CONFIG_SPARKLIES_ONOFF	  = "Enhance Pools",
	CONFIG_SPARKLIES_INFO	  = "If enabled, the 'sparkles' on fishing pools will be more visible while fishing.",
	CONFIG_MAXSOUND_ONOFF     = "Full Volume",
	CONFIG_MAXSOUND_INFO      = "If enabled, set the sound volume to the maximum while fishing.",
	CONFIG_TURNONSOUND_ONOFF  = "Force sound",
	CONFIG_TURNONSOUND_INFO   = "If enabled, always turn on sounds while fishing.",

	CONFIG_AUTOOPEN_ONOFF	  = "Open quest items",
	CONFIG_AUTOOPEN_INFO		  = "If enabled, use a double-click to open up fishing quest items.",

	CONFIG_FISHINGFLUFF_ONOFF = "Fishing Fun",
	CONFIG_FISHINGFLUFF_INFO  = "Enable all sorts of fun while you fish.",
	CONFIG_FINDFISH_ONOFF	  = "Find Fish",
	CONFIG_FINDFISH_INFO		  = "Turn on the 'Find Fish' ability when dressed to fish.",
	CONFIG_DRINKHEAVILY_ONOFF = "Drink Lager",
	CONFIG_DRINKHEAVILY_INFO  = "If enabled, drink #LAGER# whenever you're fishing and 'dry'.",
	CONFIG_FISHINGBUDDY_ONOFF = "Fishing Buddy",
	CONFIG_FISHINGBUDDY_INFO  = "Bring out that special buddy while you fish.",
	
	CONFIG_WATCHBOBBER_ONOFF  = "Watch bobber",
	CONFIG_WATCHBOBBER_INFO	  = "If enabled, #NAME# will not cast if the cursor is over the Fishing Bobber.",
	
	CONFIG_CONTESTS_ONOFF	  = "Fishing contest support",
	CONFIG_CONTESTS_INFO	   = "Display timers for fishing contests.",
	
	CONFIG_STVTIMER_ONOFF	  = "Extravaganza timer",
	CONFIG_STVTIMER_INFO	  = "If enabled, display a countdown timer for the start of the Fishing Extravaganza and a countdown of the time left.",
	CONFIG_STVPOOLSONLY_ONOFF = "Only cast in pools",
	CONFIG_STVPOOLSONLY_INFO  = "If enabled, easy cast will only be enabled if the cursor is over a fishing hole.",
	CONFIG_DERBYTIMER_ONOFF	  = "Derby timer",
	CONFIG_DERBYTIMER_INFO	  = "If enabled, display a countdown timer for the start of the Kalu'ak Fishing Derby and a countdown of the time left.",
	CONFIG_SHOWPOOLS_ONOFF	  = "Show pools",
	CONFIG_SHOWPOOLS_INFO	  = "If enabled, known pool locations will be displayed on the minimap.",
	
	CONFIG_OUTFITTER_TEXT	  = "Outfit skill bonus: %s#BR#Draznar's style score: %d ",

	CLICKTOSWITCH_ONOFF		  = "Click to switch",
	CLICKTOSWITCH_INFO		  = "If enabled, a left click switches outfits, otherwise it brings up the Fishing Buddy window.",

	LEFTCLICKTODRAG = "Left-click to drag",
	RIGHTCLICKFORMENU = "Right-click for menu",

	MINIMAPBUTTONPLACEMENT = "Placement",
	MINIMAPBUTTONPLACEMENTTOOLTIP = "Allows you to move the #NAME# icon around the minimap.",
	MINIMAPBUTTONRADIUS = "Distance",
	MINIMAPBUTTONRADIUSTOOLTIP = "Determines how far from the minimap the #NAME# icon should be.",
	CONFIG_MINIMAPBUTTON_ONOFF = "Display minimap icon",
	CONFIG_MINIMAPBUTTON_INFO	= "Display a #NAME# icon on the minimap.",

	HIDEINWATCHER = "Display this fish in the watcher",

	-- messages
	COMPATIBLE_SWITCHER = "No compatible outfit switcher found.",
	TOOMANYFISHERMEN = "You have more than one easy cast mod installed.",
	FAILEDINIT = "Did not initialize correctly.",
	ADDFISHIEMSG = "Adding %s to location %s.",
	ADDSCHOOLMSG = "Adding '%s' to location %s.",
	NODATAMSG = "No fishing data available.",
	CLEANUP_NONEMSG = "No old settings remain.",
	CLEANUP_WILLMSG = "Old settings remaining for |c#RED#%s|r: %s.",
	CLEANUP_DONEMSG = "Old settings removed for |c#RED#%s|r: %s.",
	CLEANUP_NOOLDMSG = "There are no old settings for player |c#GREEN#%s|r.",
	NONEAVAILABLE_MSG = "None available",
	UPDATEDB_MSG = "Updated %d fish names.",

	MINIMUMSKILL = "Minimum skill: %d",
	NOTLINKABLE = "<Item is not linkable>",
	CAUGHTTHISMANY = "Caught:",
	CAUGHTTHISTOTAL = "Total:",
	FISHTYPES = "Fish types: %d",
	CAUGHT_IN_ZONES = "Caught in: %s",

	EXTRAVAGANZA = "Extravaganza",
	DERBY = "Derby",
	
	TIMETOGO = "%s starts in %d:%02d",
	TIMELEFT = "%s ends in %d:%02d",
	
	FATLADYSINGS = "|c#RED#%s is over|r (%d:%02d left)",
	
	-- Riggle Bassbait yells: We have a winner! NAME is the Master Angler!
	RIGGLE_BASSBAIT = "Riggle Bassbait yells: We have a winner! (%a+) is the Master Angler!",
	ELDER_CLEARWATER = "Elder Clearwater yells: (%a)+ has won the Kalu'ak Fishing Derby!",

	STVZONENAME = "Stranglethorn Vale",

	TOOLTIP_HINT = "Hint:",
	TOOLTIP_HINTSWITCH = "click to switch outfits",
	TOOLTIP_HINTTOGGLE = "click to show the #NAME# window.",

	-- Key binding support
	BINDING_NAME_FISHINGBUDDY_TOGGLE = "Toggle #NAME# Window",
	BINDING_NAME_FISHINGBUDDY_SWITCH = "Switch Fishing Outfit",
	BINDING_NAME_FISHINGBUDDY_GOFISHING = "Suit up and go fishing",

	BINDING_NAME_TOGGLEFISHINGBUDDY_LOC = "Toggle #NAME# Locations Pane",
	BINDING_NAME_TOGGLEFISHINGBUDDY_OPT = "Toggle #NAME# Options Pane",
	SWITCH_HELP = "|c#GREEN#/fb #SWITCH#|r#BRSPCS#swap outfits (if OutfitDisplayFrame or Outfitter is available)",
	WATCHER_HELP = "|c#GREEN#/fb #WATCHER#|r [|c#GREEN##WATCHER_LOCK#|r or |c#GREEN##WATCHER_UNLOCK#|r or |c#GREEN##RESET#|r]#BRSPCS#Unlock the watcher to move the window,#BRSPCS#lock to stop, reset to reset",
	CURRENT_HELP = "|c#GREEN#/fb #CURRENT# #RESET#|r#BRSPCS#Reset the fish caught during the current session.",
	UPDATEDB_HELP = "|c#GREEN#/fb #UPDATEDB# [#FORCE#]|r#BRSPCS#Try and find the names of all the fish we don't know already.#BRSPCS#An attempt is made to skip 'rare' fish that may disconnect you#BRSPCS#from the server -- use the '#FORCE#' option to override the check.",
	TIMERRESET_HELP = "|c#GREEN#/fb #TIMER# #RESET#|r#BRSPCS#Reset the location of the Extravaganza timer by moving it to#BRSPCS#the middle of the screen.",
	PRE_HELP = "You can use |c#GREEN#/fishingbuddy|r or |c#GREEN#/fb|r for all commands#BR#|c#GREEN#/fb|r: by itself, toggle the Fishing Buddy window#BR#|c#GREEN#/fb #HELP#|r: display this message",
	POST_HELP = "You can bind both the window toggle and the outfit#BR#switch command to keys in the \"Key Bindings\" window.",

	THANKS = "Thank you, everyone!",
	
	ROLE_TRANSLATE_ZHTW = "Traditional Chinese translation",
	ROLE_TRANSLATE_ZHCN = "Simplified Chinese translation",
	ROLE_TRANSLATE_DEDE = "German translation",
	ROLE_TRANSLATE_FRFR = "French translation",
	ROLE_TRANSLATE_ESES = "Spanish translation",
	ROLE_TRANSLATE_KOKR = "Korean translation",
	ROLE_TRANSLATE_RURU = "Russion translation",
	ROLE_HELP_BUGS = "Bug fixes and coding help",
	ROLE_HELP_SUGGESTIONS = "Feature suggestions",
	ROLE_ADDON_AUTHORS = "AddOn Author of Note",
}