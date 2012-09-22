	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Unit hang up

	private [
		"_group",
		"_unit"
		];
	
	_unit = _this select 0;
	_group = group _unit;

	player sidechat format["%1: Put your hands up", name player];
	if(side _unit == civilian) then {
		player sidechat format["%1: Do not make me wrong", name _unit];
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
			if((fleeing _unit) or (count units(group _unit) == 1) or (damage _unit > 0.8)) then {
				sleep 1;
				player sidechat format["%1 : Don't shoot. I surrender.", name _unit];
				_unit playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';
				removeAllWeapons _unit; 
				_unit stop true;
				_unit setvariable ["civilrole", "arrest", true];
				sleep 120;
				_unit setvariable ["civilrole", "arrest", false];				
			} else {
				sleep 1;
				player sidechat format["%1 : I never surrend", name _unit];
				_group setBehaviour "AWARE";
				_group setCombatMode "RED";
				_unit dofire player;
			};
		};
	};