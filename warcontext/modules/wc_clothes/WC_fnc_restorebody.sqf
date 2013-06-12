	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - restore body with good clothes

	private [
		"_killer",
		"_dummy"
	];

	_killer = _this select 0;

	wcbackupbody setpos wcbackupposition;
	wcbackupbody addeventhandler ["HandleDamage", { 
		(_this select 0) setdamage ((getdammage(_this select 0)) + (_this select 2));
	}];

	waituntil { alive player };
	_dummy = player;
	player setpos getmarkerpos "initpos";	
	selectplayer wcbackupbody;
	(findDisplay 46) displayAddEventHandler ["KeyDown","_this call WC_fnc_keymapper;"];
	deletevehicle _dummy;
