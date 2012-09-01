	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - search some one - action script for AI follow players

	private [
		"_unit", 
		"_role"
		];
	
	_unit = _this select 0;

	_role = _unit getvariable "civilrole";

	if (_role in ["bomberman","propagander","altercation","saboter","builder"]) then {
		wcgarbage = ["Search Someone", "You found a terrorist", "You should arrest him and bring him back to base", 10] spawn WC_fnc_playerhint;
	} else {
		wcgarbage = ["Search Someone", "Nothing seems to be suspect", "Search others civil if you have some doubt", 10] spawn WC_fnc_playerhint;
	};