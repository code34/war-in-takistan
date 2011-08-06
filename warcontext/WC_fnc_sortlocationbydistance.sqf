	private [
		"_locations", 
		"_sorted", 
		"_distancemax", 
		"_unit", 
		"_nearest"
		];

	_unit = _this select 0;
	_locations = nearestLocations [position _unit, ["Name","NameCityCapital","NameCity","NameVillage","NameLocal","Hill","Mount", "ViewPoint","RockArea"], 400];
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