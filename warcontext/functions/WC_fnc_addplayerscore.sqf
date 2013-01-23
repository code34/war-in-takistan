	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description:
	// Add score to a player depend of his ranking
	// -----------------------------------------------

	private["_rank", "_ratio", "_score"];

	_score = _this select 0;

	// Player should be in team
	if((name player) in wcinteam) then {
		_rank = rank player;
		if(_rank == "Private") then { _ratio = ceil(_score * 0.4);};
		if(_rank == "Corporal") then { _ratio = ceil(_score * 0.5);};
		if(_rank == "Sergeant") then { _ratio = ceil(_score * 0.6);};
		if(_rank == "Lieutenant") then { _ratio = ceil(_score * 0.7);};
		if(_rank == "Captain") then { _ratio = ceil(_score * 0.8);};
		if(_rank == "Major") then { _ratio = ceil(_score * 0.9);};
		if(_rank == "Colonel") then { _ratio = ceil(_score);};
		wcteamplayscore = wcteamplayscore + _ratio;
	};