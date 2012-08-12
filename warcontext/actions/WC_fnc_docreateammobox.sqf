	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  Create an ammobox near player position
	// -----------------------------------------------

	_crate = nearestObjects[player,["TKVehicleBox_EP1"], 80];

	if(count _crate > 0) exitwith {};

	["Build an ammocrate", "Wait while the building of ammocrate", "The ammocrate will appear near you in few seconds.", 3] spawn WC_fnc_playerhint;
	sleep 3;

	_position = (position player) findemptyposition [10, 300];
	if(count _position == 0) then {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CREATE AMMOBOX";
	};

	wcgarbage = [_position, "base"] spawn WC_fnc_createammobox;