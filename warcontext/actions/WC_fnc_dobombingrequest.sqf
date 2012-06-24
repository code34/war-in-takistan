	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - call C130 bombing support

	wcbombingrequest = true;
	["wcbombingrequest", "server"] call WC_fnc_publicvariable;
	player removeAction wcbombingsupport;
	wcbombingsupport = nil;	