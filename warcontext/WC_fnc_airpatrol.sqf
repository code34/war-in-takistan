	// -----------------------------------------------
	// Author:  =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Nasty seek & destroy patrol script from scratch

	private [
		"_unit", 
		"_group", 
		"_cible", 
		"_position", 
		"_lastposition",
		"_cibles", 
		"_min", 
		"_count", 
		"_count2", 
		"_count3",
		"_list",
		"_distance",
		"_move",
		"_formationtype",
		"_marker",
		"_vehicle",
		"_exit",
		"_time"
	];

	_unit = _this select 0;
	_vehicle = vehicle _unit;

	_formationtype = ["COLUMN", "STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"] call BIS_fnc_selectRandom;

	if((vehicle _unit) iskindof "Air") then {
		waituntil { format["%1", wcselectedzone] != "[0,0,0]"};
		_position = wcselectedzone;
	};

	if((vehicle _unit) iskindof "Ship") then {
		_position = [wcmaptopright, wcmapbottomleft, "onsea"] call WC_fnc_createposition;
	};

	while {alive _unit} do {
		_position = ["airzone"] call WC_fnc_createpositioninmarker;
		_group setBehaviour "COMBAT";
		_group setCombatMode "GREEN";
		_unit domove [_position select 0, _position select 1, 150];
		(vehicle _unit) flyInHeight 150;
		waituntil { (_unit distance [_position select 0, _position select 1, 150] < 100)};
	};


	_exit = false;
	while {!_exit} do {
		if((position _unit) distance [0,0,0] < 1000) then {
			_exit = true;
		};
		if (alive _unit) then {
			_unit domove [0,0,0];
		} else {
			_exit = true;
		};
		sleep 10;
	};

	{
		_x setdammage 1;
		deletevehicle _x;
	} foreach (crew _vehicle);

	_vehicle setdammage 1;
	deletevehicle _vehicle;