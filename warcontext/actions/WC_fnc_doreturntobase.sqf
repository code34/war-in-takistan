	// -----------------------------------------------
	// Author: code34 nicolas_boiteux@yahoo.fr
	// warcontext - teleport to base

	private [
		"_position"
	];

	_position = getmarkerpos "respawn_west";

	if(leader(group player) == player) then {
		{		
			if((!isplayer _x) and (_x distance player < 50)) then {
				_x setpos _position;
			};
		}foreach (units(group player));
	};

	player setpos _position;