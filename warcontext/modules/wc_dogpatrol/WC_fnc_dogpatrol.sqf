	// -----------------------------------------------
	// Author:   code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Dogs attack script

	private [
		"_cible",
		"_cibles",
		"_enemyside",
		"_group",
		"_list",
		"_position",
		"_oldgroup",
		"_unit"
	];

	_unit = _this select 0;
	_enemyside = [west];
	_oldgroup = group _unit;

	_position = [0,0,0];
	_unit setvariable ["destination", _position, false];
	_cible = objnull;

	while { alive _unit } do {
		_cibles = [];
		_list = (position _unit) nearEntities [["Man"], 100];
		if(count _list > 0) then {
			{
				if(side _x in _enemyside) then {
					_cibles = _cibles + [_x];
				} else {
					_list = _list - [_x];
				};
				sleep 0.1;
			}foreach _list;
		} else {
			_cibles = [];
		};

		if(count _cibles == 0) then {
			_cible = objnull;
			if((count units _oldgroup > 0) and (group _unit != _oldgroup)) then {
				[_unit] joinsilent _oldgroup;
			};
		} else {
			if(group _unit == _oldgroup) then {
				_group = creategroup east;
				[_unit] joinsilent _group;
			};
			if(isnull _cible or !alive _cible or _cible distance _unit > 100) then {
				_cible = (([_unit, _cibles] call EXT_fnc_SortByDistance) select 0);
			};
			if((_unit getvariable "destination") distance (position _cible) > 3) then {
				_position = position _cible;
				_unit setvariable ["destination", _position, false];
				_unit setspeedmode "full";
				_unit domove _position;
				_unit dowatch _cible;
				_oldgroup setBehaviour "COMBAT";
				_oldgroup setCombatMode "RED";
				_unit say3d "dog_grognement";
			} else {
				_unit say3d "dog_bark";
				_cible setdamage (damage _cible) + 0.05;
			};
		};
		sleep 1;
	};
	