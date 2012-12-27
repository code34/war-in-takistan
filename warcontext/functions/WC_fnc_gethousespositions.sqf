	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description:
	// get all houses position in a zone
	// parameters can be top, bot, all

	private [
		"_alt",
		"_arrayofpos",
		"_buildings",
		"_index",
		"_position",
		"_type"
	];

	_position = _this select 0;
	_type = _this select 1;

	_buildings = nearestObjects [_position, ["House"], 350];
	_arrayofpos = [];

	if(count _position < 3) exitwith { diag_log "WARCONTEXT: Gethousesposition error - missing position parameter"; };
	if(isnil "_type") then { _type = "all";};

	{
		if(getdammage _x == 0) then {
			_index = 0;
			while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
				_position = _x buildingPos _index;
				switch (_type) do {
					case "top":
						{
							if(_position select 2 > 1) then {
								_arrayofpos = _arrayofpos + [_position];
							};
						};	
					case "bot":
						{
							if(_position select 2 < 1) then {
								_arrayofpos = _arrayofpos + [_position];
							};
						};	
					case "all":
						{
							_arrayofpos = _arrayofpos + [_position];
						};	
				};
				_index = _index + 1;
				sleep 0.05;
			};
		};
	}foreach _buildings;

	_arrayofpos;