	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: init configuration file
	// -----------------------------------------------
	#include "common.hpp"

	if (!isServer) exitWith{};

	[] spawn {
		if(wcautoload == 1) then {
			wccfgpatches = [] call WC_fnc_enumcfgpatches;
			publicvariable "wccfgpatches";
		};
	};

	// All vehicles that are respawnables (arcade mode)
	wcrespawnablevehicles = nearestObjects[getmarkerpos "bluefor",["Air", "LandVehicle"], 200];

	// blacklist of faction
	wcblacklistside = [];

	// array of player name intizialited
	wcplayerready = [];

	// Lobby Parameters
	setDate [2011, 7, 1, 12, 0];
	wcdate = date;

	if (wcwithrussian == 0) then {
		wcblacklistside = wcblacklistside + ["RU", "INS", "GUE"];
	};

	if (wcwithtakistan == 0) then {
		wcblacklistside = wcblacklistside + ["BIS_TK_INS", "BIS_TK", "BIS_TK_GUE", "BIS_UN"];
	};


	{
		if(count (configFile >> "CfgVehicles" >> _x >> "Turrets") == 0) then {
			wcvehicleslistE = wcvehicleslistE - [_x];
		};
	}foreach wcvehicleslistE;

	wcallsides = wceastside + wcresistanceside;
	wccivilwithoutweapons = ["TK_CIV_Woman01_EP1", "TK_CIV_Woman02_EP1", "TK_CIV_Woman03_EP1"];

	// if arrowhead
	if(wccombined == 0) then {
		private ["_temp"];
		_temp = [];
		wcfactionblacklist = ["RU", "INS", "GUE"];
		wcfactionlist = (wcallsides select 0) - wcfactionblacklist;
		{
			if!((_x select 0) in wcfactionblacklist) then {
				_temp = _temp + [_x];
			};
		}foreach (wcallsides select 1);	
		wcallsides = [wcfactionlist, _temp];
	};

	wcfactions = (wcallsides select 0) - wcblacklistside;
	wcclasslist = wcallsides select 1;
	wcvehicleslistEmission = wcvehicleslistE;
	wcsupportfaction = "BIS_TK";

	// if arcade game we exclude some kind of mission (sabotage, steal, rob)  
	if(wckindofgame == 1) then {
		wcmissiondone = [32,33,34,35,36,37,38,53];
	} else {
		wcmissiondone = [];
	};

	if(tolower(worldname) != "takistan") then {
		wcmissiondone = wcmissiondone + [56,58,59,60,61,62,71,63,72,65];
	};

	// exclude mission that contains building not present on map
	if(count(nearestObjects [getmarkerpos "respawn_west", ["Land_Mil_Barracks_i_EP1"], 20000]) == 0) then {
		wcmissiondone = wcmissiondone + [56];
	};

	if(count(nearestObjects [getmarkerpos "respawn_west", ["Land_Mil_hangar_EP1"], 20000]) == 0) then {
		wcmissiondone = wcmissiondone + [58,59,60,61,62,71];
	};

	if(count(nearestObjects [getmarkerpos "respawn_west", ["Land_Ind_Oil_Pump_EP1"], 20000]) == 0) then {
		wcmissiondone = wcmissiondone + [63,72];
	};

	if(count(nearestObjects [getmarkerpos "respawn_west", ["Land_Ind_FuelStation_Feed_EP1"], 20000]) == 0) then {
		wcmissiondone = wcmissiondone + [65];
	};
	
	// enemy zone size
	wcdistancegrowth = 10;
	wcdistance = 200 + (wclevel * wcdistancegrowth);

	// time in secondes before to garbage dead body
	wctimetogarbagedeadbody = 360;

	// soldiers fame
	wcfame = 1;

	// begining distance of ambiant life (grow during the game)
	wcambiantdistance = 1500;

	// probability of nuclear attack at begining of a mission - default 25%
	wcnuclearprobability = 0.85;

	civilian setFriend [west, 1];
	civilian setFriend [east, 1];
	civilian setFriend [resistance, 1];

	// contain all the name of player die once time
	wconelife = [];

	// bonus
	wcbonusfame = 0;
	wcenemyglobalfuel = 1;
	wcenemyglobalelectrical = 1;

	// number of player killed
	wcnumberofkilled = 0;
	wcnumberofkilledofmissionW = 0;
	wcnumberofkilledofmissionE = 0;
	wcnumberofkilledofmissionC = 0;
	wcnumberofkilledofmissionV = 0;

	// threshold of dammage to do, for enemy vehicle explose
	#ifdef _ACE_
		wcdammagethreshold = 0.3;
	#else
		wcdammagethreshold = 0.5;
	#endif

	// initialise the index composition
	wccompositionindex = 0;
	wciedindex = 0;
	wcnuclearindex = 0;
	wcpatrolindex = 0;
	wcdefendzoneindex = 0;
	wcteleportindex = 0;

	// initialise index ambiant
	wcambiantindex = 0;

	// Index markeur merlin
	wcmerlinmrk = 0;

	// init ammoboxindex
	wcammoboxindex = 0;
	
	// init E soldiers flare counter
	wcflarecounter = 0;

	// contains all markers
	wcarraymarker = [];
	wcambiantmarker = [];

	// contain scores of all players
	wcscoreboard = [];

	// contain all securised zone
	wcsecurezone = [getmarkerpos "respawn_west"];
	wcsecurezoneindex = 0;

	// contains all town locations
	wcmissionlocations = [];
	wctownlocations = nearestLocations [[7000,7000], ["NameCityCapital", "NameCity","NameVillage", "Name"], 20000];
	wchilllocations = nearestLocations [[7000,7000], ["Hill", "ViewPoint", "Mount", "NameLocal"], 20000];
	sleep 2;

	while { (count wchilllocations) > (count wctownlocations / 1.3) } do {
		wchilllocations = wchilllocations - [(wchilllocations call BIS_fnc_selectRandom)];
	};

	wctownlocations = wctownlocations + wchilllocations;

	{
		if(surfaceIsWater (position _x)) then {
			wctownlocations = wctownlocations - [_x];
		};
	}foreach wctownlocations;
	diag_log format ["WARCONTEXT: COMPUTING %1 ZONES", count wctownlocations];


	wczonelocations = [];

	for "_i" from 1 to 100 do {
		_temp = [wcmaptopright, wcmapbottomleft, "onground"] call WC_fnc_createposition;
		while { _temp distance getmarkerpos "respawn_west" < 1000} do {
			_temp = [wcmaptopright, wcmapbottomleft, "onground"] call WC_fnc_createposition;
		};
		wczonelocations = wczonelocations + [_temp];
	};

	wctownlocationsneartarget = [];
	wctownwithbunker = [];

	// contains all units, and vehicles enemy
	wcunits = [];
	wcsentinelle = [];
	wcvehicles = [];
	wcambiantlife = [];
	wcobjecttodelete = [];
	wcsabotagelist = [];
	wcpropagander = [];

	// Used at the end of mission to add 1 level
	wcleveltoadd = 0;

	// score initialisation
	wcteamscore = 0;

	// ups initialisation
	wcblinde = [];

	// guerilla ammobox
	wcammobox = [];

	// contains all buildin mission
	wclistofmissions = [];

	wcobjectiveindex = 0;

	// civilian are enemy
	//civilian setFriend [west, 0];

	// detection
	wcalert = 0;
	wcindexpropagande = 0;
	

	// number of grave at begining
	wcgrave = 0;

	true;