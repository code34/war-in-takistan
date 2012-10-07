	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create mortar bombing

	private [
		"_arrayofvehicle",
		"_cible",
		"_knowsabout",
		"_cooldown",
		"_cooldownmax",
		"_dofire",
		"_check",
		"_enemy", 
		"_enemys", 
		"_friendlyunits", 
		"_group",
		"_hour",
		"_marker",
		"_mortarposition",
		"_impactposition",
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
	_cooldownmax = round (random 6);

	while {_check} do {
		if(!(alive _vehicle) or (damage _vehicle > 0.9))then {
			_check = false;
		};

		if(count(crew _vehicle) == 0) then {
			_check = false;
			_vehicle setdamage 1;
		};

		if(_cooldown > _cooldownmax) then {
			if(count wcmortarposition > 0) then {
				_position = wcmortarposition select 0;
				wcmortarposition set [0,-1]; 
				wcmortarposition = wcmortarposition - [-1];
				_unit dowatch _position;
				_position = [_position, 0, 55] call WC_fnc_createpositionaround;
				_units = nearestObjects [_position, ["Man"], 60];			
				_dofire = true;
				{
					if!(isplayer _x) then {
						_dofire = false;
					};
				}foreach _units;

				if(_dofire) then {				
					if(_position distance _unit < 800) then {
						if(random 1 > 0.3) then {
							if(wcwithACE == 1) then {
								"ACE_ARTY_Sh_82_HE" createVehicle _position;
							} else {
								"ARTY_Sh_82_HE" createVehicle _position;
							};
						} else {
							if(wcwithACE == 1) then {
								"ACE_ARTY_SmokeShellWhite" createVehicle _position;
							} else {
								"ARTY_SmokeShellWhite" createVehicle _position;
							};					
						};
					};
				};
			};
			_cooldown = 0;
			_cooldownmax = round (random 3);
		} else {
			if(_knowsabout > 0) then {
				_unit dowatch _enemy;
			};
		};
		sleep 5;
		_cooldown = _cooldown + 1;
	};

	if(alive _unit) then {
		wcgarbage = [_group, (position(leader _group)), wcdistance] spawn WC_fnc_patrol;
	};