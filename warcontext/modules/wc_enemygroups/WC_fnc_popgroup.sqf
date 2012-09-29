	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Pop enemy group of faction at pos
	// -----------------------------------------------
	if (!isServer) exitWith{};
	
	private [
			"_backpack",
			"_faction",
			"_group",
			"_position",
			"_side",
			"_sizeofgroup",
			"_unit",
			"_unitsoftype",
			"_unitsofgroup"
		];

	_faction = _this select 0;
	_side = _this select 1;
	_position = _this select 2;

	_unitsofgroup = [];
	_unitsoftype = [];

	_sizeofgroup = round (random 6);

	// retrieve all units of faction
	{
		if((_faction == (_x select 0)) and !((_x select 0) in wcblacklistenemyclass)) then {
			_unitsoftype = 	_unitsoftype + [(_x select 1)];
		};
	}foreach wcclasslist;

	// compose a random group
	for "_x" from 1 to _sizeofgroup do {
		if(count _unitsoftype > 0) then {
			_unitoftype = (_unitsoftype call BIS_fnc_selectRandom);
			_unitsoftype = _unitsoftype - [_unitoftype];
			_unitsofgroup = [_unitoftype] + _unitsofgroup;
		};
	};


	_group = createGroup _side;
	{
		_unit = _group createUnit [_x, _position, [], 10, 'FORM'];
		sleep 0.01;
	}foreach _unitsofgroup;

	_group;
