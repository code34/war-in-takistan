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
	
		if!(isnull _target && _target distance player < 5) then {
			_name = getText (configFile >> "CfgVehicles" >> typeof _target >> "displayName");
			_menurepair = nil;
			_vehicle = vehicle player;

			// repair point
			if(typeof _target in wcrepairpointtype) then {
				_menurepair = _vehicle addAction [format ["<t color='#ff4500'>%1</t>", _name], 'warcontext\modules\wc_repairzone\WC_fnc_servicing.sqf',[],-1,false, true];
			};

			while { _target == cursortarget } do {
				sleep 1;
			};
			if!(isnil "_menurepair") then { _vehicle removeaction _menurepair;};

		};
		sleep 1;
	};