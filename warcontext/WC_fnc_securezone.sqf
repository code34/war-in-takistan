	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext  - secure a zone

	private [
		"_unit", 
		"_enemys",
		"_global",
		"_count",
		"_counter"
	];

	_unit = _this select 0;
	_missioncomplete = false;

	_enemys = [];

	// wait initialization
	sleep 60;

	_global = nearestObjects[_unit,["Man"], wcdistance];
	{
		if!(isplayer _x) then {
			if!(side _x == civilian) then {
				_enemys = _enemys + [_x];
			};
		};
	}foreach _global;

	_global = nearestObjects[_unit,["Landvehicle"], wcdistance];
	{
		{
			if!(isplayer _x) then {
				if(!(side _x == civilian) and !(side _x == west)) then {
					_enemys = _enemys + [_x];

				};
			};
		}foreach (crew _x);
	}foreach _global;

	_count = count _enemys;
	_counter = 0;

	while {!_missioncomplete} do {
		_enemys = [];
		_counter = _counter + 1;
		_global = nearestObjects[_unit,["Man"], wcdistance];
		{
			if!(isplayer _x) then {
				if!(side _x == civilian) then {
					_enemys = _enemys + [_x];

				};
			};
		}foreach _global;

		_global = nearestObjects[_unit,["Landvehicle"], wcdistance];
		{
			{
				if!(isplayer _x) then {
					if(!(side _x == civilian) and !(side _x == west)) then {
						_enemys = _enemys + [_x];
	
					};
				};
			}foreach (crew _x);
		}foreach _global;


		if(_counter > 20) then {
			_counter = 0;
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMEN", format["Still %1 enemies", count _enemys, ceil(_count * 0.2)]];
			if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};			
		};

		// if - 10% of enemy stay on zone success
		if(count _enemys <= (_count * 0.2)) then {
			wcmessageW = ["Mission completed", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
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
			wcsecurezone = wcsecurezone + [position _unit];
		};
		sleep 4;
	};