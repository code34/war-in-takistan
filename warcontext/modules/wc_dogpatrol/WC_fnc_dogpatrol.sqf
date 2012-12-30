	// -----------------------------------------------
	// Author:   code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Dogs attack script

	private [
		"_counter",
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
	_counter = 10;

	_position = [0,0,0];
	_unit setvariable ["destination", _position, false];
	_cible = objnull;

	WC_fnc_definedogcible = {
		private ["_dog", "_cible", "_cibles", "_list"];
		_dog = _this select 0;

		_cibles = [];
		_list = (position _dog) nearEntities [["Man"], 50];
		if(count _list > 0) then {
			{
				if(isplayer _x) then {
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
		}else{
			_cible = (([_dog, _cibles] call EXT_fnc_SortByDistance) select 0);
		};
		_cible;
	};

	while { alive _unit } do {
		if(isnull _cible or !alive _cible or _cible distance _unit > 100) then {
			_cible = [_unit] call WC_fnc_definedogcible;
		};

		// if no cible
		if(isnull _cible) then {
			if((count units _oldgroup > 0) and (group _unit != _oldgroup)) then {
				[_unit] joinsilent _oldgroup;
			};
		} else {
			if(group _unit == _oldgroup) then {
				_group = creategroup east;
				[_unit] joinsilent _group;
			};
			if(_unit distance _cible > 3) then {
				_position = position _cible;
				_unit setvariable ["destination", _position, false];
			        _unit setspeedMode "full";
			        _unit setbehaviour "safe";
				_unit domove _position;
				if(random 1 > 0.9) then {
					_unit say3d "dog_grognement";
				};
			} else {
				_unit dowatch _cible;
				_unit say3d "dog_bark";
				_cible setdamage (damage _cible) + 0.05;
				sleep ceil(random 3);
			};
		};
		sleep 1;
	};
	