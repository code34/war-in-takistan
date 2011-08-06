	// -----------------------------------------------
	// Author:  =[A*C]= code34 nicolas_boiteux@yahoo.fr
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

	while { (alive _unit) } do {
		_formationtype = ["COLUMN", "STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"] call BIS_fnc_selectRandom;

		if((vehicle _unit) iskindof "Air") then {
			_position = [wcmaptopright, wcmapbottomleft, "onground"] call WC_fnc_createposition;
			while { _position distance getmarkerpos "respawn_west" < 2000 } do {
				_position = [wcmaptopright, wcmapbottomleft, "onground"] call WC_fnc_createposition;
			};
		};

		if((vehicle _unit) iskindof "Ship") then {
			_position = [wcmaptopright, wcmapbottomleft, "onsea"] call WC_fnc_createposition;
		};

		[group _unit, 0] setWaypointFormation _formationtype;
		[group _unit, 0] setWaypointPosition [_position, 5];
		[group _unit, 0] setWaypointType "MOVE";
		[group _unit, 0] setWaypointVisible true;
		[group _unit, 0] setWaypointSpeed "FULL";
		(group _unit) setCurrentWaypoint [group _unit, 0];

		while { (position _unit) distance _position > 1000 } do {
			if(position _unit distance getmarkerpos "respawn_west" < 2000) then {
				_unit domove _position;
				sleep 10;
			};
			sleep 5;
		};

		(vehicle _unit) setfuel 1;
		sleep 1;
	};