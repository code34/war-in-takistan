	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_typeof",
		"_position",
		"_pilot",
		"_gunner",
		"_waypoint",
		"_vehicle",
		"_group",
		"_combatmode",
		"_behaviour",
		"_vehicle",
		"_fuel",
		"_zone",
		"_zonepos",
		"_zonesize",
		"_enemys",
		"_distancemax",
		"_cible",
		"_count"
	];

	_vehicle = _this select 0;
	_position = _this select 1;

	_pilot = driver _vehicle;
	_gunner = gunner _vehicle;

	_group = group _pilot;

	_combatmode = "RED";
	_behaviour = "COMBAT";

	while {((getdammage _vehicle < 0.6) and (count (units _group) > 0))} do {
		_group setCombatMode _combatmode;
		_group setBehaviour _behaviour;

		_count = 0;
		_enemys = nearestObjects [_vehicle, ["AllVehicles"], 400];
		_distancemax = 400;
		{
			if (side (driver _x) in wcside) then {
				_pilot reveal (driver _x);
				if( _vehicle distance _x < _distancemax) then { _distancemax = _vehicle distance _x; _cible = _x;};
				_count = _count + 1;
			};
			sleep 0.05;
		}foreach _enemys;

		if(_count == 0) then {
			if ([(position _vehicle) select 0,(position _vehicle) select 1] distance _position < 1000) then {
				_position = [wcmaptopright, wcmapbottomleft, "onsea"] call WC_fnc_createposition;
			};
			_pilot domove _position;
		} else {
			if(!isnull _gunner) then {
				_gunner reveal _cible;
				_gunner dotarget _cible;
				_gunner dofire _cible;
			};
			_pilot domove (position _cible);
		};
		sleep 60;
	};


	{
		_x setdamage 1;
	}foreach (units _group);

	_vehicle setdamage 1;