	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  hint alti meter
	// -----------------------------------------------


	while { (getposatl player) select 2 > 10 } do {
		hintsilent format ["Alt: %1 Meters", round ((getposatl player) select 2)];
		sleep 0.1;
	}; 
	hintsilent "";