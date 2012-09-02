	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - restore body with good clothes

	private [
		"_killer",
		"_dummy"
	];

	_killer = _this select 0;

	wcbackupbody setpos wcbackupposition;

	if(name _killer == name player) then {
		waituntil { alive player };
		_dummy = player;
		player setpos getmarkerpos "initpos";	
		selectplayer wcbackupbody;
		(findDisplay 46) displayAddEventHandler ["KeyDown","_this call WC_fnc_keymapper;"];
		deletevehicle _dummy;
	};