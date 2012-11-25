	// only create the recruitment mission dialog

	if(dialog) then { CloseDialog 0; };

	if(format["%1", actionKeysNames "USER16"] == "") then {
		wcgarbage = ["Admin menu", "You should configure your user 16 personnal key to directly open this menu", "Choose your option", 10] spawn WC_fnc_playerhint;
	} else {
		wcgarbage = ["Admin menu", "You can access directly to this menu by pressing the "+format["%1",actionKeysNames "USER16"]+" key", "Choose your option", 10] spawn WC_fnc_playerhint;
	};



	_presetdlg = createDialog "RscDisplayLogs";