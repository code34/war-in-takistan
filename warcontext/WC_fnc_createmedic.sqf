	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - create an ia medic
	// -----------------------------------------------

	private [
		"_unit",
		"_men"
	];
	
	_unit = _this select 0;

	while { alive _unit } do {
		if(getdammage _unit > 0.10) then {
			_unit action ["heal", _unit];
			sleep 8;
		};

		_men = nearestObjects[_unit,["Man"], 100];
		{
			if(_x in units(group _unit)) then {
				if(getdammage _x > 0.10) then {
					while { ((position _unit distance position _x > 3) and (position _unit distance position _x < 100) and (alive _unit) and (alive _x)) } do {
						_unit domove position _x;
						sleep 10;
					};
					if ((alive _unit) and (alive _x)) then {
						_x action ["heal", _unit];
						sleep 8;
					};
				};
			};
		}foreach _men;
		sleep 1;
	};