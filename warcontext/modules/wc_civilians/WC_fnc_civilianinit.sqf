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
		
		_unit addEventHandler ['HandleDamage', {
			if!((_this select 0) == (_this select 3)) then {
				(_this select 0) setdamage (0.5 + (random 0.5));
			};
		}];

		_unit addeventhandler ['killed', {
			wcgarbage = _this spawn WC_fnc_garbagecollector;
			if((name (_this select 1)) in wcinteam) then {
				wcnumberofkilledofmissionC = wcnumberofkilledofmissionC + 1;
				wccivilkilled =  wccivilkilled + 1;
				["wccivilkilled", "client"] call WC_fnc_publicvariable;
				wcfame = wcfame - random (0.1);
			};
		}];

		if!((typeof _unit) in wccivilwithoutweapons) then {
			_unit addEventHandler ['Fired', '(_this select 0) setvehicleammo 1;'];
		};

		wcgarbage = [_unit, wccivilianskill] spawn WC_fnc_setskill;
		sleep 2;
	};