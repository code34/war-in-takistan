	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Add an addaction menu depending of target
	// Patrol ops reworks

	private [
		"_menurepair",
		"_name",
		"_target",
		"_vehicle"
	];


	while { true } do {
		_target = cursortarget;
	
		if(!(isnull _target) and (_target distance player < 10)) then {
			sleep 1;
			if(_target == cursortarget) then {
				_name = getText (configFile >> "CfgVehicles" >> typeof _target >> "displayName");
				_menurepair = nil;
				_menurepairalone = nil;
				_menuunlock = nil;
				_menuunflip = nil;
	
				_vehicle = vehicle player;
	
				// repair point
				if(typeof _target in wcrepairpointtype) then {
					_menurepair = _vehicle addAction [format ["<t color='#ffcb00'>%1</t>", _name], 'warcontext\modules\wc_repairzone\WC_fnc_servicing.sqf',[],6,false, true];
				};
				if (typeOf player in wcengineerclass) then {
					if(_target iskindof "LandVehicle") then {
						_menurepairalone = player addaction ["<t color='#ffcb00'>"+localize "STR_WC_MENUREPAIRVEHICLE"+"</t>","warcontext\actions\WC_fnc_dorepairvehicle.sqf",[],6,false];
						_menuunlock = player addaction ["<t color='#ffcb00'>"+localize "STR_WC_MENUUNLOCKVEHICLE"+"</t>","warcontext\actions\WC_fnc_dounlockvehicle.sqf",[],6,false];
						_menuunflip = player addaction ["<t color='#ffcb00'>Unflip Vehicle</t>","warcontext\actions\WC_fnc_dounflipvehicle.sqf",[],6,false];
					};
				};
	
				while { _target == cursortarget } do {
					sleep 1;
				};
	
				if!(isnil "_menurepair") then { _vehicle removeaction _menurepair;};
				if!(isnil "_menurepairalone") then { player removeaction _menurepairalone;};
				if!(isnil "_menuunlock") then { player removeaction _menuunlock;};
				if!(isnil "_menuunflip") then { player removeaction _menuunflip;};
			};
		};
		sleep 1;
	};