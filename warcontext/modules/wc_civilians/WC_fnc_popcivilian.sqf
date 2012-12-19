	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - pop civilian (replace BIS MODULE)
	// -----------------------------------------------

	
	private [
		"_buildings", 
		"_number", 
		"_civil", 
		"_civiltype", 
		"_civilrole",
		"_exit",
		"_group", 
		"_marker", 
		"_size", 
		"_name", 
		"_allunits", 
		"_position", 
		"_positions", 
		"_index", 
		"_active", 
		"_back",
		"_count",
		"_location"
	];

	_location = (_this select 0);
	_position = position (_this select 0);


	_positions = [];
	_allunits = [];
	_back = [];

	_name = format["civiltown%1", wcciviltownindex];
	wcciviltownindex  = wcciviltownindex + 1;
	_marker = [_name, 500, _position, 'ColorBLACK', 'ELLIPSE', 'FDIAGONAL', 'EMPTY', 0, '', false] call WC_fnc_createmarkerlocal;

	_active = createTrigger["EmptyDetector", _position];
	_active setTriggerArea[wccivildistancepop, wccivildistancepop, 0, false];
	_active setTriggerActivation["WEST", "PRESENT", TRUE];
	_active setTriggerStatements["", "", ""];

	_exit = 0;
	_count = count (nearestObjects [_position, ["House"] , 150]);
	while { ((_count < 4) or (_exit <4)) } do {
		_count = count (nearestObjects [_position, ["House"] , 150]);
		_exit = _exit + 1;
		sleep 1;
	};

	if(_exit > 3) exitwith {
		diag_log "WARCONTEXT: NO FOUND ENOUGH HOUSES FOR CIVILIANS POP";
	};

	_buildings = nearestObjects[_position,["Building"], 500];
	sleep 1;

	{
		_index = 0;
		while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
			_position = _x buildingPos _index;
			_positions = _positions + [_position];
			_index = _index + 1;
		};
	}foreach _buildings;

	_number = random wcwithcivilian;
	_group = creategroup civilian;
	for "_x" from 0 to _number do {
		_civiltype = wccivilclass call BIS_fnc_selectRandom;
		_position = _positions call BIS_fnc_selectRandom;
		if((random 1 < wcterroristprobability) and !(_civiltype in wccivilwithoutweapons)) then {
			_civilrole = ["bomberman","propagander","altercation","saboter","builder","healer"] call BIS_fnc_selectRandom;
		} else {
			if(random 1 < wcciviliandriverprobability) then {
				_civilrole = "driver";
			} else {
				_civilrole = "civil";
			};
		};
		_back = _back + [[_civiltype, _position, _civilrole]];

	};

	while { true } do {
		// restore civils
		if(west countside list _active == 0) then {
			{
				if(alive _x) then {
					_civilrole = _x getvariable "civilrole";
					_back = _back + [[typeof _x, position _x, _civilrole]];
					_x removeAllEventHandlers "Killed";
					_x setdammage 1;
					deletevehicle _x;
				};
			}foreach (units _group);
			deletegroup _group;
			waituntil {(west countside list _active > 0)};
			_group = creategroup civilian;
			{
				_civiltype = _x select 0;
				_civil = _group createUnit [_civiltype, (_x select 1), [], 0, "FORM"];
				_civil setVehicleInit "this addAction ['<t color=''#ffcb00''>Hands up</t>', 'warcontext\actions\WC_fnc_dohandsup.sqf',[],6,false, true];";
				_civil setVehicleInit "this addAction ['<t color=''#ffcb00''>Follow me</t>', 'warcontext\actions\WC_fnc_dofollowme.sqf',[],6,false, true];";
				_civil setVehicleInit "this addAction ['<t color=''#ffcb00''>Search Civil</t>', 'warcontext\actions\WC_fnc_dosearchsomeone.sqf',[],6,false, true];";
				_position = _positions call BIS_fnc_selectRandom;
				_civil setvariable ["civilrole", (_x select 2), true];
				_civil setvariable ["destination", _position, false];
				_civil setvariable ["wcprotected", true, false];
				wccivilianstoinit = wccivilianstoinit + [_civil];
			}foreach _back;
			wcgarbage = [_group] spawn WC_fnc_civilhandler;			
			wcgarbage = [_group] spawn WC_fnc_walkercivilian;
			processInitCommands;
			_back = [];
		};
		sleep 5;
	};