	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr, Xeno - domination
	// warcontext - create a settings dialog box
	// locality : client side

	private [
		"_autoload", 
		"_combined",
		"_text", 
		"_kindofgame", 
		"_kindofserver", 
		"_terraingrid",
		"_viewdist",
		"_viewdistmax"
	];

	MenuAction = -1;
	
	playsound "paper";

	_terraingrid = wcterraingrid;
	_viewdist = wcviewdist;
	_viewdistmax = wcviewdistance;
	
	ctrlSetText [13001, Format [localize "STR_ACGUI_VM_TXT_VD", _viewdist]];
	ctrlSetText [13003, Format [localize "STR_ACGUI_VM_TXT_TG", (50 - _terraingrid)]];
	
	SliderSetRange[13002,100, _viewdistmax];
	SliderSetRange[13004,0, 50];
	
	SliderSetPosition[13002, _viewdist];
	SliderSetPosition[13004, (50 - _terraingrid)];
	
	_text = "Game settings";
	lbAdd [13007, _text];

	for "_i" from 0 to (count paramsArray - 1) do {
		_text = format["%1 = %2", configName ((missionConfigFile >> "Params") select _i), paramsArray select _i];
		lbAdd [13007, _text];
	};

	_text = "";
	lbAdd [13007, _text];

	_text = "Missing Addons";
	lbAdd [13007, _text];

	if(count wccfglocalpatches > 0) then {
		{
			_text = format["%1", _x];
			lbAdd [13007, _text];
		}foreach wccfglocalpatches;
	} else {
			_text = "None";
			lbAdd [13007, _text];
	};
	
	while {alive player && dialog} do {
		sleep 0.1;
	
		_viewdist = Floor (SliderPosition 13002);
		_terraingrid = (50 - Floor (SliderPosition 13004));
		
		ctrlSetText [13001, Format [localize "STR_ACGUI_VM_TXT_VD",_viewdist]];
		ctrlSetText [13003, Format [localize "STR_ACGUI_VM_TXT_TG", (50 - _terraingrid)]];
		
		if (MenuAction == 2) then {
			MenuAction = -1;
			closeDialog 0;

			setViewDistance _viewdist;
			setTerrainGrid _terraingrid;

			wcterraingrid = _terraingrid;
			wcviewdist = _viewdist;
		};
	};




