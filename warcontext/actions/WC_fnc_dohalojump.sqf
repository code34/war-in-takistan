	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - call halo jump 
	// -----------------------------------------------

	private [
		"_position"
	];

	_position = position player;

	[localize "STR_WC_MENUHALOJUMP", localize "STR_WC_MESSAGECLICKHALOJUMP", localize "STR_WC_MESSAGEHALOJUMPINFORMATION", 10] spawn WC_fnc_playerhint;

	openMap [true, false];

	onMapSingleClick "titleText ['','BLACK IN', 10]; player setpos _pos; onMapSingleClick''; openMap [false, false];";

	while { (visibleMap) } do {
		sleep 0.5;
	};

	if(format["%1", _position] == format ["%1", position player]) then {
		onMapSingleClick'';
		[localize "STR_WC_MENUHALOJUMP", localize "STR_WC_MESSAGEHALOJUMPNEWONE", localize "STR_WC_MESSAGECANCELHALOJUMPINFORMATION", 10] spawn WC_fnc_playerhint;
	} else {
		[player] spawn WC_fnc_altimeter;
	};