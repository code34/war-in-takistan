	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - nuclear weapon with ACE
	// -----------------------------------------------

	private [
		"_location", 
		"_position", 
		"_unit", 
		"_nuclearammo", 
		"_counter",
		"_array"
	];
	
	_unit = _this select 0;
	_nuclearammo = _this select 1;

	if(count _this == 1) then { _nuclearammo = 1;};
	diag_log "NUCLEAR FIRE WAS LAUNCHED";
	
	while {((getdammage _unit < 0.7) and (_nuclearammo > 0))} do {

		_position = position (wctownlocations call BIS_fnc_selectRandom);
		_position = [_position] call WC_fnc_relocateposition;
		while { _position distance getmarkerpos "respawn_west" < 2000} do {
			_position = position (wctownlocations call BIS_fnc_selectRandom);
			_position = [_position] call WC_fnc_relocateposition;
			sleep 0.05;
		};	

		wcbomb = true;
		["wcbomb", "client"] call WC_fnc_publicvariable;
		wcmessageW = [format[localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", wclevel], "NUCLEAR BOMBING TAKE COVER"];
		if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		// create nuclear marker
		_marker = [format['nuclear%1', wcnuclearindex], 500, _position, 'ColorOrange', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarker;
		wcnuclearindex = wcnuclearindex + 1;

		sleep (random 240);

		_array = _position nearEntities [["All"], 500];
		{
			_x setdamage (0.5 + random (0.5));
		} forEach _array;

		wcnewnuclearzone = _position;
		["wcnewnuclearzone", "client"] call WC_fnc_publicvariable;
		wcnuclearzone = wcnuclearzone + [_position];
		if!(isDedicated) then {wcgarbage = [wcnewnuclearzone] spawn WC_fnc_nuclearnuke;} else {	["wcnuclearzone", "client"] call WC_fnc_publicvariable;};
		_nuclearammo = _nuclearammo - 1;
        	sleep 240 + random 240;
	};
