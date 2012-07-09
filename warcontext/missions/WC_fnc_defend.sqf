	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - defend an area

	private [
		"_arrayofvehicle", 
		"_count", 
		"_countdead", 
		"_delta",
		"_flag", 
		"_locations", 
		"_location", 
		"_markerdest", 
		"_missioncomplete", 
		"_position", 
		"_scriptinit", 
		"_timer", 
		"_units",
		"_vehicle"
	];

	_flag = _this select 0;

	_locations = nearestLocations [position _flag, ["NameCityCapital", "NameCity","NameVillage", "Name", "Hill", "Mount"], 1500];
	
	{
		if((position _x) distance (position _flag) < 700) then {
			_locations = _locations - [_x];
		};
	}foreach _locations;

	_missioncomplete = false;
	_timer = 300 + random (600);
	_count = 0;
	_countdead = 0;
	_delta = wcnumberofkilledofmissionW;

	_markerdest = [format['defendzone%1', wcdefendzoneindex], 300, position _flag, 'ColorRED', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;
	wcdefendzoneindex = wcdefendzoneindex  + 1;

	//for "_x" from 0 to floor(random 2) step 1 do {
		_position = (position _flag) findEmptyPosition [5, 100];
		_type = ["M1A1_US_DES_EP1", "M2A2_EP1"] call BIS_fnc_selectRandom;
		_arrayofvehicle =[ _position, 0, _type, west] call BIS_fnc_spawnVehicle;
		_vehicle 	= _arrayofvehicle select 0;
		_arrayofpilot 	= _arrayofvehicle select 1;
		_group 		= _arrayofvehicle select 2;
		//_scriptinit = format["wcgarbage = [this, '%1', 'showmarker'] execVM 'extern\ups.sqf';", _markerdest];
		//_vehicle setVehicleInit _scriptinit;
		wcgarbage = [_vehicle, _markerdest, 'showmarker'] execVM 'extern\ups.sqf';
		processInitCommands;
	//};

	wcbegindefend = false;
	waituntil {wcbegindefend};

	for "_x" from 1 to ceil(random 10) step 1 do {
		_location = _locations call BIS_fnc_selectRandom;
		_handle = [position _location, _markerdest, (wcfactions call BIS_fnc_selectRandom), false] spawn WC_fnc_creategroupdefend;
		sleep 1;
	};

	for "_x" from 1 to ceil(random 6) step 1 do {
		_location = _locations call BIS_fnc_selectRandom;
		_handle = [position _location, _markerdest, (wcvehicleslistE call BIS_fnc_selectRandom), true] spawn WC_fnc_creategroupdefend;
		sleep 1;
	};

	while {!_missioncomplete} do {
        	sleep 1;
		_timer = _timer - 1;
		_countdead = _countdead + 1;
		if(_timer < 1) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
				if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
				wcmissionsuccess = true;
				wcobjectiveindex = wcobjectiveindex + 1;
				_missioncomplete = true;
				wcleveltoadd = 1;
		};
		if((wcnumberofkilledofmissionW - _delta) > (playersNumber west)) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", "Too much died"];
			if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
		};
		_units = nearestObjects[_flag,["Man"], 1000];
		if ((west countside _units) < (ceil((playersNumber west) * 0.2))) then {
			_count = _count + 1;
		};
		if((_count == 60) or (_count == 120))then {
			wcmessageW = ["Commandement", "All players must stay in AREA!"];
			if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
		};
		if (_count > 180) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", "Too much players out of area"];
			if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			wcmessageW spawn EXT_fnc_infotext;
			_missioncomplete = true;
		};
		if (_countdead > 60) then {
			_countdead = 0;

			wcmessageW = [format["Still %1 minutes", floor(_timer / 60)], format["%1/%2 players died", (wcnumberofkilledofmissionW - _delta), (playersNumber west)]];
			if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else {["wcmessageW", "client"] call WC_fnc_publicvariable;};

			// if less than 2 members lefts (base on uaz members number), we consider we should send new reinforcment
			{
				if(count (units _x) < 2) then {
					wcdefendgroup = wcdefendgroup - [_x];
				};
			}foreach wcdefendgroup;

			while { (count wcdefendgroup < wclevelmaxincity) } do {
				_location = _locations call BIS_fnc_selectRandom;

				if(random 1 > 0.5) then {
					_handle = [position _location, _markerdest, (wcfactions call BIS_fnc_selectRandom), false] spawn WC_fnc_creategroupdefend;
				} else {
					if(wcwithenemyvehicle == 0) then {
						_handle = [position _location, _markerdest, (wcvehicleslistE call BIS_fnc_selectRandom), true] spawn WC_fnc_creategroupdefend;
					};
				};
				sleep 4;
			};
		};
	};