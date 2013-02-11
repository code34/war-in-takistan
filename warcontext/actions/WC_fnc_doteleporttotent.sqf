	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - teleport to tent

	private [
		"_vehicle", 
		"_position"
	];

	_position = wcrespawnposition select 0;	
	_vehicle = wcrespawnposition select 1;

	if(format ["%1", _position] == "any") exitWith {hint "No respawn point avalaible";};
	if(format ["%1", _vehicle] == "any") exitWith {hint "No respawn point avalaible";};

	if ((alive _vehicle) and ((position _vehicle) distance _position < 100)) then {
		player setpos _position;
		if(leader(group player) == player) then {
			{		
				if!(isplayer _x) then {
					_x setpos _position;
				};
			}foreach (units(group player));
		};
	} else {
		hint "No respawn point avalaible";
	};