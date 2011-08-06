	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext -  Create a teleport hq near zone
	// -----------------------------------------------
	
	private [
		"_position"
	];

	["Build a vehicle", "Wait while the building of ATV", "The ATV will appear near you in few seconds. Older one will be delete.", 3] spawn WC_fnc_playerhint;

	sleep 10;

	_position = (position player) findemptyposition [5, 30];

	deletevehicle wcmyatv;
	wcmyatv = "ATV_US_EP1" createVehicle _position;

	