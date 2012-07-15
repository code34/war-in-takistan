	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Unit hang up

	private [
		"_unit"
		];
	
	_unit = _this select 0;

	_unit playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';
	removeAllWeapons _unit; 
	dostop _unit;
