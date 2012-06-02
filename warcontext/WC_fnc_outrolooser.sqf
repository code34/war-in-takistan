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

	player setpos [0,0,0];
	playMusic "outro";

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