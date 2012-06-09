	// by Bon_Inf*
	
	if!(local player) exitWith{};
	
	_unit 		= _this select 0;
	_preset 	= _this select 1;
	_loadoutclass 	= _preset select 1;
	_primaryweapon 	= _preset select 2;
	_secondaryweapon = _preset select 3;
	_items_sidearm 	= _preset select 4;
	_magazines 	= _preset select 5;
	_ruckmags 	= _preset select 6;
		
	closeDialog 0;
	_process = "";
	
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeBackpack _unit;
	{
		_currentmag = _x;
		for "_i" from 1 to (_currentmag select 1) do {_unit addMagazine (_currentmag select 0)};
	} foreach _magazines;
	
	{
		if(_x != "") then {
			if(not isText (configFile >> "CfgWeapons" >> _x >> "displayName")) then { // is rucksack
				_unit addBackpack _x;
			} else {
				_unit addWeapon _x;
			};
		};
	} foreach [_primaryweapon] + [_secondaryweapon] + (_items_sidearm);
	
	if(not isNull (unitBackpack _unit)) then{
		clearMagazineCargo (unitBackpack _unit);
		{(unitBackpack _unit) addMagazineCargo _x} foreach _ruckmags;
	};
	
	
	_unit selectWeapon (primaryWeapon _unit);