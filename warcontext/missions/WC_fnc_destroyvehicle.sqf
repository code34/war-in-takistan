	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a destroy vehicle mission

	private [
		"_electricalmalus", 
		"_fuelmalus", 
		"_missioncomplete",
		"_nuclearmalus",
		"_vehicle"
	];

	_vehicle = _this select 0;

	if(!isnil (_this select 1)) then {
		_nuclearmalus 		= _this select 1;
	} else {
		_nuclearmalus = 0;
	};

	if(!isnil (_this select 2)) then {
		_fuelmalus 		= _this select 2;
	} else {
		_fuelmalus = 0;
	};

	if(!isnil (_this select 3)) then {
		_electricalmalus 	= _this select 3;
	} else {
		_electricalmalus = 0;
	};

	_missioncomplete = false;

	while {!_missioncomplete} do {
		if((!alive _vehicle) or (damage _vehicle > 0.9)) then {
			_vehicle setdamage 1;
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; };
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			wcleveltoadd = 1;
			_missioncomplete = true;
		};
		sleep 5;
	};


	wcnuclearprobability = wcnuclearprobability - _nuclearmalus;
	wcenemyglobalfuel = wcenemyglobalfuel - _fuelmalus;
	wcenemyglobalelectrical = wcenemyglobalelectrical - _electricalmalus;