	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description:
	// respawn vehicle at their original position
	// Context: server side
	// Xeno respawn reworks
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_vehicle", 
		"_delay", 
		"_startpos", 
		"_startdir", 
		"_type", 
		"_disabled", 
		"_vehiclename",
		"_westside",
		"_move",
		"_name",
		"_objets_charges"
	];
	
	_vehicle = _this select 0;
	if(format["%1", _vehicle] == "any") exitWith{};
	_delay = _this select 1;

	_startpos = getposatl _vehicle;
	_startdir = getdir _vehicle;
	_type = typeof _vehicle;
	_vehiclename = vehicleVarName _vehicle;
	_move = 0;

	if(wcwithrandomfuel == 1) then {
		_vehicle setfuel random 0.5; 
		_vehicle setVehicleAmmo random 0.5;
	};

	WC_fnc_initializevehicle = {
		_vehicle = _this select 0;

	
		//if(wckindofgame == 1) then {
			_vehicle removeAllEventHandlers "HandleDamage";
			_vehicle addEventHandler ['HandleDamage', {
				if (_this select 2 > wcdammagethreshold) then {
					(_this select 0) removeAllEventHandlers "HandleDamage";
					if((_this select 2) + (getdammage (_this select 0)) > 0.9) then {
						(_this select 0) setdamage 1;
					} else {
						(_this select 0) setdamage ((getdammage(_this select 0)) + (_this select 2));
					};
				}
				//(_this select 0) setdamage ( (getdammage(_this select 0)) + ((_this select 2)/50) );
			}];
		//};

		_vehicle addEventHandler ['Fired', '
			private ["_name"];
			if!(wcdetected) then {
				if((getmarkerpos "rescue") distance (position player) < 400) then {
					wcalerttoadd = random (10);
					["wcalerttoadd", "server"] call WC_fnc_publicvariable;
				};
			};
			wcammoused = wcammoused + 1;
		'];
	};

	[_vehicle] call WC_fnc_initializevehicle;

	// if simulation vehicles not respawn
	if(wckindofgame == 2) exitwith {};

	while {true} do {
		if (count (crew _vehicle) == 0) then {
			_move = _move + 1;
			_disabled = (if (damage _vehicle > 0.9) then {true} else {false});
			if (_disabled || !(alive _vehicle) || ((_move > 1800) and (getpos _vehicle distance _startpos > 10))) then {
				sleep wctimetogarbagedeadbody;
				_vehicle setpos [0,0,0];
				_vehicle setdamage 1;
				_objets_charges = _vehicle getVariable "R3F_LOG_objets_charges";
				clearVehicleInit _vehicle;
				deletevehicle _vehicle;
				sleep 0.5;
				_vehicle = _type createvehicle _startpos;
				_vehicle setposatl _startpos;
				_vehicle setdir _startdir;
				_vehicle setvehicleinit format["this setvehiclevarname '%1';", _vehiclename];
				processinitcommands;
				_vehicle setvariable ["R3F_LOG_objets_charges", _objets_charges, true];
				_move = 0;
				_name= getText (configFile >> "CfgVehicles" >> _type >> "DisplayName");
				diag_log format["WARCONTEXT: RESPAWN VEHICLE %1", _name];
				[_vehicle] call WC_fnc_initializevehicle;
			};
		}else{
			_move = 0;
		};
		sleep 1;
	};