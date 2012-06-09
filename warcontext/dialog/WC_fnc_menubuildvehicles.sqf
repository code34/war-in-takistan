	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a mission dialog box
	// locality : client side

	private [
		"_array",
		"_missionnumber", 
		"_name", 
		"_textbox", 
		"_index", 
		"_rank",
		"_type",
		"_maxsize",
		"_unit",
		"_vehicles"
	];

	if!(name player in wcinteam) exitwith {
		[localize "STR_WC_MENURECRUITMENT", "Only members of team can build", "Wait to be recruit as team member", 10] spawn WC_fnc_playerhint;
		closedialog 0;
	};

	disableSerialization;
	_textbox = (uiNamespace getVariable 'wcdisplay') displayCtrl 7001;

	switch(wcwithvehicles) do {
		case 1: {
			_vehicles = [];
		};

		case 2: {
			_vehicles = wcvehicleslistathq;
		};

		case 3: {
			_vehicles = wcvehicleslistW;
		};
	};

	_array = [];

	{
		_name = gettext (configfile >> "cfgVehicles" >> _x >> "Displayname");
		_index = lbAdd [7002, _name];
		_array set [_index, _x];
	}foreach _vehicles;

	lbSetCurSel [7002, 0];

	while {alive player && dialog} do {
		_index = lbCurSel 7002;
		_type = _array select _index;

		if(menuaction == 1) then {
			["Build a vehicle", "Wait while the building of your vehicle", "The vehicle will appear near you in few seconds. Older one will be delete.", 3] spawn WC_fnc_playerhint;
			_position = (position player) findemptyposition [5, 30];
			deletevehicle wcmyatv;
			closedialog 0;
			menuaction = -1;
			sleep 3;
			wcmyatv = _type createVehicle _position;
		};
		if(menuaction == 2) then {
			closedialog 0;
			menuaction = -1;
		};
		sleep 0.5;
	};