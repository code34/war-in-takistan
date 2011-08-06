	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_typeof",
		"_position",
		"_position2",
		"_arrayvehicle",
		"_pilot",
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
	_group = group _pilot;

	_combatmode = "RED";
	_behaviour = "COMBAT";

	while {getdammage _vehicle < 0.6} do {
		_group setCombatMode _combatmode;
		_group setBehaviour _behaviour;
		_vehicle flyInHeight 200;
		_count = 0;
		_enemys = nearestObjects [_vehicle, ["Man"], 400];
		_distancemax = 400;
		{
			if (side _x in wcside) then {
				_pilot reveal _x;
				if( _vehicle distance _x < _distancemax) then { _distancemax = _vehicle distance _x; _cible = _x;};
				_count = _count + 1;
			};
			sleep 0.05;
		}foreach _enemys;
		if(_count == 0) then {
			if ([(position _vehicle) select 0,(position _vehicle) select 1] distance _position < 1000) then {
				_position2 = [wcmaptopright, wcmapbottomleft] call WC_fnc_createposition;
				_pilot domove _position2;
			}else{
				_pilot domove _position;
			};
		} else {
			_pilot reveal _cible;
			_pilot dotarget _cible;
			_pilot dofire _cible;
			_pilot domove (position _cible);
		};
		sleep 60;
	};

	_pilot setdamage 1;
	_vehicle setdamage 1;

	true;