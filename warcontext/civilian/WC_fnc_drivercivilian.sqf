	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - civil drive car across the map

	if (!isServer) exitWith{};

	private [
		"_unit", 
		"_target",
		"_position",
		"_vehicle",
		"_vehicles",
		"_find",
		"_typeof"
		];

	_unit = _this select 0;

	diag_log format["WARCONTEXT: BUILD 1 DRIVER - fame: %1", wcfame];

	_target = wctownlocations call BIS_fnc_selectRandom;

	while { alive _unit } do {
		if(vehicle _unit == _unit) then {
			_find = false;
			_vehicles = nearestObjects[_unit,["LandVehicle"], 300];
			{	
				_vehicle = _x;	
				if((count (crew _vehicle) == 0) and !_find) then {
					if(getdammage _vehicle < 0.9) then {
						_find = true;
						while {(_unit distance _vehicle > 5) and (alive _unit) and (alive _vehicle) and !(locked _vehicle)} do {
							_unit domove position _vehicle;
							sleep 10;
						};
						if((count (crew _vehicle) == 0) and (alive _unit) and (alive _vehicle) and !(locked _vehicle)) then {
							_position = position _unit;
							_typeof = typeof _unit;
							_unit removeAllEventHandlers "killed";
							_unit setpos [0,0];
							_unit setdamage 1;
							deletevehicle _unit;
							_group = creategroup civilian;
							_unit = _group createUnit [_typeof, [0,0], [], 0, "FORM"];
							_vehicle setfuel 1;
							_vehicle setdamage 0;
							_unit moveindriver _vehicle;
							_unit addEventHandler ['HandleDamage', {
								if!((_this select 0) == (_this select 3)) then {
									(_this select 0) setdamage (0.5 + (random 0.5));
								};
							}];
							_unit addeventhandler ['killed', {
								_this spawn WC_fnc_garbagecollector;
								wcnumberofkilledofmissionC = wcnumberofkilledofmissionC + 1;
								wcfame = wcfame - 0.01;
							}];
						};
					};
				};
		
			}foreach _vehicles;
		};
		if(position _unit distance position _target > 150) then {
			(group _unit) setBehaviour "SAFE";
			(group _unit) setSpeedMode "FULL";
			_unit domove position _target;
			sleep 60;
		} else {
			_target = wctownlocations call BIS_fnc_selectRandom;
		};
		sleep 5;
	};