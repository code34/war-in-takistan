	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - camera focus on object
	// -----------------------------------------------

	private [
		"_text", 
		"_texts", 
		"_original", 
		"_player", 
		"_mydir", 
		"_date", 
		"_creditsend"
	];

	waituntil {isnull wccam};

	disableSerialization;

	wccam = "camera" camCreate [0,0,1000];
	wccam cameraEffect ["internal","back"];
	ShowCinemaBorder true;

	_creditsend = false;

	playmusic "EP1_Track06";

	_texts = [
		localize "STR_WC_TITLE_MISSION",
		"External Scripts",
		"UPS, UPSMON: patrol IA scripting by Kronzky & Monsada",
		"Revive, Artillery, Debug by R3F Team,",
		"Domination by Xeno: global informations",
		"Atot By Miguel Rodriguez, FOB by Eight,",
		"fn_location by Wolffy.au",
		"Nuclear Nuke by Benny Warfare",
		"ACE: Magic Box",
		"Spectator by Kegetys",
		"Takistan Force by Bon: Loadout Preset",
		"ValHalla mission: crew informations", 
		"FlashpointChernarus107 mission: civil cars idea",
		" and all others that i can forgot (..)",
		"Thanks to Fruity Rudy for his english translation",
		"Thanks to Air Commando Team for theirs intensives tests",
		"and all theirs advices, and courage against ied bomberman",
		"Thanks to all of our friends that came and play with us",
		"You can find more information on www.air-commando.org"
		];

	2 cutRsc ["warcontextlabel","PLAIN"]; 

	while { !_creditsend } do {
		_text = _texts select 0;
		_texts = _texts - [_text];

		_player = allUnits call BIS_fnc_selectRandom;
		while { format["%1", position _player] == "[0,0,0]" } do {
			_player = allUnits call BIS_fnc_selectRandom;
		};

		titleText [_text, "BLACK FADED"];
		sleep 2;
		waitUntil {preloadCamera position _player};
		titleText ["", "PLAIN"];

		if(random 1 > 0.5) then {
			_mydir = getdir _player;
			_position =  [(getposatl _player select 0) + (sin _mydir * 2), (getposatl _player select 1) + (cos _mydir * 2), ((getposatl _player) select 2) + 1.5];
			wccam camSetPos _position;
			wccam camSetTarget _player;
			wccam camSetFOV 0.900;
			wccam camCommit 0; 
		} else {
			wccam camsettarget _player;
		 	_player setCameraInterest 50;
			wccam camsetrelpos [(random 4), (random 4), random (2.5)];
			wccam CamCommit 0;
			wccam camsetrelpos [2, 1, 1.65];
			wccam camCommit 7; 
		};

		sleep 7;

		if(count _texts == 0) then {
			_creditsend = true;
		};
	};


	playsound "Nuke";
	_text = "A mission designed by =[A*C]= code34";
	titleText [_text, "BLACK FADED"];
	sleep 2;		
	titleText ["", "PLAIN"];

	wccam cameraEffect ["terminate","back"];
	camDestroy wccam;
	wccam = objNull;