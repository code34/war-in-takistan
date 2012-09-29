	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create mortar bombing

	private [
		"_arrayofvehicle",
		"_cible",
		"_knowsabout",
		"_cooldown",
		"_check",
		"_enemy", 
		"_enemys", 
		"_friendlyunits", 
		"_group",
		"_hour",
		"_marker",
		"_mortarposition",
		"_position", 
		"_unit", 
		"_vehicle", 
		"_wallposition",
		"_wall"
	];

	_marker = _this select 0;


	_mortarposition = [_marker, "onground", "onflat"] call WC_fnc_createpositioninmarker;
	_wallposition = [((_mortarposition) select 0),((_mortarposition) select 1) + 1.5];
	_wall = "Land_fort_bagfence_round" createVehicle _wallposition;

	diag_log "WARCONTEXT: COMPUTING A MORTAR";

	_arrayofvehicle = [_mortarposition, 0, "2b14_82mm_TK_EP1", east] call BIS_fnc_spawnVehicle;
	_vehicle = _arrayofvehicle select 0;
	_unit = (_arrayofvehicle select 1) select 0;
	_group = _arrayofvehicle select 2;

	wcgarbage = [_group] spawn WC_fnc_grouphandler;

	_dir = getdir _vehicle;
	_wall setdir _dir;	
	_enemys = [];

	_check = true;
	_cooldown = 0;

	while {_check} do {
		if(!(alive _vehicle) or (damage _vehicle > 0.9))then {
			_check = false;
		};

		if(count(crew _vehicle) == 0) then {
			_check = false;
			_vehicle setdamage 1;
		};

		_knowsabout = 0;
		_enemys = nearestObjects [position _unit, ["Man"], 800];
		{
			if !(isplayer _x) then {
				_enemys = _enemys - [_x];
			} else {
				if(_x distance _unit < 50) then {
					_unit action ["eject", _vehicle];
					unassignvehicle _unit;
				};
				if(_unit knowsabout _x > _knowsabout)  then {
					_knowsabout = _unit knowsabout _x;
					_enemy = _x;
				};
			};
		}foreach _enemys;

		if(_cooldown > 6) then {
			if(_knowsabout > 0.1) then {
				_unit dowatch _enemy;
				_position = [0,0,0];
				if(_enemy distance _unit < 800) then {
					while { [_position select 0, _position select 1] distance [(position _enemy select 0), (position _enemy select 1)] > 100 } do {
						_position = [(position _enemy), 30, 80] call WC_fnc_createpositionaround;
						_friendlyunits = nearestObjects [_position, ["Man", "LandVehicle"], 50];
						{
							if((side _x) in wcenemyside) then {
								_position = [0,0,0];
							};
						}foreach _friendlyunits;
						sleep 0.5;
					};
					if(random 1 > 0.3) then {
						if(wcwithACE == 1) then {
							"ACE_ARTY_Sh_82_HE" createVehicle _position;
						} else {
							"ARTY_Sh_82_HE" createVehicle _position;
						};
					} else {
						if(wcwithACE == 1) then {
							"ACE_ARTY_SmokeShellWhite" createVehicle position _enemy;
						} else {
							"ARTY_SmokeShellWhite" createVehicle position _enemy;
						};					
					};
				};
			};
			_cooldown = 0;
		} else {
			if(_knowsabout > 0) then {
				_unit dowatch _enemy;
			};
		};
		sleep 5;
		_cooldown = _cooldown + 1;
	};

	if(alive _unit) then {
		wcgarbage = [group _unit, wcdistance] spawn WC_fnc_patrol;
	};