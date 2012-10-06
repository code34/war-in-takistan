	// -----------------------------------------------
	// Author: Xeno rework by  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Repair vehicle
	// -----------------------------------------------
	if!(isserver) exitwith {};

	private [
		"_config", 
		"_config2", 
		"_count",
		"_countother", 
		"_i",
		"_magazines",
		"_vehicle",
		"_type", 
		"_removed",
		"_text"
		];

	_vehicle = vehicle player;

	if(_vehicle == player) exitwith {
		wcgarbage = [localize "STR_WC_MENUREPAIRVEHICLE", localize "STR_WC_MESSAGETRYTOMOVEIN", localize "STR_WC_MESSAGENOVEHICLENEARYOU", 10] spawn WC_fnc_playerhint;
	};

	if(isnull _vehicle) exitwith {};
	if(!alive _vehicle) exitWith {};

	_type = typeof _vehicle;
	_vehicle setVehicleInit "this setfuel 0;this vehicleChat ""Servicing... Please stand by..."";";
	processInitCommands;
	sleep ceil(random(5));

	_type = typeOf _vehicle;
	_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");

	if (!alive _vehicle) exitWith {};
	_vehicle setVehicleInit "this vehicleChat ""Reloading weapons ..."";";
	processInitCommands;
	sleep ceil(random(5));

	if (count _magazines > 0) then {
		_text = "";
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_text = _text + format["this removeMagazines '%1';", _x];
				_removed = _removed + [_x];
			};
		} forEach _magazines;
		{
			_text = _text + format["this addMagazine '%1';", _x];
		} forEach _magazines;
		_text = _text + "this setVehicleAmmo 1;";
		copytoclipboard _text;
		_vehicle setVehicleInit _text;
		processInitCommands;
	};

	_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");
	if (_count > 0) then {
		_text = "";
		for "_i" from 0 to (_count - 1) do {
			_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
			_magazines = getArray(_config >> "magazines");
			_removed = [];
			{
				if (!(_x in _removed)) then {
					_text = _text + (format["this removeMagazinesTurret ['%1',[%2]];", _x, _i]);
					_removed = _removed + [_x];
				};
			} forEach _magazines;
			{
				_text = _text + (format["this addMagazineTurret ['%1',[%2]];", _x, _i]);
			} forEach _magazines;

		};
		_vehicle setVehicleInit _text;
		processInitCommands;
	};


	if (!alive _vehicle) exitWith {};
	sleep ceil(random(5));
	if (!alive _vehicle) exitWith {};
	_vehicle setVehicleInit "this vehicleChat ""Repairing...""; this setDamage 0;";
	processInitCommands;
	sleep ceil(random(5));
	_vehicle setVehicleInit "this vehicleChat ""Refueling..."";";
	processInitCommands;
	sleep ceil(random(5));
	_vehicle setVehicleInit "this vehicleChat ""Vehicle is ready"";this setfuel 1;";
	processInitCommands;
	