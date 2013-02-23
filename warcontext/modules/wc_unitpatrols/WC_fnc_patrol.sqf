	// -----------------------------------------------
	// Author:   code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Nasty seek & destroy patrol script from scratch

	private [
		"_areasize",
		"_alert",
		"_cible", 
		"_cibles", 
		"_deadcounter",
		"_formationtype",
		"_group", 
		"_leader", 
		"_lastposition",
		"_list",
		"_marker",
		"_move",
		"_position",
		"_originalsize",
		"_enemyside",
		"_wp",
		"_wptype"
	];

	_group = _this select 0;
	_position = _this select 1;
	_areasize = _this select 2;

	if(isnil "_areasize") exitwith {
		hintc "WARCONTEXT: patrolscript: areasize parameter is not set";
	};

	_leader = leader _group;
	if((side _leader) in wcside) then {
		_enemyside = wcenemyside;
	} else {
		_enemyside = wcside;
	};

	if(_group in wcpatrolgroups) exitwith {};

	_marker = [format['patrolzone%1', wcpatrolindex], _areasize, _position, 'ColorGREEN', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;
	wcpatrolindex = wcpatrolindex + 1;

	wcpatrolgroups = wcpatrolgroups + [_group];

	_originalsize = count (units _group);
	_lastposition = position (leader _group);

	_move = true;
	_deadcounter = 0;
	_alert = false;

	{			
		_x setvariable ["destination", [0,0,0], false];
	}foreach (units _group);

	while { (count (units _group) > 0) } do {
		_leader = leader _group;

		// Check if someone has been kill recently in the group
		if(_originalsize < count (units _group)) then {
			_alert = true;
			_deadcounter = _deadcounter + 1;
			if(_deadcounter > 20) then {
				_originalsize = count (units _group);
				_deadcounter = 0;
				_alert = false;
			};
		};

		if((wcalert > 50) or _alert) then {
			_group setBehaviour "AWARE";
			_group setCombatMode "RED";

			_cibles = [];

			_list = (getmarkerpos _marker) nearEntities [["Man"], _areasize];
			if(count _list > 0) then {
				{
					if(side _x in _enemyside) then {
						if( _x distance (_leader getHideFrom _x) < 100) then {
							_cibles = _cibles + [_x];
						};
					} else {
						_list = _list - [_x];
					};
					sleep 0.1;
				}foreach _list;
		
				if(count _cibles == 0) then {
					_group setbehaviour "SAFE";
				} else {
					{			
						_cible = (([_x, _cibles] call EXT_fnc_SortByDistance) select 0);
						_x setvariable ["cible", _cible, false];
						_x dotarget _cible;
						if((_x getvariable "destination") distance (position _cible) > 10) then {
							_position = ([position _cible, 3, 360, getdir _cible, 10] call WC_fnc_createcircleposition) call BIS_fnc_selectRandom;
							_x setvariable ["destination", _position, false];
							_x domove _position;
						};
						_x dofire _cible;
						sleep 0.1;
					}foreach (units _group);
				};
			};
			sleep 30;
		} else {
			if(count (units _group) > 2) then {
				_wptype = ["MOVE", "SAD"];
			} else {
				_wptype = ["MOVE", "SAD", "HOLD", "SENTRY"];
			};

			_group setBehaviour "SAFE";
			_group setCombatMode "GREEN";

			_formationtype = ["COLUMN", "STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"] call BIS_fnc_selectRandom;
			_group setFormation _formationtype;

			_position = [_marker, "onground"] call WC_fnc_createpositioninmarker;

			_wp = _group addWaypoint [_position, 0];
			_wp setWaypointPosition [_position, 5];
			_wp setWaypointType (_wptype call BIS_fnc_selectRandom);
			_wp setWaypointVisible true;
			_wp setWaypointSpeed "LIMITED";
			_group setCurrentWaypoint _wp;

			_move = false;
			while { ((wcalert < 50) and !(_move) and (count (units _group) == _originalsize)) } do {
				_lastposition = position (leader _group);
				sleep 10;
				if(_lastposition distance (position (leader _group)) < 5) then {
					_move = true;
				};
			};
			deletewaypoint _wp;
		};
		sleep 0.1;
	};

	deletemarkerlocal _marker;
	wcpatrolgroups = wcpatrolgroups - [_group];