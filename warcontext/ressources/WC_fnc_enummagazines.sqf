	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// ACE SYS WEAPONS reworks - warcontext
	// -----------------------------------------------

	private ["_objList", "_typeList", "_count", "_weapons", "_attendant", "_weapon", "_weapondisplayname", "_config", "_magazines", "_muzzles", "_objDisplayName", "_result", "_name"];

	_objList = [];
	_typeList = [];

	_weapons = _this select 0;
	_count = (count _weapons) - 1;

	_attendant = getNumber(configFile >> "CfgVehicles" >> typeOf player >> "attendant") == 1;
	_result = []; 

	for "_i" from 0 to _count do {
		_weapon = _weapons select (_count - _i); 
		_config = (configFile >> "CfgWeapons" >> _weapon);
		//_weapondisplayname = getText (_config >> "DisplayName");

		if (isArray(_config >> "muzzles")) then {
			_muzzles = getArray(_config >> "muzzles");
			if (count _muzzles > 0) then {
				_magazines = []; 
				{
					if (_x == "this") then {
						_magazines = getArray (_config >> "magazines");
					} else {
						_magazines = _magazines + (getArray (_config >> _x >> "magazines"));
					};
				} forEach _muzzles;
			} else {
				_magazines = getArray (_config >> "magazines");
			};
		} else {
			_magazines = getArray (_config >> "magazines");
		};

		{
			_config = (configFile >> "CfgMagazines" >> _x);
			if (true) then {
				if ((getNumber(_config >> "scope")) == 2) then {
					_name = format["%1", tolower(_x)];
					if !(_name in _result) then {
					 	if (getNumber(_config >> "Armory" >> "disabled") == 1) exitWith {};
						if (getNumber(_config >> "ace_hide") == 1) exitWith {}; 
						_objDisplayName = getText (_config >> "DisplayName");
						if (_objDisplayName != "") then {
							_result = _result + [_name];
						};
					};
				};
			};
		} forEach _magazines;
	};
	
	// Return magazines
	_result;