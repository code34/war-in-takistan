	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Main intro over the base
	// -----------------------------------------------

	private ["_vehicle"];

	_vehicle = (nearestObjects [getmarkerpos "respawn_west", ["Land_Ind_Oil_Pump_EP1"], 15000]) call BIS_fnc_selectRandom;
	if(isnull _vehicle) then {
		_vehicle = player;
	};

	switch(tolower(worldname)) do {
		case "isoladicapraia": {
			playMusic "CAPRI1";
		};

		default {
			playMusic "intro";
		};
	};

	waituntil {preloadCamera position anim};
	waituntil {preloadCamera position _vehicle};
	waituntil {preloadCamera position imam};

	wccam = "camera" camCreate [0,0,1000];
	wccam cameraEffect ["internal","back"];
	ShowCinemaBorder true;
	
	wccam camsettarget player;
	wccam camsetrelpos [300, 300, 80];
	wccam CamCommit 0;
	
	2 cutRsc ["arma2oasplash", "PLAIN"]; 

	wccam camsetrelpos [150, 150, 45];
	wccam CamCommit 10;
	sleep 6;

	wccam camsettarget anim;
	wccam camsetrelpos [3, 1, 1.65];
	wccam CamCommit 0;
	wccam camsetrelpos [-2, 2, 1.65];
	wccam CamCommit 16;
	sleep 6;
	
	wccam camsettarget _vehicle;
	wccam camsetrelpos [100, 100, 40];
	wccam CamCommit 0;
	TitleRsc ["TitreMission","Plain",2];
	wccam camsetrelpos [50, 50, 10];
	wccam CamCommit 16;
	sleep 6;
	
	wccam cameraEffect ["internal","back"];
	wccam camsettarget imam;
	wccam camsetrelpos [0.4, 0.6, 1.65];
	wccam CamCommit 0;
	imam setmimic "smile";

	TitleRsc ["Titrecredits","Plain",2];
	wccam camsetrelpos [2, 1, 1.65];
	wccam CamCommit 10;
	sleep 6;
	
	wccam cameraEffect ["terminate","back"];
	camDestroy wccam;

	wccam = objNull;