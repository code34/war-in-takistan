	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Liberate Island
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_timer", 
		"_marker", 
		"_size", 
		"_turn"
	];

	waituntil {format ["%1", wcselectedzone] != "[0,0,0]"};

	_marker = _this select 0;

	_size = 2;
	_marker setmarkersize [_size,_size];

	_turn = 0;

	while { true } do {
		_turn = _turn + 5;
		_marker setmarkerdir _turn;
		_marker setmarkerpos wcselectedzone;
		if(_turn > 355) then { _turn = 0; };
		sleep 0.05;
	};