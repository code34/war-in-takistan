	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  sentinelle in static weapon
	// -----------------------------------------------
	
	private [
		"_unit", 
		"_enemys", 
		"_count", 
		"_counter", 
		"_position", 
		"_gridofposition", 
		"_distancemax", 
		"_cible", 
		"_enemyside", 
		"_initialposition", 
		"_group"
	];

	_unit = _this select 0;
	_enemyside = _this select 1;
	_names = [];

	if(format["%1", _unit] == "any") exitWith{};

	_enemys = [];
	_count = 0;
	_counter = 0;
	_position = position _unit;
	_gridofposition = [_position, 100, 360, getdir _unit, 10] call WC_fnc_createcircleposition;

	_initialposition = getposatl _unit;

	while { alive _unit } do {
		_enemys = nearestObjects [_unit, ["Man"], 200];
		_distancemax = 200;
		_counter = _counter + 1;
		{
			if((random 1 > 0.97) or (wcalert > 99)) then {
				_unit reveal _x;
			};
			if (((side _x) in _enemyside) and (_unit knowsAbout _x > 0.5)) then {
				if( _unit distance _x < _distancemax) then { _distancemax = _unit distance _x; _cible = _x;};
				_count = _count + 1;
			};
			sleep 0.05;
		}foreach _enemys;

		if(_count == 0) then {
			_group setBehaviour "SAFE";
			_group setCombatMode "WHITE";
			_group setSpeedMode "LIMITED";
			if ((getposatl _unit) distance _initialposition < 100) then {
				if(vehicle _unit == _unit) then {
					if (_counter > 6) then {
						_position = [((getpos _unit) select 0) + ([5,20] call WC_fnc_seed), ((getpos _unit) select 1) + ([5,20] call WC_fnc_seed)];
						_unit domove _position;
						_counter = 0;
					} else {
						_unit dowatch (_gridofposition call BIS_fnc_selectRandom);
					};
				} else {
					_unit dowatch (_gridofposition call BIS_fnc_selectRandom);
				};
			} else {
				_unit domove _initialposition;
			};
		} else {
			_unit dowatch _cible;
			_unit dofire _cible;
			_unit dotarget _cible;
			if(vehicle _unit == _unit) then {
				if!( _cible distance (_unit getHideFrom _cible) > 10) then {
					_group setBehaviour "STEALTH";
					_group setSpeedMode "LIMITED";
				} else {
						_group setBehaviour "COMBAT";
						_group setCombatMode "RED";
						_group setSpeedMode "FULL";
						_unit domove position _cible;
				};
			} else {
				_group setBehaviour "COMBAT";
				_group setCombatMode "RED";
				_group setSpeedMode "FULL";
			};
			{
				_x reveal _cible;
			}foreach units (group _unit);
		};
		_count = 0;
		sleep 5;
	};