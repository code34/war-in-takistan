	// ---------------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Detacte Ied and playsound when nearest
	// ---------------------------------------------------

	private [
		"_objects", 
		"_sound"
	];

	while { true } do {
		if ((wceverybodyengineer == 1) or (typeOf player in wcengineerclass)) then {
			_objects = nearestObjects [player, ["All"], 30];
			{
				if(_x getvariable "wciedactivate") then {
					if(vehicle player == player) then {
						if(player distance _x > 20) then {
							playsound "bombdetector2";	
						} else {
							if(player distance _x > 10) then {
								playsound "bombdetector3";
							} else {
								playsound "bombdetector1";
							};
						};
					};
				};
				sleep 0.01;
			}foreach _objects;

			// false - positive
			if(random 1 > 0.99) then {
				_sound = ["bombdetector1", "bombdetector2", "bombdetector3"] call BIS_fnc_selectRandom
				playsound _sound;
			};
			sleep 1;
		};
	};		
