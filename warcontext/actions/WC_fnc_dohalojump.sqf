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

	wchalojumppos = [];

	onMapSingleClick "titleText ['','BLACK IN', 10]; wchalojumppos = _pos; onMapSingleClick''; openMap [false, false];";

	while { (visibleMap) } do {
		sleep 0.5;
	};

	if(count wchalojumppos == 0) then {
		onMapSingleClick'';
		[localize "STR_WC_MENUHALOJUMP", localize "STR_WC_MESSAGEHALOJUMPNEWONE", localize "STR_WC_MESSAGECANCELHALOJUMPINFORMATION", 10] spawn WC_fnc_playerhint;
	} else {

		player setpos [(wchalojumppos select 0), (wchalojumppos select 1), 1000];
		player switchmove "HaloFreeFall_non";
		[player, 1000] spawn bis_fnc_halo;
		[player] spawn WC_fnc_altimeter;
	};