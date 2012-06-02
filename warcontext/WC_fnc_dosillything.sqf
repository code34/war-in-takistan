	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - IA do silly thing

	private [
		"_unit", 
		"_moves", 
		"_count", 
		"_enemys"
	];

	_unit = _this select 0;

	_moves = [
		"AmovPercMstpSnonWnonDnon_idle56kliky", 
		"AmovPercMstpSnonWnonDnon_idle68boxing", 
		"AmovPercMstpSnonWnonDnon_idle69drepy", 
		"AmovPercMstpSnonWnonDnon_idle70chozeniPoRukou", 
		"AmovPercMstpSnonWnonDnon_idle71kliky", 
		"AmovPercMstpSnonWnonDnon_idle72lehSedy",
		"AidlPpneMstpSnonWnonDnon_SleepC_killFly",
		"AmovPercMstpSnonWnonDnon_idle71kliky",
		"CtsPercMstpSnonWnonDnon_idle33rejpaniVzadku",
		"CtsPercMstpSnonWnonDnon_idle31rejpaniVnose",
		"CtsPercMstpSnonWnonDnon_idle32podrbaniNanose",
		"ActsPercMstpSnonWnonDnon_DancingDuoStefan",
		"ActsPercMstpSnonWnonDnon_talking04",
		"ActsPercMstpSnonWnonDnon_talking03",
		"ActsPercMstpSnonWnonDnon_talking02"
	];

	while { (alive _unit) } do {
		if(wcalert < 10) then {
			if(random 1 > 0.9) then {
				_unit playmovenow (_moves call BIS_fnc_selectRandom);
			};
		};
		sleep (30 + random 30);
	};