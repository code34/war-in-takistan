	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description:
	// Restore building / compositions that have been backup
	// Position is the center of composition
	// Remix of BIS Composition script
	// -----------------------------------------------

	private [
		"_position",
		"_pos",
		"_dir",
		"_typeof",
		"_arrayof",
		"_x",
		"_i",
		"_xpos",
		"_ypos",
		"_zpos",
		"_absx",
		"_absy",
		"_building",
		"_fuel",
		"_damage",
		"_group",
		"_soldier",
		"_leader",
		"_light"
		];

	_position = _this select 0;
	_arrayof  = _this select 1;
	_withmen  = _this select 2;

	_group = createGroup east;
	{
		_pos = _x select 0;
		_xpos = (_pos select 0) + (_position select 0);
		_ypos = (_pos select 1) + (_position select 1);
		_zpos = _pos select 2;
		_pos = [_xpos, _ypos, _zpos];
		_dir = _x select 1;
		_typeof = _x select 2;
		_building = _typeof createVehicle _pos;
		_building setposATL _pos;
		_building setdir _dir;
		_building setVectorUp [0,0,1];

		if(_typeof == "TK_WarfareBHeavyFactory_Base_EP1") then {
			wcheavyfactory = _building;
		};

		if(_typeof == "Land_Barrack2_EP1") then {
			wcbarrack = _building;
		};

		if(_typeof == "Land_Ind_IlluminantTower") then {
			wclight = _building; 
			["wclight", "client"] call WC_fnc_publicvariable;
		};

		if (_withmen) then {
			if (_building emptyPositions "driver" > 0) then {
				_soldier = _group createUnit [(wccrewforces call BIS_fnc_selectRandom), [100,100,0], [], 0, "NONE"];
				_soldier assignAsDriver _building;
				_soldier moveindriver _building;
				[_soldier, wcside] spawn WC_fnc_sentinelle;
				wcgarbage = [_soldier, wcskill] spawn WC_fnc_setskill;
				_soldier addeventhandler ['killed', {
					_this spawn WC_fnc_garbagecollector;
					 wcenemykilled =  wcenemykilled + 1;
					["wcenemykilled", "client"] call WC_fnc_publicvariable;
				}];
				_soldier addEventHandler ['Hit', '
					(_this select 0) doTarget (_this select 1);
					(_this select 0) doFire (_this select 1);
				'];
				wcunits = wcunits + [_soldier];
				wcblinde = wcblinde + [_soldier];
			};
			if (_building emptyPositions "gunner" > 0) then {
				_soldier = _group createUnit [(wccrewforces call BIS_fnc_selectRandom), [100,100,0], [], 0, "NONE"];
				_soldier assignAsgunner _building;
				_soldier moveingunner _building;
				[_soldier, wcside] spawn WC_fnc_sentinelle;
				wcgarbage = [_soldier, wcskill] spawn WC_fnc_setskill;
				_soldier addeventhandler ['killed', {
					_this spawn WC_fnc_garbagecollector;
					 wcenemykilled =  wcenemykilled + 1;
					["wcenemykilled", "client"] call WC_fnc_publicvariable;
				}];
				_soldier addEventHandler ['HandleDamage', {
					(_this select 0) doTarget (_this select 3);
					(_this select 0) doFire (_this select 3);
					(_this select 0) reveal (_this select 3);
					(_this select 0) setdamage (0.5 + (random 0.5));
				}];
				wcunits = wcunits + [_soldier];
				wcblinde = wcblinde + [_soldier];
			};
			if (_building emptyPositions "commander" > 0) then {
				_soldier = _group createUnit [(wccrewforces call BIS_fnc_selectRandom), [100,100,0], [], 0, "NONE"];
				_soldier assignAscommander _building;
				_soldier moveincommander _building;
				[_soldier, wcside] spawn WC_fnc_sentinelle;
				wcgarbage = [_soldier, wcskill] spawn WC_fnc_setskill;
				_soldier addeventhandler ['killed', {
					_this spawn WC_fnc_garbagecollector;
					 wcenemykilled =  wcenemykilled + 1;
					["wcenemykilled", "client"] call WC_fnc_publicvariable;
				}];
				_soldier addEventHandler ['Hit', '
					(_this select 0) doTarget (_this select 1);
					(_this select 0) doFire (_this select 1);
				'];
				wcunits = wcunits + [_soldier];
				wcblinde = wcblinde + [_soldier];
			};
		};
		_building addeventhandler ['killed', {_this spawn WC_fnc_garbagecollector}];
		sleep 0.1;
		wcobjecttodelete = wcobjecttodelete + [_building];
	}foreach _arrayof;

	//if (count (units _group) > 0) then {
	// initialisation script for units
	//	_markername = format["wccomposition%1", wccomposition];
	//	_markersize = 50;
	//	_marker = [_markername, _markersize, _position, 'ColorBLUE', 'ICON', 'FDIAGONAL', 'EMPTY'] call WC_fnc_createmarker;
	//	_scriptinit = format["wcgarbage = [this, '%1', 'noslow'] execVM 'extern\ups.sqf';", _marker];
	//	_leader = leader _group;
	//	_leader setVehicleInit _scriptinit;
	//	wccomposition = wccomposition + 1;
	//};
	//_group;