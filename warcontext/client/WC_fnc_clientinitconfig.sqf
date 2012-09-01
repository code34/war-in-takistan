	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: client init configuration file

	if (!local player) exitWith{};

	// set view & grid
	setTerrainGrid wcterraingrid;
	setViewDistance wcviewdist;

	// turn off ao marker
	setGroupIconsVisible [false, false];

	// set environment sound with lobby parameter
	if(wcwithenvironment == 0) then { enableEnvironment false;};

	// turn off ace marker system
	ace_sys_tracking_markers_enabled = false;

	// -------------------------------------------
	// don't edit below init of working variables
	// -------------------------------------------

	wccamnvg = true;

	wccam = objNull;

	wcanim = "";

	wcplayerside = west;

	wcammoboxindex = 0;

	wcobjectiveindex = -1;

	wcammoused = 1;

	wcnumberofkill = 0;

	wcmissionokW = "";

	wcplayers = [];

	wcteamscore = 0;

	wccountoftk = 0;

	player setvariable ["deadmarker", false, true];

	wcbonus = 0;

	wcrankchanged = false;

	wcadmin = false;

	wcteamplayscore = 0;

	wcdragged = false;

	wcrankactivate = true;

	wccanwriteinfotext = true;

	wcbombingavalaible = 0;

	wcspectate = nil;

	wcbombingsupport = nil;

	wcdetected = false;

	wcplayerinnuclearzone = false;

	wcteamlevel = 5;

	wcindexmusic = 0;

	wcclientlogs = ["Client logs"];

	wclistofweaponsindex = 0;

	// flag use for arcade jump
	wcplayjumpmove = 0;

	// flag to go through fast time
	wcadvancetodate = nil;

	// personnal vehicle
	wcmyatv = objnull;

	// original clothes of player
	wcoriginalclothes = typeof player;

	// if autoload we load player weapons
	if(wcautoloadweapons == 1) then {
		_listofweapons = [] call WC_fnc_enumweapons;
		wclistofaddonweapons = _listofweapons - wclistofweapons;
	} else {
		wclistofaddonweapons = [];
	};

	true;