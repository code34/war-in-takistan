	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - defend an area

	private [
		"_arrayofvehicle", 
		"_count", 
		"_countdead", 
		"_delta",
		"_object", 
		"_markerdest", 
		"_missioncomplete", 
		"_position", 
		"_scriptinit", 
		"_timer", 
		"_units",
		"_vehicle"
	];

	_object = _this select 0;

	_missioncomplete = false;
	_timer = 300 + random (600);
	_count = 0;
	_countdead = 0;
	_delta = wcnumberofkilledofmissionW;

	_markerdest = [format['defendzone%1', wcdefendzoneindex], 300, position _object, 'ColorRED', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;
	wcdefendzoneindex = wcdefendzoneindex  + 1;

	//for "_x" from 0 to floor(random 2) step 1 do {
		_position = (position _object) findEmptyPosition [5, 100];
		if(count _position == 0) then {
			diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CREATE FRIENDLY DEFEND GROUP";
		};

		_type = ["M1A1_US_DES_EP1", "M2A2_EP1"] call BIS_fnc_selectRandom;
		_arrayofvehicle =[ _position, 0, _type, west] call BIS_fnc_spawnVehicle;
		_vehicle 	= _arrayofvehicle select 0;
		_arrayofpilot 	= _arrayofvehicle select 1;
		_group 		= _arrayofvehicle select 2;
		wcgarbage = [_vehicle, _markerdest, 'showmarker'] execVM 'extern\ups.sqf';
		processInitCommands;
	//};

	wcbegindefend = false;
	waituntil {wcbegindefend};

	for "_x" from 0 to ceil(random wclevelmaxincity) step 1 do {
		_position = [_position, 700, 1000] call WC_fnc_createpositionaround;
		_position = _position findEmptyPosition [5, 100];
		wcgarbage = [_position, _markerdest, (wcfactions call BIS_fnc_selectRandom), false] spawn WC_fnc_creategroupdefend;
		sleep 1;
	};

	for "_x" from 0 to ceil(random wclevelmaxincity) step 1 do {
		_position = [_position, 700, 1000] call WC_fnc_createpositionaround;
		_position = _position findEmptyPosition [5, 100];
		wcgarbage = [_position, _markerdest, (wcvehicleslistE call BIS_fnc_selectRandom), true] spawn WC_fnc_creategroupdefend;
		sleep 1;
	};

	while {!_missioncomplete} do {
        	sleep 1;
		_timer = _timer - 1;
		_countdead = _countdead + 1;
		if(_timer < 1) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			_missioncomplete = true;
			wcleveltoadd = 1;
		};
		if((wcnumberofkilledofmissionW - _delta) > (playersNumber west)) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", "Too much died"];
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			_missioncomplete = true;
		};
		if(!(alive _object) or (damage _object > 0.8)) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", "Objective has been destroyed"];
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			_missioncomplete = true;			
		};

		_units = nearestObjects[_object,["Man"], 1000];
		if ((west countside _units) < (ceil((playersNumber west) * 0.2))) then {
			_count = _count + 1;
		};
		if((_count == 60) or (_count == 120))then {
			wcmessageW = ["Commandement", "All players must stay in AREA!"];
			["wcmessageW", "client"] call WC_fnc_publicvariable;
		};
		if (_count > 180) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", "Too much players out of area"];
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			_missioncomplete = true;
		};
		if (_countdead > 60) then {
			_countdead = 0;
			wcmessageW = [format["Still %1 minutes", floor(_timer / 60)], format["%1/%2 players died", (wcnumberofkilledofmissionW - _delta), (playersNumber west)]];
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			// if less than 2 members lefts (base on uaz members number), we consider we should send new reinforcment
			{
				if(count (units _x) < 2) then {
					wcdefendgroup = wcdefendgroup - [_x];
				};
			}foreach wcdefendgroup;

			while { (count wcdefendgroup < wclevelmaxincity) } do {
				_position = [_position, 700, 1000] call WC_fnc_createpositionaround;
				_position = _position findEmptyPosition [5, 100];

				if(random 1 > 0.5) then {
					wcgarbage = [_position, _markerdest, (wcfactions call BIS_fnc_selectRandom), false] spawn WC_fnc_creategroupdefend;
				} else {
					if(wcwithenemyvehicle == 0) then {
						wcgarbage = [_position, _markerdest, (wcvehicleslistE call BIS_fnc_selectRandom), true] spawn WC_fnc_creategroupdefend;
					};
				};
				sleep 4;
			};
		};
	};