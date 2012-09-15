	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Unit hang up

	private [
		"_group",
		"_unit"
		];
	
	_unit = _this select 0;
	_group = group _unit;

	if(side _unit == civilian) then {
		_unit playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';
		removeAllWeapons _unit; 
		_unit stop true;
		_unit setvariable ["civilrole", "arrest", true];
		sleep 120;
		_unit setvariable ["civilrole", "arrest", false];
	} else {
		if(side player == civilian) then {
			_group setBehaviour "AWARE";
			_group setCombatMode "RED";
			_group = creategroup west;
			[player] joinsilent _group;
		} else {
			if(fleeing _unit) then {
				_unit playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';
				removeAllWeapons _unit; 
				_unit stop true;
				_unit setvariable ["civilrole", "arrest", true];
				sleep 120;
				_unit setvariable ["civilrole", "arrest", false];				
			} else {
				_group setBehaviour "AWARE";
				_group setCombatMode "RED";
				_unit dofire player;
			};
		};
	};