	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - sort location by distance of an object

	private [
		"_locations", 
		"_sorted", 
		"_distancemax", 
		"_unit", 
		"_nearest"
		];

	_unit = _this select 0;
	_locations = _this select 1;

	_sorted = [];
		
	while { count _locations > 0 } do {
		_distancemax = 1000000;
		{
			if(position _x distance _unit < _distancemax) then {
				_nearest = _x;
				_distancemax = position _x distance _unit;
			};
		}foreach _locations;
		_sorted = _sorted + [_nearest];
		_locations = _locations - [_nearest];
	};

	_sorted;