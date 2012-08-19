	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - create a mine field at road position (near position parameter)

	private [
		"_number",
		"_marker",
		"_mine",
		"_name",
		"_position",
		"_roads"
	];

	_position = _this select 0;
	_number = (random 5);

	WC_fnc_PDB = {
		_pos = _this select 0;
		_bearing = _this select 1;
		_distance = _this select 2;
		[ (_pos select 0) + (_distance*(sin _bearing)) ,(_pos select 1)+(_distance*(cos _bearing))];
	};

	_roads = _position nearRoads 400;
	{
		if!((count (roadsConnectedTo _x) > 1) and (count (nearestObjects [_x,["house"], 20]) > 0))then{
			_roads = _roads - [_x];
		};
	}forEach _roads;

	_position = position (_roads call BIS_fnc_selectRandom);

	if(count _position > 0) then {
		_name = format["mrkminefield%1", wcminefieldindex];
		wcminefieldindex = wcminefieldindex + 1;

		_marker = [_name, 0.5, _position, 'ColorRed', 'ICON', 'FDIAGONAL', 'hd_warning', 0, "", false] call WC_fnc_createmarkerlocal;
		wcambiantmarker = wcambiantmarker + [_marker];

		for "_x" from 0 to _number step 1 do {
			_mine = createMine ["MineMine", _position, [], 10];
			wcobjecttodelete = wcobjecttodelete + [_mine];
		};
	
		diag_log format["WARCONTEXT: GENERATE A MINEFIELD AT POSITION %1", _position];
	};