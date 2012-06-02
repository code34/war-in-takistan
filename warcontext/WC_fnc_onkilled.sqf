	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: on killed player event

	_this spawn WC_fnc_garbagecollector;
	
	[] call WC_fnc_saveloadout;

	waituntil {alive player};

	wcrespawntobase = name player;
	["wcrespawntobase", "server"] call WC_fnc_publicvariable;

	if(rank player == "Private") then {
		wcplayeraddscore = [player, -7];
		["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
	};
	if(rank player == "Corporal") then {
		wcplayeraddscore = [player, -6];
		["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
	};
	if(rank player == "Sergeant") then {
		wcplayeraddscore = [player, -5];
		["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
	};
	if(rank player == "Lieutenant") then {
		wcplayeraddscore = [player, -4];
		["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
	};
	if(rank player == "Captain") then {
		wcplayeraddscore = [player, -3];
		["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
	};
	if(rank player == "Major") then {
		wcplayeraddscore = [player, -2];
		["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
	};
	if(rank player == "Colonel") then {
		wcplayeraddscore = [player, -1];
		["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
	};

	wcgarbage = [] spawn WC_fnc_playerhandler;

	wcgarbage = [] spawn WC_fnc_restoreactionmenu;

	wcgarbage = [] spawn WC_fnc_restoreloadout;
