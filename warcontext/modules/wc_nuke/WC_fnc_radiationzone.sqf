	// --------------------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// Create a radiation zone that damage objects during time
	// --------------------------------------------------------

	private [
		"_array"
	];

	while { true } do {
		{
			_array = _x nearEntities [["Man","Landvehicle"], 500];
			{
				if(side _x == civilian) then {
					_x setdamage (getDammage _x +  0.01);
				} else {
					_x setdamage (getDammage _x +  0.001);
				};
				{_x setdamage  (getDammage _x + 0.001); sleep 0.01;} foreach (crew _x);
				sleep 0.01;
			} forEach _array;
			sleep 0.01;
		}foreach wcnuclearzone;
		sleep 1;
	};