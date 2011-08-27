	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - init civilian with a queue for less lag
	// -----------------------------------------------

	private ["_unit", "_civiltype"];

	while { true } do {
		waituntil { count wccivilianstoinit > 0 };

		_unit = wccivilianstoinit select 0;
		wccivilianstoinit = wccivilianstoinit - [_unit];

		if(random 1 > 0.97) then {
			_civiltype = ["bomberman", "propagander", "altercation", "saboter"] call BIS_fnc_selectRandom;
			
			switch (_civiltype) do {
				case "bomberman": {
					if(random 1 > wcfame) then {
						wcgarbage = [_unit] spawn WC_fnc_createied;
					};
				};
			
				case "propagander": {
					if(random 1 > wcfame) then {
						wcgarbage = [_unit] spawn WC_fnc_propagand;
					};
				};
			
				case "altercation": {
					if(random 1 > wcfame) then {
						wcgarbage = [_unit] spawn WC_fnc_altercation;
					};
				};
			
				case "saboter": {
					if(random 1 > wcfame) then {
						wcgarbage = [_unit] spawn WC_fnc_sabotagecivilian;
					};
				};
			};
		} else {
			if(random 1 > 0.8) then {
				wcgarbage = [_unit] spawn WC_fnc_dodrive;
			};
		};
		
		_unit addEventHandler ['HandleDamage', {
			if!((_this select 0) == (_this select 3)) then {
				(_this select 0) setdamage (0.5 + (random 0.5));
			};
		}];

		_unit addeventhandler ['killed', {
			_this spawn WC_fnc_garbagecollector;
			if((name (_this select 1)) in wcinteam) then {
				wcnumberofkilledofmissionC = wcnumberofkilledofmissionC + 1;
				wccivilkilled =  wccivilkilled + 1;
				["wccivilkilled", "client"] call WC_fnc_publicvariable;
				wcfame = wcfame - random (0.1);
			};
		}];

		if!((typeof _unit) in wccivilwithoutweapons) then {
			if( random 1 > wcfame ) then {
				_unit addweapon "AKS_74";
				_unit addmagazine "30Rnd_545x39_AK";
			};
			_unit addEventHandler ['Fired', '(_this select 0) setvehicleammo 1;'];
		};
		sleep 0.5;
	};