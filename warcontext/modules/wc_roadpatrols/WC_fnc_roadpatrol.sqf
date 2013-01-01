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

	WC_fnc_defineaircible = {
		private ["_gunner", "_cible", "_enemys", "_exit", "_ghost", "_group"];
		_gunner = _this select 0;
		_ghost = false;
		_cible = objnull;

		_enemys = nearestObjects[_gunner, ["Air"], 3000];
		if (count _enemys > 0) then {
			_exit = false;
			while {(!_exit and (count _enemys) > 0)} do {
				_cible = (([_gunner, _enemys] call EXT_fnc_SortByDistance) select 0);
				if((getposatl _cible) select 2 > 20) then {
					{
						if((side _x == west) or (isplayer _x)) then {
							if(side _x != west) then {
								_ghost = true;
							};
							_exit = true;
						};
					}foreach (crew _cible);
				};
				if(!_exit) then {
					_enemys = _enemys - [_cible];
				};
				sleep 0.5;
			};
			if(!_exit) then {
				_cible = objnull;
			};
			if(_ghost) then {
				// unauthorized civil fly
				_group = creategroup west;
				(crew _cible) joinsilent _group;
			};
		} else {
			_cible = objnull;
		};
		_cible;
	};

	[_vehicle] spawn {
		private ["_vehicle"];
		_vehicle = _this select 0;

		while { (alive _vehicle and alive (driver _vehicle)) } do {
			_cible = [(driver _vehicle)] call WC_fnc_defineaircible;
			if(!isnull _cible) then {
				_vehicle setvariable ["cible", _cible, false];
			};
			sleep 3;
		};
	};


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