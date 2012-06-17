	// -----------------------------------------------
	// Author: MH6 - rework  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create a positions circle of x points around position

	private [
		"_positions", 
		"_position", 
		"_dir", 
		"_radius", 
		"_degree", 
		"_numberofposition"
	];

	_position = _this select 0;
	_radius = _this select 1;
	_degree = _this select 2;
	_dir = _this select 3;
	_numberofposition = _this select 4;
	
	_positions = [];	
	_dir = _dir - 90;
	_degree = _degree /_numberofposition; 

	for "_i" from 1 to _numberofposition do {
		_a = (_position select 0)+(sin(_dir)*_radius);
		_b = (_position select 1)+(cos(_dir)*_radius);
		_positions = _positions + [[_a,_b,_position select 2]];
		_dir = _dir + _degree;
	};
	
	_positions;