	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - camera focus on object
	// -----------------------------------------------

	private [
		"_cam",
		"_grave"
	];

	waituntil {isnull wccam};
	waituntil {!(player getvariable "deadmarker")};

	player setVehicleInit "this allowdammage true;";
	processInitCommands;

	_cam = "camera" camCreate [0,0,1000];
	_cam cameraEffect ["internal","back"];
	ShowCinemaBorder true;

	playMusic "outro";

	_position = (getmarkerpos "respawn_west") findEmptyPosition [10, 200];
	if(count _position == 0) then {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR PLAYER OUTRO";
		player setpos wcmapcenter;
	} else {
		player setpos _position;
	};

	while { true } do {	
		_grave = nearestObjects[getmarkerpos "mortuary",[["gravecross2", "GraveCrossHelmet"] call BIS_fnc_selectRandom], 200];
		_cam camsettarget position (_grave call BIS_fnc_selectRandom);
		_cam camsetrelpos [0, -4, 1];
		_cam CamCommit 8;
		sleep 8;
		TitleRsc ["LooseMission","Plain",2];
		_cam camsetrelpos [0, -4, 1];
		_cam CamCommit 0;
		sleep 4;
	};

	wccam = objNull;