	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr

	if (!isServer) exitWith {};
	private ["_ok", "_name", "_count", "_variables"];
	
	_name = _this select 1;

	diag_log format["WARCONTEXT: PLAYER %1 CONNECTING", _name];

	_ok = true;
	_count = 0;

	// WAIT THAT PLAYERS IS INITIALIZED
	while {_ok} do {
		if(_name in wcplayerready) then {
			_ok = false;
		};
		if(_count > 480) then {
			_ok = _false;
		};
		_count = _count + 1;
		sleep 1;
	};

	_variables = [
		"wcobjective",
		"wcnuclearzone",
		"wchostage",
		"wcday",
		"wcweather",
		"wcselectedzone",
		"wcradioalive",
		"wcskill",
		"wclevel",
		"wcmissioncount",
		"wcmotd",
		"wcenemykilled",
		"wccivilkilled",
		"wcinteam",
		"wcteleport"
	];

	{
		[_x, "client"] call WC_fnc_publicvariable;
		sleep 0.2;
	}foreach _variables; 


	diag_log format["WARCONTEXT: PLAYER %1 CONNECTED", _name];
