	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description:
	// create a grid of 9 positions NW,N,NE,W,C,E,SW,S,SE
	// around a position
	// -----------------------------------------------

	private [
		"_marker",
		"_position",
		"_position1",
		"_position2",
		"_position3",
		"_position4",
		"_position5",
		"_position6",
		"_position7",
		"_position8",
		"_position9",
		"_gridofposition",
		"_size",
		"_negativex",
		"_negativey",
		"_positivex",
		"_positivey",
		"_x",
		"_y"
	];

	_position	= _this select 0;
	_size		= _this select 1;

	_gridofposition = [];
	_x = _position select 0;
	_y = _position select 1;
	_negativex = _x - _size;
	_positivex = _x + _size;
	_negativey = _y - _size;
	_positivey = _y + _size;

	_position1 = [_negativex, _positivey];
	_position2 = [_x, _positivey];
	_position3 = [_positivex, _positivey];

	_position4 = [_negativex, _y];
	_position5 = _position;
	_position6 = [_positivex, _y];

	_position7 = [_negativex, _negativey];
	_position8 = [_x, _negativey];
	_position9 = [_positivex, _negativey];
	
	_gridofposition = [_position1,_position2,_position3,_position4,_position5,_position6,_position7,_position8,_position9];
	_gridofposition;