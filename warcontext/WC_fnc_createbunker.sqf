	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext  - create bunker near roads
	// -----------------------------------------------

	private [
		"_buildings", 
		"_static", 
		"_vehicle", 
		"_arrayofpos", 
		"_pos", 
		"_position", 
		"_compositions", 
		"_dir", 
		"_object", 
		"_position", 
		"_count", 
		"_location", 
		"_compositionsobject", 
		"_computeagroup",
		"_city"
	];

	_location = _this select 0;
	_position = position _location;
	_compositionsobject = [];

	if(_location in wctownwithbunker) exitwith {};
	wctownwithbunker= wctownwithbunker + [_location];

	WC_fnc_PDB2 = {
		_pos = _this select 0;
		_bearing = _this select 1;
		_distance = _this select 2;
		[ (_pos select 0) + (_distance*(sin _bearing)) ,(_pos select 1)+(_distance*(cos _bearing))];
	};

	_roads = _position nearRoads 400;
	{
		if!((count (roadsConnectedTo _x) > 1) and (count (nearestObjects [_x,["house"], 30]) == 0))then{
			_roads = _roads - [_x];
		};
	}forEach _roads;

	_compositions = wccompositions;

	_count = 0;
	{
		if(random 1 > 0.99) then {
			_object = _x;
			_computeagroup = false;
			_pos = [getpos _object, (getdir _object) + 90, 20] call WC_fnc_PDB2;
			_dir = getdir _object;
			_count = _count + 1;
		
			_composition = _compositions call BIS_fnc_selectRandom;
			_compositions = _compositions - [_composition];

			_compositionsobject = ([_pos, (_dir + 180), _composition] call (compile (preprocessFileLineNumbers "ca\modules\dyno\data\scripts\objectMapper.sqf")));
			wcobjecttodelete  = wcobjecttodelete + _compositionsobject;

			{
				if(_x isKindOf "LandVehicle") then {
					_x setdamage 1;
					deletevehicle _x;
				};
			}foreach _compositionsobject;

			if(random 1 > 0.9) then {
				_markername = format["wccompositionups%1", wccompositionindex];
				_markersize = 20;
				_marker = [_markername, _markersize, _pos, 'ColorBLUE', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;
				_handle = [_marker, wcfactions call BIS_fnc_selectRandom, false] spawn WC_fnc_creategroup;
				wccompositionindex = wccompositionindex + 1;
			};
			
			_buildings = nearestObjects [_pos, ["House"], 20];
			_arrayofpos = [];
			{
				if!(_x iskindof "House") then {
					if(getdammage _x < 0.4) then {
						_index = 0;
						while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
							_position = _x buildingPos _index;
							_arrayofpos = _arrayofpos + [_position];
							_index = _index + 1;
						};
					};
				};
			}foreach _buildings;
		
		
			_staticclass = ["KORD_high", "DSHKM_TK_GUE_EP1"];
			{
				if(random 1 > 0.9) then {
					_static = _staticclass call BIS_fnc_selectRandom;
					_vehicle = _static createVehicle _x;
					_vehicle setposatl _x;
				};
			}foreach _arrayofpos;
		};
	}foreach _roads;

	_city = nearestLocation [position _location, "NameCity"];
	diag_log format["WARCONTEXT: GENERATE %1 BUNKERS NEAR %2", _count, text _city];