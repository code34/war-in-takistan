	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Compute groups/vehicles in the locations
	// around the mission

	if (!isServer) exitWith{};

	private [
		"_count",
		"_location", 
		"_locations",
		"_marker", 
		"_position",
		"_position2",
		"_radio"
	];

	_location = _this select 0;
	_position = [((position _location) select 0),((position _location) select 1)];
	_count = 0;

	if(wckindofserver == 3) then {
		wcambiantdistance = 2500;
	};

	// CREATE ENMIES AROUND TARGET
	_locations = nearestLocations [_position, ["NameCityCapital", "NameCity","NameVillage", "Name", "Hill", "Mount"], wcambiantdistance];
	_locations = _locations - [_location];

	{
		_position2 = [((position _x) select 0),((position _x) select 1)];
		if(_position distance _position2 < 500) then {
			_locations = _locations - [_x];
		};
	}foreach _locations;

	wcambiantdistance = wcambiantdistance + 200;

	sleep 2;

	while { (count _locations)  > (wclevelmaxoutofcity) } do {
		_temp = _locations call BIS_fnc_selectRandom;
		_locations  = _locations  - [_temp];
	};

	{
		if(wcwithcomposition == 1) then {
			wcgarbage = [_x] spawn WC_fnc_createcomposition;
		};
		wcambiantindex = wcambiantindex + 1;
		_count = _count + 1;
		_marker = [format["ambiant%1", wcambiantindex], (wcdistance * 2), position _x, 'ColorRED', 'ELLIPSE', 'FDIAGONAL', 'EMPTY', 0, '', false] call WC_fnc_createmarkerlocal;
		wcambiantmarker = wcambiantmarker + [_marker];
		if(random 1 > 0.7) then {
			wcgarbage = [_marker, (wcvehicleslistE call BIS_fnc_selectRandom), true] spawn WC_fnc_creategroup;
		} else {
			wcgarbage = [_marker, wcfactions call BIS_fnc_selectRandom, false] spawn WC_fnc_creategroup;
		};
		sleep 2;
	}foreach _locations;

	diag_log format["WARCONTEXT: COMPUTE %1 AMBIANT GROUPS", _count];