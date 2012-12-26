	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// Create a tent respawn point
	// -----------------------------------------------

	private ["_position", "_mydir", "_exit"];

	if (((position player) distance (getmarkerpos "respawn_west")) < 300) exitwith { 
		wcgarbage = [localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGETRYTOMOVEOUT", localize "STR_WC_MESSAGECANCREATETENT", 10] spawn WC_fnc_playerhint;
	};

	_exit = false;
	if(wcwithACE == 0) then {
		if(isnull (unitBackpack player)) then {
			wcgarbage = [localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGETAKEABACKPACK", localize "STR_WC_MESSAGECANCREATETENT", 10] spawn WC_fnc_playerhint;
			_exit = true;
		};
	} else {
		if!(player call ace_sys_ruck_fnc_hasRuck) exitwith {
			wcgarbage = [localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGETAKEABACKPACK", localize "STR_WC_MESSAGECANCREATETENT", 10] spawn WC_fnc_playerhint;
			_exit = true;
		};
	};

	if(_exit) exitwith {};

	_mydir = getdir player;
	_position =  [(getposatl player select 0) + (sin _mydir * 2), (getposatl player select 1) + (cos _mydir * 2), 0];

	if(isnil "wctent") then {
		wcgarbage = [localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGEBUILDING", localize "STR_WC_MESSAGEBUILDINGINFORMATION", 8] spawn WC_fnc_playerhint;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 8;
		if!(alive player) exitwith {}; 
		wctent =  "ACamp_EP1" createvehicle _position;
		wctent setposatl _position;
		wctent setVariable ["owner", name player, true];
		_text = format["this addAction [""<t color='#ffcb00'>Remove tent of %1</t>"", ""warcontext\actions\WC_fnc_doremovetent.sqf"",[],6,false];", name player];
		wctent setVehicleInit _text;
		processInitCommands;
		wcrespawnposition = [position player, wctent];
		wcrespawnmarker setmarkerposlocal _position;
		wcrespawnmarker setmarkersizelocal [0.5,0.5]; 
		wcrespawnmarker setmarkertextlocal format["%1 Camp", name player];
		wcgarbage = [localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGEBUILDINGFINISHED",localize "STR_WC_MESSAGEBUILDINGINFORMATION", 3] spawn WC_fnc_playerhint;
	} else {
		if((getdammage wctent > 0.9) or !(alive wctent)) then {
			deletevehicle wctent;
			wcgarbage = [localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGEBUILDING", localize "STR_WC_MESSAGEBUILDINGINFORMATION", 8] spawn WC_fnc_playerhint;
			player playMove "AinvPknlMstpSlayWrflDnon_medic";
			sleep 8;
			if!(alive player) exitwith {}; 
			wctent = nil;
			wctent =  "ACamp_EP1" createvehicle _position;
			wctent setposatl _position;
			wctent setVariable ["owner", name player, true];
			_text = format["this addAction [""<t color='#ffcb00'>Remove tent of %1</t>"", ""warcontext\actions\WC_fnc_doremovetent.sqf"",[],6,false];", name player];
			wctent setVehicleInit _text;
			processInitCommands;
			wcrespawnposition = [position player, wctent];
			wcrespawnmarker setmarkerposlocal _position;
			wcrespawnmarker setmarkersizelocal [0.5,0.5]; 
			wcrespawnmarker setmarkertextlocal format["%1 Camp", name player];
			wcgarbage = [localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGEBUILDINGFINISHED",localize "STR_WC_MESSAGEBUILDINGINFORMATION", 3] spawn WC_fnc_playerhint;
		} else {
			wcgarbage = [localize "STR_WC_MESSAGEDEPLOYATENT", localize "STR_WC_MESSAGEREMOVETENT", localize "STR_WC_MESSAGECANBUILDTENT", 10] spawn WC_fnc_playerhint;
		};
	};

	waituntil { !alive wctent };

	"respawn" setmarkerposlocal [0,0,0];
	"respawn" setmarkersizelocal [0,0]; 