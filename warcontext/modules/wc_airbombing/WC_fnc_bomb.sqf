	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  Bombing the mission zone with the C130

	private [
		"_dir",
		"_unit", 
		"_position", 
		"_position2", 
		"_arrayofvehicle", 
		"_vehicle", 
		"_bombs", 
		"_missioncomplete",
		"_bomb",
		"_active",
		"_bombed",
		"_enemys",
		"_startingposition",
		"_returnbase"
		];

	_arrayofvehicle =[[12000, 12000,800], 0, "C130J_US_EP1", west] call BIS_fnc_spawnVehicle;

	_vehicle = _arrayofvehicle select 0;
	_arrayofpilot = _arrayofvehicle select 1;
	_bombs = 70;
	_missioncomplete = false;
	_vehicle setcaptive true;
	_vehicle setdir 0;
	_returnbase = false;

	wcmessageW = ["Bombing begins", "Take cover!"]; 
	["wcmessageW", "client"] call WC_fnc_publicvariable;

	wcbomb = true;
	["wcbomb", "client"] call WC_fnc_publicvariable;
	playsound "bomb";

	_startingposition = getmarkerpos "sidezone";

	while { ((alive _vehicle) and (getdammage _vehicle < 0.6) and !(_returnbase) and (_bombs >1)) } do {
		_vehicle flyInHeight 200;
		_position = getmarkerpos "bombzone";
		if(_startingposition distance _position > 1500) then {
			_returnbase = true;
		} else {
			_enemys = nearestObjects [_position, ["Man", "LandVehicle"], 300];
	
			{
				if((side (driver _x)) in wcenemyside) then {
					_position = position _x;
				};
			}foreach _enemys;
	
			if(format["%1", _position] == "[0,0,0]") then { _position = [10000, 10000]; };
			_position = [_position select 0, _position select 1];
			_position2 = [(getpos _vehicle) select 0, (getpos _vehicle) select 1];
	
			if( _position2 distance _position > 1500) then {
				{
					_x domove _position;
					(group _x) setSpeedMode "FULL";
				}foreach _arrayofpilot;
				sleep 30;
			};
	
			if(_bombs > 0) then {
				_bombed = 0;
				while {(( _position2 distance _position < 300) and (_bombed < 30))} do {
					(group (driver _vehicle)) setSpeedMode "LIMITED";
					_dir = getdir _vehicle;
					_bomb = "Bo_Mk82" createvehicle [getposatl _vehicle select 0, getposatl _vehicle select 1, (getposatl _vehicle select 2) - 10];
					_bomb setdir _dir;
					_bomb setvelocity [0,0,-150];
					sleep random (0.1);
					_bomb = "Bo_FAB_250" createvehicle [getposatl _vehicle select 0, getposatl _vehicle select 1, (getposatl _vehicle select 2) - 10];
					_bomb setdir _dir;
					_bomb setvelocity [0,0,-150];
					sleep random (0.1);
					_bombs = _bombs - 2;
					_bombed = _bombed + 2;
				};
				sleep 5;
			} else {
				_position = [0, 0];
				{
					_x domove _position;
				}foreach _arrayofpilot;
				if( _position2 distance _position < 300) then {
					_vehicle setdamage 1;
					deletevehicle _vehicle;
					{
						_x setdamage 1;
						deletevehicle _x;
					}foreach _arrayofpilot;
					_missioncomplete = true;
				};
				sleep 30;
			};
		};
	};

	wcmessageW = ["Bombing finished", "Go to Battle!"]; 
	["wcmessageW", "client"] call WC_fnc_publicvariable;
	diag_log "WARCONTEXT: BOMBING SUPPORT IS FINISHED";

	wcbomb = true;
	["wcbomb", "client"] call WC_fnc_publicvariable;
	playsound "bomb";

	_vehicle domove [0,0,0];
	sleep 180;
	_vehicle setdamage 1; 
	deletevehicle _vehicle;