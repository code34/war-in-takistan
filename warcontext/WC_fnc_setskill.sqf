	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext : set skill of ia
	// context: server side
	// -----------------------------------------------

	if (!isServer) exitWith{};

	private [
		"_unit",
		"_level"
		];
	
	_unit 	= _this select 0;
	_level 	= _this select 1; 
	
	_skill = [
		"aimingAccuracy",
		"aimingShake",
		"aimingSpeed",
		"endurance",
		"spotDistance",
		"spotTime",
		"courage",
		"reloadSpeed",
		"commanding",
		"general"
		];

	_unit setskill _level;
	
	{
		_unit setskill [_x, _level];
		sleep 0.05;
	}foreach _skill;

	true;