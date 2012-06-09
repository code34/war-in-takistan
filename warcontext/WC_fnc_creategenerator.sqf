	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Compute groups/vehicles in the locations
	// create a radio tower

	if (!isServer) exitWith{};

	private [
		"_marker", 
		"_position",
		"_type"
	];

	_position = _this select 0;

	_type = wcgeneratortype call BIS_fnc_selectRandom;

	wcgenerator = createVehicle [_type, _position, [], 0, "NONE"];
	wcgenerator setVehicleInit "this addAction ['<t color=''#ff4500''>Sabotage</t>', 'warcontext\actions\WC_fnc_dosabotage.sqf',[true],-1,false];";
	processInitCommands;

	if(wcwithgeneratormarkers == 1) then {
		_marker = ['generator', 0.5, position wcgenerator, 'ColorRED', 'ICON', 'FDIAGONAL', 'mil_triangle', 0, 'Generator site', false] call WC_fnc_createmarker;
	};

	wcgenerator setVectorUp [0,0,1];

	diag_log format["WARCONTEXT: CREATE A GENERATOR: %1", _type];