	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: server init configuration file

	if (!isServer) exitWith{};

	// INTEGRITY CHECK
	// DIFF betwen server files and client files
	wcgarbage = [] spawn {
		wccfgpatchesoa = ["cadata","halo_test","caanimals","ca_anims","ca_anims_sdr","ca_anims_wmn","ca_anims_e","cabuildings","ca_e","ca_pmc","ca_heads","cadata_particleeffects","ca_dubbing","calanguage","calanguage_missions","ca_modules","ca_missions_ambientcombat","ca_modules_dyno","ca_modules_e","caroads2","caroads_e","carocks_e","casounds","castructures","cafonts","ca_animals2","ca_animals2_anim_config","ca_animals2_chicken","ca_animals2_cow","ca_animals2_dogs","ca_animals2_dogs_fin","ca_animals2_dogs_pastor","ca_animals2_goat","ca_animals2_rabbit","ca_animals2_sheep","ca_animals2_wildboar","ca_anims_char","cabuildings2","ca_dubbingradio_e","ca_missions_e","castructures_e","castructures_e_housea","castructures_e_ind","castructures_e_misc","castructures_e_wall","castructures_pmc","castructures_pmc_buildings","castructures_pmc_misc","caui","caweapons","caweapons_ak","caweapons_colt1911","caweapons_ksvk","caweapons_m107","caweapons_m252_81mm_mortar","caweapons_metis_at_13","caweapons_2b14_82mm_mortar","caweapons_spg9","caweapons_zu23","caweapons_e_ammoboxes","cacharacters","cacharacters_e_head","ca_dubbing_baf","camisc2","camisc","ca_missions_armory2","ca_missions_secops","ca_missions_pmc","warfare2","cawater2","cawater2_seafox","caweapons2","caweapons2_rpg18","caweapons_kord","cacharacters2","cacharacters_e","catracked","caweapons_warfare_weapons","cawheeled","cawheeled_pickup","cawheeled_offroad","caair","camisc3","catracked2","catracked2_2s6m_tunguska","catracked2_t34","catracked2_us_m270mlrs","cawheeled2","cawheeled2_hmmwv_base","cawheeled2_m1114_armored","cawheeled2_hmmwv_ambulance","cawheeled2_m998a2_avenger","cawheeled2_ikarus","cawheeled2_lada","cawheeled2_mtvr","cawheeled2_v3s","cawheeled3","cawheeled3_m1030","cawheeled3_tt650","cawheeled_e","cawheeled_e_atv","cawheeled_e_landrover","cawheeled_pmc","caa10","ca_ah64d","caair2","caair2_c130j","caair2_chukartarget","caair2_f35b","arma2_ka52","caair2_mq9predatorb","caair2_mv22","ca_air2_su25","caair2_uh1y","caair3","caair3_su34","ca_baf","warfarebuildings","camisc_e", "ca_modules_arty","camp_armory_misc","caweapons_baf","caweapons_e","caweapons_pmc","caweapons_pmc_xm8","caair_e","caair_e_ah64d","caair_e_ch_47f","caair_pmc","cacharacters_baf","cacharacters_w_baf","catracked_e","cawheeled_d_baf","caair_baf","catracked_baf"];
		wccfgpatchesserver = [] call WC_fnc_enumcfgpatches;
		wccfgpatches = wccfgpatchesserver - wccfgpatchesoa;
	};

	// All vehicles in bluefor marker are respawnables (arcade mode)
	wcrespawnablevehicles = nearestObjects[getmarkerpos "bluefor",["Air", "LandVehicle"], ((getMarkerSize "bluefor") select 0)];

	// blacklist of faction
	wcblacklistside = [];

	// contain all civilian to init
	wccivilianstoinit = [];

	// index for marker of town
	wcciviltownindex = 0;

	// index of virtual
	wcvirtualindex = 0;

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

	// Delete enemy vehicles without weapons
	{
		if(count (configFile >> "CfgVehicles" >> _x >> "Turrets") == 0) then {
			wcvehicleslistE = wcvehicleslistE - [_x];
		};
	}foreach wcvehicleslistE;

	wcallsides = wceastside + wcresistanceside;

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

	// contain all securised zone
	wcsecurezone = [getmarkerpos "respawn_west"];
	wcsecurezoneindex = 0;

	// exclude mission that contains building not present on map, or in safe zone
	[] call WC_fnc_deletemissioninsafezone;

	// enemy zone size
	wcdistancegrowth = 10;
	wcdistance = 200 + (wclevel * wcdistancegrowth);

	// soldiers fame - start at good
	wcfame = 0.70;

	// begining distance of ambiant life (grow during the game)
	wcambiantdistance = 1500;

	// civilian are friends of everybody at begining
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

	// initialise the index composition
	wccompositionindex = 0;

	// initialise marker index
	wciedindex = 0;
	wccivilcarindex = 0;
	wcnuclearindex = 0;
	wcminefieldindex = 0;
	
	// Patrol wc index marker
	wcpatrolindex = 0;

	// AA index marker
	wcaaindex = 0;

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

	// contains scores of all players
	wcscoreboard = [];
	
	// contains patrol groups wich used wc patrol script
	wcpatrolgroups = [];

	// contains current mission position
	wcmissionposition = [0,0,0];
	
	// contains last mission position
	wclastmissionposition = [0,0,0];

	// contains all town locations
	wcmissionlocations = [];
	wctownlocations = [];
	wcemptylocations = [];

	wcgarbage = [] call WC_fnc_enumvillages;

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

	// contains all aa site position
	wcallaaposition = [];

	// contains all position to send mortar
	wcmortarposition = [];

	// contains all support groups
	wcsupportgroup = [];

	// contains all enemies group that attack defend missions
	wcdefendgroup = [];

	// objective informations
	wcobjectiveindex = 0;
	wcobjective = [-1, objnull, 0, "", ""];	

	// alert threshold
	wcalert = 0;
	wcindexpropagande = 0;
	
	// number of grave at begining
	wcgrave = 0;

	true;