	// -----------------------------------------------
	// Author:   code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create an antiair site at random position on map

	private [
		"_check",
		"_count",
		"_recheck",
		"_exit",
		"_cible",
		"_position", 
		"_marker", 
		"_vehicle", 
		"_arrayofpilot", 
		"_group", 
		"_gunner", 
		"_type"
	];

	_hill = nearestLocations [wcmapcenter, ["hill"], 20000];

	if(count _hill < (wcaalevel + 1)) exitwith {
		diag_log "WARCONTEXT: Not enough hill on this map to build AA SITE";
	};

	sleep 1;
	
	_check = false;
	_count = 0;
	_exit = false;

	while { !_check } do {
		_check = true;
		_position = (position (_hill call BIS_fnc_selectRandom)) findEmptyPosition [2, 20];

		{
			if(_position distance _x < 100) then {
				_check = false;
			};
		}foreach wcallaaposition;
		_count = _count + 1;
		if(_count > 10) then {_exit = true; _check = true;}; 
		sleep 0.1;
	};

	if(_exit) exitwith { 
		diag_log "WARCONTEXT: hill are too near on this map to build AA SITE";
	};

	wcallaaposition = wcallposition + [_position];

	if(count _position == 0) exitwith {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR AA SITE";
	};

	_type = wcaavehicles call BIS_fnc_selectRandom;
	_arrayofvehicle = [_position, 0, _type, east] call BIS_fnc_spawnVehicle;

	_vehicle 	= _arrayofvehicle select 0;
	_arrayofpilot 	= _arrayofvehicle select 1;
	_group 		= _arrayofvehicle select 2;	

	wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
	wcgarbage = [_group] spawn WC_fnc_grouphandler;

	_gunner = gunner _vehicle;
	_gunner disableai "AUTOTARGET";

	if(wcwithaamarkers == 1) then {
		_marker = [format['antiair%1', wcaaindex], 0.5, position _gunner, 'ColorRED', 'ICON', 'FDIAGONAL', 'mil_triangle', 0, 'AA site', false] call WC_fnc_createmarker;
		wcaaindex = wcaaindex + 1;
	};

	WC_fnc_defineaacible = {
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

	_cible = objnull;
	_recheck = 0;

	// vehicle can be not alive and damage can be at 0
	while { ((damage _vehicle < 0.9) and (alive _vehicle) and (alive _gunner)) } do {
		if(isnull _cible or !alive _cible) then {
			_cible = [_gunner] call WC_fnc_defineaacible;
		} else {
			_gunner dotarget _cible;
			_gunner dofire _cible;
			_gunner reveal _cible;
			_recheck = _recheck + 1;
			// after 3 loop we recheck that cible is the nearest
			if(_recheck > 3) then {
				_cible = [_gunner] call WC_fnc_defineaacible;
				_recheck = 0;
			};
		};
		sleep 10;
	};

	deletemarker _marker;