	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a hint marker local

	if (!local player) exitWith {};

	private [
		"_timer", 
		"_marker", 
		"_size", 
		"_turn"
	];

	waituntil {format ["%1", wcselectedzone] != "[0,0,0]"};

	_marker = _this select 0;

	_size = 2;
	_marker setmarkersizelocal [_size,_size];

	_turn = 0;

	while { true } do {
		_turn = _turn + 5;
		_marker setmarkerdirlocal _turn;
		_marker setmarkerposlocal wcselectedzone;
		if(_turn > 355) then { _turn = 0; };
		sleep 0.05;
	};