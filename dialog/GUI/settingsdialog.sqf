	private ["_text", "_kindofgame", "_kindofserver", "_autoload", "_combined"];

	MenuAction = -1;
	
	playsound "paper";
	
	ctrlSetText [13001, Format [localize "STR_ACGUI_VM_TXT_VD", wcviewDist]];
	ctrlSetText [13003, Format [localize "STR_ACGUI_VM_TXT_TG", (50 - wcterraingrid)]];
	
	SliderSetRange[13002,100, wcviewdistance];
	SliderSetRange[13004,0, 50];
	
	SliderSetPosition[13002, wcviewDist];
	SliderSetPosition[13004, (50 - wcterraingrid)];
	
	_kindofgame = if(wckindofgame == 1) then {"arcade";} else {"simulation";};
	_kindofserver = switch (wckindofserver) do { case 1: {"team";}; case 2: {"open";}; case 2: {"no team";}; };
	_autoload = if(wcautoload == 0) then {"no";} else {"yes";};
	_combined = if (wccombined == 0) then {"Arrowhead";}else{"Combined operation";};
	_text = format["Server settings\n\nKind of game: %1\nKind of server: %5\nView Distance max: %2\nAutoload addons: %3\nGame content: %4\n\nMissing addons on client side:\n", _kindofgame, wcviewdistance, _autoload, _combined,_kindofserver];

	if(wcautoload == 1) then {
		if(count wccfglocalpatches > 0) then {
			{
				_text = _text + format["%1\n", _x];
			}foreach wccfglocalpatches;
		} else {
				_text = _text + "None";
		};
	} else {
		_text = _text + "None";
	};

	ctrlSetText [13007, _text];
	
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




