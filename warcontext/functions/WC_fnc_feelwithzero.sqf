	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  feel empty string with 0
	// -----------------------------------------------

	private [
		"_variable",
		"_count"
	];

	_variable = _this select 0;
	_count = _this select 1;

	if(isnil "_count") then {_count = 2};

	while {count (toarray _variable) < _count} do {
		_variable = format ["0%1", _variable];
	};
	
	_variable;