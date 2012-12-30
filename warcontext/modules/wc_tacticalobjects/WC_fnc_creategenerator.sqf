	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Create an energy generator

	if (!isServer) exitWith{};

	private [
		"_building",
		"_buildings",
		"_generatortype",
		"_generator",
		"_marker", 
		"_newposition",
		"_position",
		"_type"
	];

	_position = _this select 0;
	_generatortype = _this select 1;

	_type = _generatortype call BIS_fnc_selectRandom;

	_buildings = nearestObjects [_position,["Building"], 300];
	sleep 1;
	_building = _buildings call BIS_fnc_selectRandom;

	if(count (position _buiding) > 0) then {
		_newposition = (position _building) findEmptyPosition [1, 10];
		if(count _newposition > 0) then {
			_position = _newposition;
		};
	};

	_generator = createVehicle [_type, _position, [], 0, "NONE"];
	_generator setpos _position;

	_generator setVehicleInit "this addAction ['<t color=''#ffcb00''>Sabotage</t>', 'warcontext\actions\WC_fnc_dosabotage.sqf',[true],6,false];";
	processInitCommands;

	if(wcwithgeneratormarkers == 1) then {
		_marker = ['generator', 0.5, position _generator, 'ColorRED', 'ICON', 'FDIAGONAL', 'mil_triangle', 0, 'Generator site', false] call WC_fnc_createmarker;
	};

	_generator setVectorUp [0,0,1];

	diag_log format["WARCONTEXT: CREATE A GENERATOR: %1", _type];

	_generator;