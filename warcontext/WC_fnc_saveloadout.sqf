	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - save loadout
	// -----------------------------------------------


	if (isDedicated) exitWith {};

	private [
		"_magazines", 
		"_weapons", 
		"_hasruck", 
		"_hasruckace", 
		"_ruckmags", 
		"_ruckweapons", 
		"_rucktype", 
		"_enemy", 
		"_sacados_avant_mort", 
		"_backpack", 
		"_weapononback"
	];
	
	wcmagazines = magazines player;
	wcweapons = weapons player;

	wchasruck = false;
	wchasruckace = false;

	if!(isnull (unitBackpack player)) then {
		wchasruck = true;
		wcbackpack = unitBackpack player;
		wcrucktype = typeof _backpack;
		wcruckmags = getMagazineCargo _backpack;
		wcruckweapons = getWeaponCargo _backpack;
	};

	wcruckmags = [];
	wcruckweapons = [];
	wcweapononback = [];
	
	if(wcwithACE == 1) then {
		wcweapononback = player getvariable "ACE_weapononback";
		if (player call ace_sys_ruck_fnc_hasRuck) then {
			wcrucktype = player call ACE_Sys_Ruck_fnc_FindRuck;
			wcruckmags = player getvariable "ACE_RuckMagContents";
			wcruckweapons = player getvariable "ACE_RuckWepContents";
			wchasruckace = true;
		};
	};