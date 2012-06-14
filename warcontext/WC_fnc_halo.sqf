	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - call halo jump 
	// -----------------------------------------------

	["Halo Jump", "Click a position on map to jump", "You should choose the best safe position on map", 10] spawn WC_fnc_playerhint;

	onMapSingleClick "player setpos _pos; [player, 1000] spawn bis_fnc_halo; onMapSingleClick''; true;";
