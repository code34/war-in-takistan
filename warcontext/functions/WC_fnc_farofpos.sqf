	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// take an objects array, and return an array with 
	// all objects far enough of distance min to the pos

	private [
		"_arrayofobjects",
		"_distancemin",
		"_position"
	];

	_arrayofobjects = _this select 0;
	_position = _this select 1;
	_distancemin = _this select 2;

	{
		if(_x distance _position < _distancemin) then {
			_arrayofobjects = _arrayofobjects - [_x];
		};
	}foreach _arrayofobjects;

	_arrayofobjects;