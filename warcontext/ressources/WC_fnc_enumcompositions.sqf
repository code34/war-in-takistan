	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// Enums compositions - warcontext
	// -----------------------------------------------

	private ["_compositions", "_entry", "_sidetotarget", "_sidenum"];

	_compositions = [];
	_sidetoget = _this select 0;

	switch (_sidetoget) do {
		case east : { _sidenum = 0;};
		case west : { _sidenum = 1;};
		case resistance : { _sidenum = 2;};
		case civilian : { _sidenum = 3;};
	};

	_entry = configFile >> "CfgObjectCompositions";
	for "_i" from 0 to ((count _entry) - 1) do {
		if(getnumber ((_entry select _i) >> "side") == _sidenum) then {
			_compositions = _compositions + [configName(_entry select _i)];
		};
	};

	_compositions;