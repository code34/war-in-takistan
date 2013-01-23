	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - secure a zone

	private [
		"_counter",
		"_enemys",
		"_global",
		"_position",
		"_sizeofzone",
		"_unit"

	];

	_unit = _this select 0;
	_position = position _unit;

	_sizeofzone = 400;

	_missioncomplete = false;

	_enemys = [];

	// wait initialization
	sleep 120;

	_counter = 0;

	while {!_missioncomplete} do {
		_enemys = [];
		_counter = _counter + 1;
		_global = nearestObjects[_unit,["Man"], _sizeofzone];
		{
			if!(isplayer _x) then {
				if((side _x == east) or (side _x == resistance)) then {
					_enemys = _enemys + [_x];

				};
			};
		}foreach _global;

		_global = nearestObjects[_unit,["Landvehicle"], _sizeofzone];
		{
			{
				if!(isplayer _x) then {
					if((side _x == east) or (side _x == resistance)) then {
						_enemys = _enemys + [_x];
	
					};
				};
			}foreach (crew _x);
		}foreach _global;


		if(_counter > 20) then {
			_counter = 0;
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", format["Still %1 enemies", count _enemys]];
			["wcmessageW", "client"] call WC_fnc_publicvariable;			
		};

		// if -5 of enemy stay on zone success
		if(count _enemys < 5) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			_missioncomplete = true;
			wcleveltoadd = 1;
			wcfame = wcfame + wcbonusfame;
			wcenemyglobalelectrical = wcenemyglobalelectrical + wcbonuselectrical;
			wcenemyglobalfuel = wcenemyglobalfuel + wcbonusfuel;
			wcsecurezoneindex = wcsecurezoneindex + 1;
			_marker = [format["wcsecurezone%1", wcsecurezoneindex], "rescuezone"] call WC_fnc_copymarker;
			_marker setMarkerColor "ColorBlue";
			_marker = [format["wcsecuretext%1", wcsecurezoneindex], _marker] call WC_fnc_copymarker;
			_marker setmarkertext "Zone is safe"; 
			_marker setMarkershape "ICON"; 
			_marker setMarkersize [1,1]; 
			_marker setMarkerType "Warning";
			_marker setMarkerColor "ColorBlue";			
			wcsecurezone = wcsecurezone + [_position];
			wcgarbage = [] spawn WC_fnc_deletemissioninsafezone;
		};
		sleep 4;
	};