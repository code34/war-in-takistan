	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  hint alti meter
	// -----------------------------------------------

	_object = _this select 0;

	while { (getposatl _obect) select 2 > 10 } do {
		hintsilent format ["Alt: %1 Meters", round ((getposatl _object) select 2)];
		sleep 0.1;
	}; 
	hintsilent "";