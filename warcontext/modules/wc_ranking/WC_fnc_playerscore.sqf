	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  manage player score

	private [
		"_player",
		"_playername",
		"_point",
		"_score"
	];

	while { true } do {
		{
			_playername = _x select 0;
			_player = _x select 1;
			_point = _x select 2;
			if(score _player < 0) then {
				_score = (score _player) * -1;
				_player addscore _score;
			} else {
				if(score _player != _point) then {
					_score = _point - (score _player);
					_player addscore _score;
				};
			};
			sleep 0.01;
		}foreach wcscoreboard;
		sleep 1;
	};
