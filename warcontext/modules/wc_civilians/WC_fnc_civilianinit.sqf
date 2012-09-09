	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - init civilian with a queue for less lag
	// -----------------------------------------------

	private ["_unit", "_civiltype"];

	// sanitize propagander array
	wcgarbage = [] spawn {
		while { true } do {
			{
				if(!alive _x) then {
					wcpropagander = wcpropagander - [_x];
				};
			}foreach wcpropagander;
			sleep 60;
		};
	};

	while { true } do {
		waituntil { count wccivilianstoinit > 0 };

		_unit = wccivilianstoinit select 0;
		wccivilianstoinit = wccivilianstoinit - [_unit];

		switch (_unit getvariable "civilrole") do {
				case "bomberman": {
					_unit addbackpack "TK_ALICE_Pack_Explosives_EP1";
					wcgarbage = [_unit] spawn WC_fnc_createied;
				};
	
				case "propagander": {
					wcgarbage = [_unit] spawn WC_fnc_propagand;
				};
			
				case "altercation": {
					wcgarbage = [_unit] spawn WC_fnc_altercation;
				};
			
				case "saboter": {
					_unit addbackpack "TK_ALICE_Pack_Explosives_EP1";
					wcgarbage = [_unit] spawn WC_fnc_sabotercivilian;
				};

				case "builder": {
					wcgarbage = [_unit] spawn WC_fnc_buildercivilian;
				};

				case "healer": {
					wcgarbage = [_unit] spawn WC_fnc_healercivilian;
				};

				case "driver": {
					wcgarbage = [_unit] spawn WC_fnc_drivercivilian;
				};
		};
		sleep 1;
	};