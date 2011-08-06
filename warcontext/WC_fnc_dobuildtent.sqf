	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// Create a tent respawn point
	// -----------------------------------------------

	private ["_position", "_mydir"];

	if (((position player) distance (getmarkerpos "respawn_west")) < 300) exitwith { 
		[localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGETRYTOMOVEOUT", localize "STR_WC_MESSAGECANCREATETENT", 10] spawn WC_fnc_playerhint;
	};

	_mydir = getdir player;
	_position =  [(getposatl player select 0) + (sin _mydir * 2), (getposatl player select 1) + (cos _mydir * 2), 0];

	if(isnil "wctent") then {
		[localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGEBUILDING", localize "STR_WC_MESSAGEBUILDINGINFORMATION", 8] spawn WC_fnc_playerhint;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 8;
		if!(alive player) exitwith {}; 
		wctent =  "ACamp_EP1" createvehicle _position;
		wctent setposatl _position;
		wctent setVariable ["owner", name player, true];
		_text = format["this addAction [""<t color='#ff4500'>Remove tent of %1</t>"", ""warcontext\WC_fnc_removetent.sqf"",[],-1,false];", name player];
		wctent setVehicleInit _text;
		processInitCommands;
		wcrespawnposition = [position player, wctent];
		"respawn" setmarkerposlocal _position;
		"respawn" setmarkersizelocal [0,0]; 
		[localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGEBUILDINGFINISHED",localize "STR_WC_MESSAGEBUILDINGINFORMATION", 3] spawn WC_fnc_playerhint;
	} else {
		if((getdammage wctent > 0.9) or !(alive wctent)) then {
			deletevehicle wctent;
			[localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGEBUILDING", localize "STR_WC_MESSAGEBUILDINGINFORMATION", 8] spawn WC_fnc_playerhint;
			player playMove "AinvPknlMstpSlayWrflDnon_medic";
			sleep 8;
			if!(alive player) exitwith {}; 
			wctent = nil;
			wctent =  "ACamp_EP1" createvehicle _position;
			wctent setposatl _position;
			wctent setVariable ["owner", name player, true];
			_text = format["this addAction [""<t color='#ff4500'>Remove tent of %1</t>"", ""warcontext\WC_fnc_removetent.sqf"",[],-1,false];", name player];
			wctent setVehicleInit _text;
			processInitCommands;
			wcrespawnposition = [position player, wctent];
			"respawn" setmarkerposlocal _position;
			"respawn" setmarkersizelocal [0.5,0.5]; 
			[localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGEBUILDINGFINISHED",localize "STR_WC_MESSAGEBUILDINGINFORMATION", 3] spawn WC_fnc_playerhint;
		} else {
			[localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGEREMOVETENT", localize "STR_WC_MESSAGECANBUILDTENT", 10] spawn WC_fnc_playerhint;
		};
	};

	waituntil { !alive wctent };

	"respawn" setmarkerposlocal [0,0,0];
	"respawn" setmarkersizelocal [0,0]; 