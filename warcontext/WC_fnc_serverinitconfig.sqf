	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: init configuration file
	// -----------------------------------------------
	#include "common.hpp"

	if (!isServer) exitWith{};

	private ["_countofobject", "_y", "_x", "_lastpos", "_sizeofzone"];

	[] spawn {
		wccfgpatchesoa = ["cadata","halo_test","caanimals","ca_anims","ca_anims_sdr","ca_anims_wmn","ca_anims_e","cabuildings","ca_e","ca_pmc","ca_heads","cadata_particleeffects","ca_dubbing","calanguage","calanguage_missions","ca_modules","ca_missions_ambientcombat","ca_modules_dyno","ca_modules_e","caroads2","caroads_e","carocks_e","casounds","castructures","cafonts","ca_animals2","ca_animals2_anim_config","ca_animals2_chicken","ca_animals2_cow","ca_animals2_dogs","ca_animals2_dogs_fin","ca_animals2_dogs_pastor","ca_animals2_goat","ca_animals2_rabbit","ca_animals2_sheep","ca_animals2_wildboar","ca_anims_char","cabuildings2","ca_dubbingradio_e","ca_missions_e","castructures_e","castructures_e_housea","castructures_e_ind","castructures_e_misc","castructures_e_wall","castructures_pmc","castructures_pmc_buildings","castructures_pmc_misc","caui","caweapons","caweapons_ak","caweapons_colt1911","caweapons_ksvk","caweapons_m107","caweapons_m252_81mm_mortar","caweapons_metis_at_13","caweapons_2b14_82mm_mortar","caweapons_spg9","caweapons_zu23","caweapons_e_ammoboxes","cacharacters","cacharacters_e_head","ca_dubbing_baf","camisc2","camisc","ca_missions_armory2","ca_missions_secops","ca_missions_pmc","warfare2","cawater2","cawater2_seafox","caweapons2","caweapons2_rpg18","caweapons_kord","cacharacters2","cacharacters_e","catracked","caweapons_warfare_weapons","cawheeled","cawheeled_pickup","cawheeled_offroad","caair","camisc3","catracked2","catracked2_2s6m_tunguska","catracked2_t34","catracked2_us_m270mlrs","cawheeled2","cawheeled2_hmmwv_base","cawheeled2_m1114_armored","cawheeled2_hmmwv_ambulance","cawheeled2_m998a2_avenger","cawheeled2_ikarus","cawheeled2_lada","cawheeled2_mtvr","cawheeled2_v3s","cawheeled3","cawheeled3_m1030","cawheeled3_tt650","cawheeled_e","cawheeled_e_atv","cawheeled_e_landrover","cawheeled_pmc","caa10","ca_ah64d","caair2","caair2_c130j","caair2_chukartarget","caair2_f35b","arma2_ka52","caair2_mq9predatorb","caair2_mv22","ca_air2_su25","caair2_uh1y","caair3","caair3_su34","ca_baf","warfarebuildings","camisc_e", "ca_modules_arty","camp_armory_misc","caweapons_baf","caweapons_e","caweapons_pmc","caweapons_pmc_xm8","caair_e","caair_e_ah64d","caair_e_ch_47f","caair_pmc","cacharacters_baf","cacharacters_w_baf","catracked_e","cawheeled_d_baf","caair_baf","catracked_baf"];
		wccfgpatchesserver = [] call WC_fnc_enumcfgpatches;
		wccfgpatches = wccfgpatchesserver - wccfgpatchesoa;
	};

	// All vehicles that are respawnables (arcade mode)
	wcrespawnablevehicles = nearestObjects[getmarkerpos "bluefor",["Air", "LandVehicle"], 200];

	// blacklist of faction
	wcblacklistside = [];

	// contain all civilian to init
	wccivilianstoinit = [];

	// index for marker of town
	wcciviltownindex = 0;

	// grave type - arrowhead content
	wcgravetype = ["gravecross2_EP1", "GraveCrossHelmet_EP1"];

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

	// soldiers fame - start at good
	wcfame = 0.70;

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

	// contain last mission position
	wclastmissionposition = [0,0,0];

	// contains all town locations
	wcmissionlocations = [];
	wczonelocations = [];
	wctownlocations = [];
	wcemptylocations = [];
	_lastpos = [0,0];

	_sizeofzone = 300;
	_y = (wcmapbottomleft select 1);
	while { _y < (wcmaptopright select 1) } do {
		for "_x" from (wcmapbottomleft select 0) to (wcmaptopright select 0) step _sizeofzone do {
			_temp = [_x, _y];
			_countofobject = count (nearestObjects [_temp, ["House"] , (_sizeofzone / 2)]);

			if((_temp distance getmarkerpos "respawn_west" > (_sizeofzone * 2)) && (_lastpos distance _temp > (_sizeofzone * 2))) then {
				if (_countofobject > wcminimunbuildings) then {
					wctownlocations = wctownlocations + [createLocation ["NameCity", _temp, (_sizeofzone / 2), (_sizeofzone / 2)]];
					wczonelocations = wczonelocations + [_temp];
					_lastpos = _temp;
				} else {
					if!(surfaceIsWater _temp) then {
						wcemptylocations = wcemptylocations + [_temp];
					};
				};
			};
		};
		_y = _y + _sizeofzone;
	};

	if(wccomputedvillages > 0) then {
		for "_x" from 1 to wccomputedvillages step 1 do {
			_temp = wcemptylocations call BIS_fnc_selectRandom;
			wcemptylocations = wcemptylocations - [_temp];
			wctownlocations = wctownlocations + [createLocation ["NameCity", _temp, (_sizeofzone / 2), (_sizeofzone / 2)]];
			wczonelocations = wczonelocations + [_temp];
		};
	};

	// max of towns
	if (count wctownlocations > wccomputedzones) then {
		while { count wctownlocations > wccomputedzones } do {
			_temp = wctownlocations call BIS_fnc_selectRandom;
			wctownlocations = wctownlocations - [_temp];
			wczonelocations = wczonelocations - [_temp];
		};
	};

	diag_log format ["WARCONTEXT: COMPUTING %1 ZONES", count wctownlocations];

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

	civilian setFriend [east, 1];
	civilian setFriend [resistance, 1];

	true;