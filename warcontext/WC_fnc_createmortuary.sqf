	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// Deployed a mortuary - WARCONTEXT

	private [
		"_position", 
		"_position2", 
		"_rip", 
		"_typeof", 
		"_ytodo"
	];

	_position = getmarkerpos "mortuary";
	_ytodo = wcnumberofkilled / 10;
	_xstart = (_position select 0) - (5 * 5);
	_ystart = (_position select 1) - ((_ytodo /2) * 5);
	_position = [_xstart, _ystart];

	for "_y" from 0 to 10000 step 1 do {
		_position = [(_position select 0) + 5, _position select 1];
		_position2 = _position;
		for "_x" from 0 to 20 step 1 do {
			waituntil { wcgrave > 0 };
			wcgrave = wcgrave - 1;
			_position2 = [_position2 select 0, (_position2 select 1) + 5];
			_typeof = ["gravecross2", "GraveCrossHelmet"] call BIS_fnc_selectRandom;
			_vehicle = _typeof createVehicle _position2;
			_vehicle setpos _position2;
			_position3 = [(_position2 select 0),(_position2 select 1)-1];
			_vehicle = "Grave" createVehicle _position3;
			_vehicle setpos _position3;
		};
		sleep 0.05;
	};


	true;