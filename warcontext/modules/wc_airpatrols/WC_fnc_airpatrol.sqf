	// -----------------------------------------------
	// Author:   code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Seek & destroy air patrol script

	private [
		"_bucket",
		"_destposition",
		"_flag",
		"_formationtype",
		"_group", 
		"_lastposition",
		"_position", 
		"_unit", 
		"_vehicle"
	];

	_unit = _this select 0;
	_positon = _this select 1;

	_vehicle = vehicle _unit;
	_group = group _unit;

	_formationtype = ["COLUMN", "STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"] call BIS_fnc_selectRandom;

	_position = ["airzone"] call WC_fnc_createpositioninmarker;

	_group setCombatMode "BLUE";
	_group setBehaviour "COMBAT";

	_unit domove [_position select 0, _position select 1, 300];
	_vehicle flyInHeight 300;

	_bucket = 0;
	_lastposition = [0,0];

	_flag = true; 

	while {_flag} do {
		if(_lastposition distance (position _vehicle) < 5) then {
			_bucket = _bucket + 1;
		};

		_lastposition = position _vehicle;

		if(_bucket > 5) then {
			_position = ["airzone"] call WC_fnc_createpositioninmarker;
			_group setBehaviour "COMBAT";
			(driver _vehicle) domove [_position select 0, _position select 1, 300];
			(vehicle _unit) flyInHeight 300;
			_bucket = 0;
		};

		_destposition = (expectedDestination (driver _vehicle)) select 0;
		_destposition = [_destposition select 0, _destposition select 1];

		if(format["%1", _destposition] == "[0,0]") then {
			_position = ["airzone"] call WC_fnc_createpositioninmarker;
			_group setBehaviour "COMBAT";
			(driver _vehicle) domove [_position select 0, _position select 1, 300];
		};

		if((getdammage _vehicle > 0.6) or (count(units _group) == 0)) then {
			_flag = false;
		};
	
		sleep 1;
	};

	{
		_x domove [0,0];
	} foreach (units _group);

	sleep 120;

	{
		_x setdammage 1;
		deletevehicle _x;
	} foreach (units _group);

	_vehicle setdammage 1;
	deletevehicle _vehicle;