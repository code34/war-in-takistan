	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description: 
	// get the terraform variance on map. 
	// More result is important more mountain there is
	// Example:
	// [[0,0,0], 500 ] execVM "WC_fnc_getterraformvariance.sqf";
	// -----------------------------------------------

	private [
		"_altitude",
		"_altitudeinitial",
		"_gridofposition",
		"_maxaltitude",
		"_position",
		"_posobject",
		"_object",
		"_size",
		"_variance"
	];

	_position	= _this select 0;
	_size		= 100;

	_object = createVehicle ["Can_small", _position, [], 0, "NONE"];
	_posobject =  getposasl _object;
	_altitudeinitial =  _posobject select 2;
	deletevehicle _object; 

	_gridofposition = [_position, _size] call WC_fnc_creategridofposition;
	_altitude = 0;
	_maxaltitude = _altitudeinitial;

	{
		_object = createVehicle ["Can_small", _x, [], 0, "NONE"];
		_posobject =  getposasl _object;
		_altitude = _posobject select 2;
		deletevehicle _object;
		if (_altitude > _maxaltitude) then {
			_position = _x;
			_maxaltitude = _altitude;
			call compile format ["hint 'maxalt: %1'; ", _maxaltitude];
		};
		sleep 0.05;
	} foreach _gridofposition;

	if (_altitudeinitial == _maxaltitude) then {
		_position;
	} else {
		_position = [_position] call WC_fnc_getterraformvariance;
		_position;
	};