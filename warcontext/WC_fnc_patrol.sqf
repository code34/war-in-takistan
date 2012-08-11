	// -----------------------------------------------
	// Author:   code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Nasty seek & destroy patrol script from scratch

	private [
		"_unit", 
		"_group", 
		"_cible", 
		"_position", 
		"_lastposition",
		"_cibles", 
		"_min", 
		"_count", 
		"_count2", 
		"_count3",
		"_list",
		"_distance",
		"_move",
		"_formationtype",
		"_marker"
	];

	_unit = _this select 0;
	_group = group _unit;

	if(_group in wcpatrolgroups) exitwith {};
	wcpatrolgroups = wcpatrolgroups + [_group];

	_lastposition = position _unit;

	_count = 0;
	_count2 = 0;
	_count3 = 0;
	_move = true;

	_marker = [format['patrolzone%1', wcpatrolindex], 300, (position _unit), 'ColorGREEN', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;
	wcpatrolindex = wcpatrolindex + 1;
	_position = [_marker, "onground"] call WC_fnc_createpositioninmarker;
	_wp = _group addWaypoint [_position, 0];
	_wp setWaypointType "Sentry"; 
	[_group, 1] setWaypointPosition [_position, 5];


	while { (count (units _group) > 0) } do {
		_unit = leader _group;

		if(wcalert > 50) then {
			_group setBehaviour "AWARE";
			_cibles = [];
			_list = (position _unit) nearEntities [["Man"], 300];
			{
				if(side _x == west) then {
					if( _cible distance (_unit getHideFrom _cible) < 100) then {
						_cibles = _cibles + [_x];
					};
				} else {
					_list = _list - [_x];
				};
			}foreach _list;
	
			if((count _cibles == 0) or _move) then {
				if(_count < 0.1) then {
					_cible = ([_unit, _list] call EXT_fnc_SortByDistance) select 0;
					if!(isnull _cible) then {
						_unit dotarget _cible;
						_position = ([position _cible, 3, 360, getdir _cible, 5] call WC_fnc_createcircleposition) call BIS_fnc_selectRandom;
						_unit domove _position;
					};
					_count = 2;
					if(_count3 > 0) then {
						_move = false;
						_count3 = 0;
					};
					if(_move) then {
						_count3 = _count3 + 1;
					};
				};
				_count = _count - 0.1;
			} else {
				dostop _unit;
				_min = 200;
				{					
					if( _unit distance (_x getHideFrom _unit) < _min) then {
						_min =  _unit distance (_x getHideFrom _unit);
						_cible = _x;
					};
				}foreach _cibles;
				_unit dofire _cible;
				if(format["%1", _lastposition] == format["%1", position _unit]) then {
					_count2 = _count2 + 0.1;
				};
				if(_count2 > ceil(random 8)) then {
					_move = true;
					_count = 0;
					_count2 = 0;
				};
				_lastposition = position _unit;
			};
		} else {
			_group setBehaviour "SAFE";
			_formationtype = ["COLUMN", "STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"] call BIS_fnc_selectRandom;
			_position = [_marker, "onground"] call WC_fnc_createpositioninmarker;
	
			_move = false;
			[group _unit, 0] setWaypointFormation _formationtype;
			[group _unit, 0] setWaypointPosition [_position, 5];
			[group _unit, 0] setWaypointType "MOVE";
			[group _unit, 0] setWaypointVisible true;
			[group _unit, 0] setWaypointSpeed "LIMITED";
			(group _unit) setCurrentWaypoint [group _unit, 0];
			while { (([(position _unit) select 0, (position _unit) select 1] distance [_position select 0, _position select 1] > 20) and (wcalert < 50) and !(_move)) } do {
				_lastposition = position _unit;
				sleep 2;
				if(format["%1", _lastposition] == format["%1", position _unit]) then {
					_move = _true;
				};
			};
		};
		sleep 0.1;
	};

	deletemarkerlocal _marker;
	wcpatrolgroups = wcpatrolgroups - [_group];