	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext : heal other player when not medic
	// -----------------------------------------------

	 private [
		"_unit"
	];

	_unit = ((_this select 3) select 0);

	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 4;
	_unit setDamage 0;