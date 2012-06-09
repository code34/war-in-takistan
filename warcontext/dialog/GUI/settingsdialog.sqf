	private ["_text", "_kindofgame", "_kindofserver", "_autoload", "_combined"];

	MenuAction = -1;
	
	playsound "paper";
	
	ctrlSetText [13001, Format [localize "STR_ACGUI_VM_TXT_VD", wcviewDist]];
	ctrlSetText [13003, Format [localize "STR_ACGUI_VM_TXT_TG", (50 - wcterraingrid)]];
	
	SliderSetRange[13002,100, wcviewdistance];
	SliderSetRange[13004,0, 50];
	
	SliderSetPosition[13002, wcviewDist];
	SliderSetPosition[13004, (50 - wcterraingrid)];
	
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
	
		wcviewDist = Floor (SliderPosition 13002);
		wcterraingrid = (50 - Floor (SliderPosition 13004));
		
		ctrlSetText [13001, Format [localize "STR_ACGUI_VM_TXT_VD",wcviewDist]];
		ctrlSetText [13003, Format [localize "STR_ACGUI_VM_TXT_TG", (50 - wcterraingrid)]];
		
		if (MenuAction == 2) then {
			MenuAction = -1;
			closeDialog 0;
			setViewDistance wcviewDist;
			setTerrainGrid wcterraingrid;
		};
	};




