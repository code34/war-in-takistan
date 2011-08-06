	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description:
	// Attach a marker to an object
	// -----------------------------------------------

	private ["_vehicle", "_position"];

	_vehicle = wcteleport;

	if(format ["%1", _vehicle] == "any") exitWith {hint "No respawn point avalaible";};

	_position = (position _vehicle) findemptyposition [10, 300];

	if ((alive _vehicle) and ((position _vehicle) distance _position < 100)) then {
		player setpos _position;
	} else {
		hint "No respawn point avalaible";
	};