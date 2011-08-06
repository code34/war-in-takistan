	// write the motd

	if(isnil "wcmotd") then {
		wcmotd = [];
	};

	if(name player in wcinteam) then {
		_presetdlg = createDialog "RscDisplaypaperboard";
	} else {
		["Informations of the day", "Only members of team can write informations of the day", "Wait to be recruit as team member",  10] spawn WC_fnc_playerhint;
	};