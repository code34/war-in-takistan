		// -----------------------------------------------
		// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
		// warcontext - relocate a position on a town
		// -----------------------------------------------

		private [
			"_location", 
			"_position", 
			"_max", 
			"_gridofposition", 
			"_result", 
			"_buildings"
		];

		_position = _this select 0;

		_max = 0;
		_result = [0,0,0];
		while { format["%1", _position] != format["%1", _result] } do {
			_result = _position;
			_gridofposition = [_position, (100 + random(800))] call WC_fnc_creategridofposition;
			{
				_buildings = nearestObjects [_x, ["house","building"] , 200];
				if(count _buildings > _max) then {
					_max = count _buildings;
					_position = _x;
				};
			} foreach _gridofposition;
		};
		_position;
		