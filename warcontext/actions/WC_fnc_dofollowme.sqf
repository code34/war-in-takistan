	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - follow me - action script for AI follow players

	private [
		"_unit", 
		"_leader", 
		"_maxsize", 
		"_ingroup", 
		"_group"
		];
	
	_unit = _this select 0;
	_leader = _this select 1;	

	_unit setVehicleInit "this enableAI ""Move"";";
	processInitCommands;

	_unit dowatch position _leader;

	if!(leader _leader == _leader) then {
		_group = creategroup west;
		[_leader] joinsilent _group;
	} else {
		_group = group _leader;
	};

	[_unit] joinSilent _group;
	_group selectLeader _leader;
	_unit setvariable ["wchostage", false, true];	

	_ingroup = true;
	while { _ingroup } do {
		if(count(units(group _unit)) > 1) then { _ingroup = true; } else { _ingroup = false;};
		if(vehicle _unit == _unit) then {
			if(_unit distance _leader < 150) then {
				_unit dofollow _leader;
			} else {
				dostop _unit;
			};
			if(_unit distance _leader > 15) then {
				_building = nearestObjects [_unit, ["House"], 10];
				if(count _building > 0) then {
					if((getposatl _leader) distance _unit < 300) then {
						_unit setposatl getposatl _leader;
					};
				};
			};
		};
		sleep 10;
	};