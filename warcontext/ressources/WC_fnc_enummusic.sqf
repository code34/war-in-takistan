	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// Enums music - warcontext
	// -----------------------------------------------

	private ["_tracks", "_entry", "_sidetotarget", "_sidenum"];

	_tracks = [];
	_sidetoget = _this select 0;

	_entry = configFile >> "CfgMusic";
	for "_i" from 1 to ((count _entry) - 1) do {
			_tracks = _tracks + [configName(_entry select _i)];
	};

	_tracks;