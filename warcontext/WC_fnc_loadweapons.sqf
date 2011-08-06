	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// ACE SYS WEAPONS reworks - warcontext
	// -----------------------------------------------

	private["_listofweapons", "_listofmagazines", "_weapons", "_magazines", "_pos", "_crate", "_side", "_name"];
	
	_side = _this select 0;	

	_weapons = [];
	_weaponstemp = [];
	
	switch (_side) do {
		case west : {
			_side = ["USMC", "BIS_GER", "BIS_US", "CIV"];
		};

		case east : {
			_side = ["RU"];
		};
		
		case resistance : {
			_side = ["GUE"];
		};

		case civilian : {
			_side = ["CIV"];
		};

		case "all" : {
			_side = ["USMC", "BIS_GER", "BIS_US", "RU", "GUE", "CIV"];
		};

		default {
			_side = ["USMC", "BIS_GER", "BIS_US"];
		};
	};


	{
		_listofweapons = [_x, ["RIFLE", "PISTOL", "EQUIP", "ITEM", "RUCK", "LAUNCHER", "SNIPER", "MG", "AR"]] call ace_fnc_enumWeapons;
		{ 
			{ 
				_name = format["%1", tolower(_x select 0)];
				if!(_name in _weapons) then {
					_weapons = _weapons + [_name];
				};
			} foreach _x;
		} forEach (_listofweapons select 0);
	} foreach _side;

	_weapons;