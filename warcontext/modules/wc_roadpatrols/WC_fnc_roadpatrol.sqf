	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Road patrol script

	if (!isServer) exitWith{};

	private [
		"_cible",
		"_group",
		"_lastposition",
		"_move",
		"_originalsize",
		"_originalcible",
		"_position",
		"_target",
		"_vehicle",
		"_wp",
		"_wptype"
		];


	_group = _this select 0;
	_originalsize = count (units _group);

	_vehicle = vehicle (leader _group);
	_vehicle setvariable ["cible", objnull, false];

	while { count (units _group) > 0 } do {

		if((wcalert > 50) || (count (units _group) < _originalsize)) then {
			_group setBehaviour "AWARE";
			_group setCombatMode "RED";
			_group setSpeedMode "LIMITED";
			_wptype = ["SAD"];
		} else {
			_group setBehaviour "SAFE";
			_group setCombatMode "GREEN";
			_group setSpeedMode "FULL";
			_group setFormation "COLUMN";
			_wptype = ["MOVE", "SAD", "HOLD"];
		};

		_cible = _vehicle getvariable "cible";
		_originalcible = _cible;

		if((isnull _cible) or !(alive _cible) or ((_cible distance _vehicle) > wcdistance)) then {
			_vehicle setvariable ["cible", _vehicle, false];
			_target = wctownlocations call BIS_fnc_selectRandom;
			_position = (position _target) findEmptyPosition [10, 500];
			while { count _position == 0 } do {
				_target = wctownlocations call BIS_fnc_selectRandom;
				_position = (position _target) findEmptyPosition [10, 500];
				sleep 0.1;
			};
		} else {
			if(_cible != _vehicle) then {
				_wptype = ["SAD"];
				_position = position _cible;
				_group setBehaviour "AWARE";
				_group setCombatMode "RED";
				_group setSpeedMode "LIMITED";
			};
		};

		_wp = _group addwaypoint [_position, 0];
		_wp setWaypointPosition [_position, 5];
		_wp setWaypointType (_wptype call BIS_fnc_selectRandom);
		_wp setWaypointVisible true;
		_wp setWaypointSpeed "FULL";
		_group setCurrentWaypoint _wp;

		_move = false;
		while { !(_move) } do {
			_lastposition = position (leader _group);
			sleep 10;
			if(_lastposition distance (position (leader _group)) < 5) then {
				_move = true;
			};
			_cible = _vehicle getvariable "cible";
			if(_originalcible != _cible) then {
				_move = true;
			};
		};
		deletewaypoint _wp;
		_vehicle setFuel 1;
	};