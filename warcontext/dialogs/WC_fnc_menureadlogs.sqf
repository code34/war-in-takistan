	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a logs dialog box
	// locality : client side

	if!(wcadmin) then {
		ctrlEnable [15005, false];
		ctrlEnable [15006, false];
		ctrlEnable [15007, false];
		ctrlEnable [15008, false];
		ctrlEnable [15009, false];
		ctrlEnable [15010, false];
	};

	if(wcbombingavalaible != 1) then {
		ctrlEnable [15009, false];
	};


	{
		lbAdd [15003, _x];
	}foreach wcclientlogs;