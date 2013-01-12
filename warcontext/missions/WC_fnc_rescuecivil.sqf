	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - rescue some civils

	private [
		"_unit", 
		"_enemy", 
		"_enemy", 
		"_missioncomplete",
		"_typeof",
		"_position",
		"_civilrescue",
		"_civilrescuenumber",
		"_civils",
		"_civil",
		"_group",
		"_type",
		"_vehicle",
		"_vehicles",
		"_count",
		"_number",
		"_counter"
	];

	_unit = _this select 0;
	_number = _this select 1;

	_civils = [];
	_civilrescue = [];
	_civilrescuenumber = 0;

	_missioncomplete = false;

	_group = creategroup civilian;
	for "_i" from 1 to _number do {
		_type = wcrescuecivils call BIS_fnc_selectRandom;
		_civil = _group createUnit [_type, position _unit, [], 5, "FORM"];
		_civil setVehicleInit "this addAction ['<t color=''#ffcb00''>Hands up</t>', 'warcontext\actions\WC_fnc_dohandsup.sqf',[],6,false, true];";
		_civil setVehicleInit "this addAction ['<t color=''#ffcb00''>Follow me</t>', 'warcontext\actions\WC_fnc_dofollowme.sqf',[],6,false, true];";
		_civil setVehicleInit "this addAction ['<t color=''#ffcb00''>Search Civil</t>', 'warcontext\actions\WC_fnc_dosearchsomeone.sqf',[],6,false, true];";
		processInitCommands;
		_civil stop true;
		sleep 0.5;
	};

	_civils = units _group;
	_group allowFleeing 0;

	wcgarbage = [_group] spawn WC_fnc_civilhandler;	

	_counter = 20;
	while {!_missioncomplete} do {
		_count = 0;
		{
			if(_x distance getmarkerpos "respawn_west" < 100) then {
				_x domove getmarkerpos "respawn_west";
				_count = _count + 1;
			};
			if!(alive _x) then {
				_civils = _civils - [_x];
			};
		}foreach _civils;

		if(_count == count _civils) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
			wcleveltoadd = 1;
			wcfame = wcfame + wcbonusfame;
			wcenemyglobalelectrical = wcenemyglobalelectrical + wcbonuselectrical;
			wcenemyglobalfuel = wcenemyglobalfuel + wcbonusfuel;
		};

		if(count _civils < floor(0.80 * _number)) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
			wcleveltoadd = 0;
		};

		if(_counter > 20) then {
			_position = (position (leader _group)) findEmptyPosition[ 1 , 20];
			"SmokeShellRed" createVehicle _position;
			wcmessageW = [format["Still %1 civils", (count _civils - _count)], "to rescue"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; };
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			_counter = 0;
		};
		_counter = _counter + 1;
		sleep 5;
	};