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

	//_nuclearmalus 		= _this select 1;
	//_fuelmalus 		= _this select 2;
	//_electricalmalus 	= _this select 3;

	_missioncomplete = false;

	while {!_missioncomplete} do {
		if((!alive _vehicle) or (damage _vehicle > 0.9)) then {
			_vehicle setdamage 1;
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			wcleveltoadd = 1;
			_missioncomplete = true;
		};
		sleep 5;
	};


	//wcnuclearprobability = wcnuclearprobability - _nuclearmalus;
	//wcenemyglobalfuel = wcenemyglobalfuel - _fuelmalus;
	//wcenemyglobalelectrical = wcenemyglobalelectrical - _electricalmalus;