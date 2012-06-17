	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext : check if pilot is team member

	private [
		"_vehicle",
		"_fuel",
		"_text"
	];

	// kindofserver 1 = team
	if(wckindofserver != 1) exitwith {};

	_vehicle = vehicle player;
	_fuel = fuel _vehicle;

	if((_vehicle iskindof 'air') and (driver _vehicle == player) and !((vehicle player) iskindof "ParachuteBase")) then { 
		if!((name player) in wcinteam) then { 
			player action ['eject', wcvehicle];
			_vehicle engineon false;
			['Pilot', 'Ask to admin to recruit you as team member', 'You can not pilot air vehicle', 8] spawn WC_fnc_playerhint;
			_vehicle setfuel 0;
			sleep 1;
			_text = format["this setfuel %1;", _fuel];
			_vehicle setvehicleinit _text;
			processInitCommands
		}; 
	};