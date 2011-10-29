	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext  - rob a vehicle

	private [
		"_unit", 
		"_enemy", 
		"_startpos", 
		"_missioncomplete", 
		"_vehicle", 
		"_vehicle2", 
		"_group"
	];

	_unit = _this select 0;
	_startpos = position _unit;
	_missioncomplete = false;

	_unit setdamage floor(0.1 + random 0.7);
	_unit setVehicleInit "this setfuel 0;";
	processInitCommands;

	_group = createGroup east;
	_vehicle = _group createUnit ["TK_Soldier_Crew_EP1", position _unit, [], 2, "NONE"];
	_vehicle2 = _group createUnit ["TK_Soldier_Crew_EP1", position _unit, [], 4, "NONE"];

	_vehicle allowdammage false;
	_vehicle2 allowdammage false;

	wcgarbage = [_group] spawn WC_fnc_grouphandler;

	wcgarbage = [_vehicle] spawn WC_fnc_patrol;
	wcgarbage = [_vehicle2] spawn WC_fnc_patrol;

	wcgarbage = [_vehicle] spawn WC_fnc_dosillything;
	wcgarbage = [_vehicle2] spawn WC_fnc_dosillything;

	sleep 10;
	
	_vehicle allowdammage true;
	_vehicle2 allowdammage true;

	while {!_missioncomplete} do {
        	sleep 1;
		if((!alive _unit) or (damage _unit > 0.9)) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
		};
		if(_startpos distance position _unit > 1000) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
			wcleveltoadd = 1;
			wcenemyglobalfuel = wcenemyglobalfuel + wcbonusfuel;
		};
		if(isplayer (driver _unit)) then {
			_unit setVehicleInit "this setfuel 1;";
			processInitCommands;
		};
		if(count (crew _unit) > 0) then {
			{
				if(!(isplayer _x) and !(side _x in wcside)) then {
					_x action ["eject", _unit];
					unassignVehicle _x;
					(group _x) leaveVehicle _unit;
				};
			}foreach (crew _unit);
		};
	};

	sleep 120;

	_vehicle setdamage 1;
	_vehicle2 setdamage 1;
	deletevehicle _vehicle;
	deletevehicle _vehicle2;