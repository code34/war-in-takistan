	// ---------------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Detacte Ied and playsound when nearest
	// ---------------------------------------------------

	private [
		"_counter",
		"_objects", 
		"_sound",
		"_printed"
	];

	_printed = false;

	while { true } do {
		if ((wceverybodyengineer == 1) or (typeOf player in wcengineerclass)) then {
			_objects = nearestObjects [player, ["All"], 30];
			{
				if(_x getvariable "wciedactivate") then {
					if!(_printed) then {
						wcgarbage = [localize "STR_WC_MESSAGEDETECTORIED", localize "STR_WC_MESSAGETRYTOMOVEAROUND", localize "STR_WC_MESSAGEIEDHASBEENDETECT", 10] spawn WC_fnc_playerhint;
						_printed = true;
						_counter = 0;
					};
					if(vehicle player == player) then {
						if(player distance _x > 20) then {
							if(random 1 < 0.8) then {
								playsound "bombdetector2";
							} else {
								_sound = ["bombdetector1", "bombdetector2", "bombdetector3"] call BIS_fnc_selectRandom;
								playsound _sound;
							};
						} else {
							if(player distance _x > 10) then {
								if(random 1 < 0.9) then {
									playsound "bombdetector3";
								} else {
									_sound = ["bombdetector1", "bombdetector2", "bombdetector3"] call BIS_fnc_selectRandom;
									playsound _sound;
								};								
							} else {
								if(random 1 < 0.97) then {
									playsound "bombdetector1";
								} else {
									_sound = ["bombdetector1", "bombdetector2", "bombdetector3"] call BIS_fnc_selectRandom;
									playsound _sound;
								};
							};
						};
					};
				};
				sleep 0.01;
			}foreach _objects;

			// false - positive
			if((random 1 > 0.995) and wciedfalsepositive) then {
				if(player distance getmarkerpos "respawn_west" > 1000) then {
					if((getposatl player) select 2 < 1) then {
						wcgarbage = [localize "STR_WC_MESSAGEDETECTORIED", localize "STR_WC_MESSAGETRYTOMOVEAROUND", localize "STR_WC_MESSAGEIEDHASBEENDETECT", 10] spawn WC_fnc_playerhint;
						_printed = true;
						_counter = 0;
						_sound = ["bombdetector1", "bombdetector2", "bombdetector3"] call BIS_fnc_selectRandom;
						playsound _sound;
					};
				};
			};

			if(_printed) then {
				_counter = _counter + 1;
				if(_counter > 15) then {
					_printed = false;
				};
			};
			sleep 1;
		};
	};		
