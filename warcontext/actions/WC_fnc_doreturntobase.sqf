	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// -----------------------------------------------

	private [
		"_position"
	];

	_position = getmarkerpos "respawn_west";

	player setpos _position;

	if(leader(group player) == player) then {
		{		
			if!(isplayer _x) then {
				_x setpos _position;
			};
		}foreach (units(group player));
	};