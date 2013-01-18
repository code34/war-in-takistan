	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - camera focus on object
	// -----------------------------------------------

	private [
		"_text", 
		"_texts", 
		"_original", 
		"_player", 
		"_mydir", 
		"_creditsend",
		"_position"
	];

	waituntil {isnull wccam};
	waituntil {!(player getvariable "deadmarker")};

	_position = (getmarkerpos "respawn_west") findEmptyPosition [10, 200];
	if(count _position == 0) then {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR PLAYER OUTRO";
		player setpos wcmapcenter;
	} else {
		player setpos _position;
	};

	disableSerialization;

	wccam = "camera" camCreate [0,0,1000];
	wccam cameraEffect ["internal","back"];
	ShowCinemaBorder true;
	_player = player;
	_mydir = getdir _player;
	_position =  [(getposatl _player select 0) + (sin _mydir * 2), (getposatl _player select 1) + (cos _mydir * 2), ((getposatl _player) select 2) + 1.5];
	wccam camSetPos _position;
	wccam camSetTarget _player;
	wccam camSetFOV 0.900;
	wccam camCommit 0; 

	_teampromote = localize format["STR_WC_TEAM%1", wcteamlevel];
	_text = format["Congratulations.\nYou finish the campaign: War In %1: operation iron rains.\n\nYou win your tickets to return home after %2 days.\nYour team level was: %3", worldname, wcday, _teampromote];

	titleText [_text, "BLACK FADED"];
	sleep 6;		
	titleText ["", "PLAIN"];

	playMusic "outro";

	sleep 4;

	_date = date;
	setDate [1986, 2, 25, 17, 0];

	_texts = [
		"This mission was designed by  code34",
		"There was more than 120 versions ...",
		"During this development time, there was an anormal number of IA killings",
		"that were due to nuclear and carpet bombing.",
		"The mission uses the WARCONTEXT ENGINE v3",
		"Thanks to: all of my friends"
		];

	_original = _texts;

	while { count _texts > 0} do {
		_text = _texts select 0;
		_texts = _texts - [_text];


		if(_text == "Thanks to: Air Commando Team for theirs intensives tests") then {
			playMusic "pumpit";
		};

		titleText [_text, "BLACK FADED"];
		sleep 2;		
		titleText ["", "PLAIN"];

		_player = allUnits call BIS_fnc_selectRandom;
		while { format["%1", position _player] == "[0,0,0]" } do {
			_player = allUnits call BIS_fnc_selectRandom;
		};

		cutText [format["%1",name _player],"PLAIN DOWN",0];

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
			wccam camsetrelpos [-4, -14, 1.65];
			wccam CamCommit 0;
			wccam camsetrelpos [10, -4, random 20];
			wccam camCommit 7; 
		};
		sleep 7;
	};

	setdate _date;

	wccam cameraEffect ["terminate","back"];
	camDestroy wccam;
	wccam = objNull;