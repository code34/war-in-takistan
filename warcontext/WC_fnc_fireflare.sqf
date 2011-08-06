	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext -  Fire flare
	// -----------------------------------------------

	private ["_unit", "_mags", "_enemys", "_target"];

	_unit = _this select 0;
	_mags = _this select 1;

	while { alive _unit } do {
		if((date select 3 < 4) or (date select 3 > 20)) then {
			if(wcalert > 70) then {		
				_target = nil;
				_enemys = nearestObjects[_unit,["Man"], 300];
				{
					if(isplayer _x) then {
						_target = _x;
					};
				}foreach _enemys;
				if(!(isnil "_target") and (wcflarecounter < 4)) then {
					_unit addMagazine (_mags select 2);
					_unit selectWeapon (_mags select 1);
					_unit dowatch position _target;
					_unit dotarget _target;
					sleep 2;
					_unit fire [(_mags select 1), (_mags select 1), (_mags select 2)];
					wcflarecounter = wcflarecounter  + 1;
				};
			};
			sleep 15;
			if(wcflarecounter > 1) then {
				wcflarecounter = wcflarecounter - 1;
			};
		} else {
			sleep 15;
		};
	};
	