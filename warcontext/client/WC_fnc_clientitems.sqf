	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// add/remove player items here

	removeBackpack player;

	player addweapon "ITEMGPS";
	player addweapon "Binocular";
	player addweapon "ItemRadio";

	if(wcwithACE == 1) then {
		// add ACE items here
		player addweapon "ACE_Earplugs";

	};