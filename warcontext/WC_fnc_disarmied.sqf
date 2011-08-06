	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext -  ied keyboard numpad challenge
	// -----------------------------------------------

	private ["_letters", "_letter", "_time", "_count", "_object", "_lastcount", "_lastletter", "_training", "_param"];

	_letters = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

	_object = _this select 0;
	_param = _this select 3;

	if(count _param == 0) then { _training = false; } else { _training = true; };

	// arcade = 1
	if(wckindofgame == 1) then {
		_count = 0;
	} else {
		_count = ceil(wclevel +(random 10));
	};

	wciedexplosed = false;
	wciedcount = 0;
	wciedchallenge = true;

	["Disarm Ied", "Complete the combo keys sequence to disarm ied.", "Press the same numpad keys printed on the screen", 10] spawn WC_fnc_playerhint;
	sleep 6;

	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	["GO"] spawn BIS_fnc_dynamicText;
	sleep 1;
	[""] spawn BIS_fnc_dynamicText;
	
	_lastletter = "";

	while { (wciedcount < _count and !wciedexplosed) } do {
		_lastcount = wciedcount;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		_letter = _letters call BIS_fnc_selectRandom;
		while { _letter == _lastletter } do {
			_letter = _letters call BIS_fnc_selectRandom;
		};
		_lastletter = _letter;
		iedkey = _letter;
		_time = ceil(random 4);
		call compile format["2 cutRsc ['keypad%1','PLAIN'];", _letter];
		2 cutFadeOut _time;
		sleep _time;
		if(wciedcount - _lastcount != 1) then {wciedexplosed = true;};
	};

	if(wciedexplosed) then {
		["FAILED"] spawn BIS_fnc_dynamicText;
		if!(_training) then {
			wchintW = format["An ied has explosed near %1", name player];
			["wchintW", "client"] call WC_fnc_publicvariable;
			hintsilent wchintW;
			"ARTY_R_227mm_HE" createVehicle position player;
			"Bo_GBU12_LGB" createVehicle position player;
			wcteambonusaddscore = -1;
			["wcteambonusaddscore", "server"] call WC_fnc_publicvariable;
		};
	} else {
		["SUCCESS"] spawn BIS_fnc_dynamicText;
		if!(_training) then {
			wchintW = format["An ied has been disarm by %1", name player];
			["wchintW", "client"] call WC_fnc_publicvariable;
			hintsilent wchintW;
			wcteambonusaddscore = 3;
			["wcteambonusaddscore", "server"] call WC_fnc_publicvariable;
		};
	};

	if!(_training) then {
		_object setvariable ["wciedactivate", false, true];
		_object setVehicleInit "this removeAction 0;";
		processInitCommands;
	};
	wciedchallenge = false;