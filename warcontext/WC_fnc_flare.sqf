	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext -  Know if can flare, with wich mag, muzzles
	// -----------------------------------------------

	private [
		"_muzzle", 
		"_magazine", 
		"_weapon", 
		"_canflare"
	];
	
	_weapon = _this select 0;

	if(count getArray(configFile >> "CfgWeapons" >> _weapon >> "muzzles") > 1) then {
		_canflare = true;
		_muzzle = (getArray(configFile >> "CfgWeapons" >> _weapon >> "muzzles") select 1);
		_magazine = (getArray (configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "magazines") select 1);
	} else {
		_canflare = false;
		_muzzle = [];
		_magazine = [];
	};

	[_canflare, _muzzle, _magazine];