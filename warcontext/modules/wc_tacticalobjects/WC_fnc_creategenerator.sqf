	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Compute groups/vehicles in the locations
	// create a radio tower

	if (!isServer) exitWith{};

	private [
		"_building",
		"_buildings",
		"_marker", 
		"_position",
		"_type"
	];

	_position = _this select 0;

	_type = wcgeneratortype call BIS_fnc_selectRandom;

	_buildings = nearestObjects [_position,["Building"], 300];
	sleep 1;
	_building = _buildings call BIS_fnc_selectRandom;

	if(count (position _buiding) > 0) then {
		_position = (position _building) findEmptyPosition [1, 100];
		if(count _position == 0) exitwith {
			diag_log "WARCONTEXT: no position for generator found";
		};
	};

	wcgenerator = createVehicle [_type, _position, [], 0, "NONE"];
	wcgenerator setpos _position;

	wcgenerator setVehicleInit "this addAction ['<t color=''#ffcb00''>Sabotage</t>', 'warcontext\actions\WC_fnc_dosabotage.sqf',[true],6,false];";
	processInitCommands;

	if(wcwithgeneratormarkers == 1) then {
		_marker = ['generator', 0.5, position wcgenerator, 'ColorRED', 'ICON', 'FDIAGONAL', 'mil_triangle', 0, 'Generator site', false] call WC_fnc_createmarker;
	};

	wcgenerator setVectorUp [0,0,1];

	diag_log format["WARCONTEXT: CREATE A GENERATOR: %1", _type];