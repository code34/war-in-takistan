	// Read the caution sign at base

	if(isnil "wcmotd") then {
		wcmotd = [];
	};
	
	if(count wcmotd == 0) then {
		"Informations of the day" hintC ["No informations"];
	} else {
		"Informations of the day" hintC wcmotd;
	};