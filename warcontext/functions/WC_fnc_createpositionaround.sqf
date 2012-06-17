	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// create a position around another position

	if (!isServer) exitWith{};

	private [
		"_position",
		"_oldposition",
		"_distancemin",
		"_x",
		"_y",
		"_xtemp",
		"_ytemp",
		"_newx",
		"_newy",
		"_radius",
		"_size"
	];

	_oldposition = _this select 0;
	_distancemin = _this select 1;
	_radius = _this select 2;

	_size = _radius - _distancemin;

	_position = [0,0,0];

	while {format["%1", _position] == "[0,0,0]"} do {

		_x = _oldposition select 0;
		_y = _oldposition select 1;

		if (random 1 > 0.5) then { _xtemp = ((random _size) + _distancemin); } else { _xtemp = ((random _size) + _distancemin) * -1; };
		if (random 1 > 0.5) then { _ytemp = ((random _size) + _distancemin); } else { _ytemp = ((random _size) + _distancemin) * -1; };

		_newx = ceil(_xtemp + _x);
		_newy = ceil(_ytemp + _y);
		_position = [_newx, _newy];

		if (surfaceIsWater _position) then {
			_position = [0,0,0];
		};
		sleep 0.01;
	};

	_position;