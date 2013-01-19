	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Create an energy generator

	if (!isServer) exitWith{};

	private [
		"_arrayofpos",
		"_building",
		"_buildings",
		"_exit",
		"_generatortype",
		"_generator",
		"_marker", 
		"_newposition",
		"_position",
		"_type"
	];

	_position = _this select 0;
	_generatortype = _this select 1;

	_exit = false;
	_type = _generatortype call BIS_fnc_selectRandom;

	_arrayofpos = [_position, "all"] call WC_fnc_gethousespositions;
	if(count _arrayofpos == 0) exitwith {
		diag_log "WARCONTEXT: GENERATOR CAN NOT BE BUILD CAUSE FAR OF BUILDINGS";
	};

	_position = (_arrayofpos call BIS_fnc_selectRandom) findEmptyPosition [1, 10];
	if(count _position == 0) exitwith {
		diag_log "WARCONTEXT: GENERATOR CAN NOT BE BUILD CAUSE FAR OF BUILDINGS";
	};

	_generator = createVehicle [_type, _position, [], 0, "NONE"];
	_generator setpos _position;

	_generator setVehicleInit "this addAction ['<t color=''#ffcb00''>Sabotage</t>', 'warcontext\actions\WC_fnc_dosabotage.sqf',[true],6,false];";
	processInitCommands;

	if(random 1 > 0.20) then {
		wcgarbage = [_generator] spawn WC_fnc_protectobject;
	};

	if(wcwithgeneratormarkers == 1) then {
		_marker = ['generator', 0.5, position _generator, 'ColorRED', 'ICON', 'FDIAGONAL', 'mil_triangle', 0, 'Generator site', false] call WC_fnc_createmarker;
	};

	_generator setVectorUp [0,0,1];

	diag_log format["WARCONTEXT: CREATE A GENERATOR: %1", _type];

	_generator;