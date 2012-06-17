	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description:
	// Backup building / compositions in clipboard
	// -----------------------------------------------

	private [
		"_marker",
		"_markersize",
		"_position",
		"_pos",
		"_dir",
		"_typeof",
		"_arrayof",
		"_x",
		"_i",
		"_xpos",
		"_ypos",
		"_absx",
		"_absy",
		"_var",
		"_text"
		];

	_marker 	= _this select 0;
	_position 	= getmarkerpos _marker;
	_markersize	= (getmarkersize _marker) select 0;
	
	_arrayof = [];
	_text = "";
	
	_temp = nearestObjects [_position, ["All"], _markersize];
	_xpos = _position select 0;
	_ypos = _position select 1;
	
	for "_i" from 0 to (count _temp) do {
		_x = _temp select _i;
		_pos = getPosATL _x;
		_absx = (_pos select 0) - _xpos;
		_absy = (_pos select 1) - _ypos;
		_dir = getdir _x;
		_type = typeof _x;
		_arrayof = _arrayof + [[[_absx, _absy, _pos select 2], _dir, _type]];
		_var = [[_absx, _absy, _pos select 2], _dir, _type];
		switch (_i) do {
			case 0: {
					_text = _text + format["[%1", _var];
				};
	
			case (count _temp):
				{
					_text = _text + format[",%1]", _var];
				};
			default
				{
				_text = _text + format[",%1", _var];
				};
		};
	};
	
	
	copyToClipboard _text;
	hint format ["Backup %1 Buildings", count _temp];