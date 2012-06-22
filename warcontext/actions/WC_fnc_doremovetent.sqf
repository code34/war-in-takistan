	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// Remove a personnal respawn tent

	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 8;

	if!(alive player) exitwith {};

	deletevehicle (_this select 0);

	if((wctent getVariable "owner") == name player) then {
		"respawn" setmarkerposlocal [0,0];
	};