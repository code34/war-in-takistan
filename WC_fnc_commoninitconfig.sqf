	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: init configuration file share between server and client

	// wit version
	wcversion	= 1.60;

	// friendly side
	wcside 		=  [west];
	
	// enemy side
	wcenemyside	= [east, resistance];

	// Limit min of fps on server under no more units will be create for support
	wcminfpsonserver = 15;

	// Adress of teamspeak server
	wcteamspeak = "Join me on BIS forum: Code34";

	// put names of team members in array
	// will give same rights as the admin
	// uncomment line below
	// wcteammembers = ["code34", "tom12"];

	// limit of playable map
	switch (tolower(worldname)) do {
		case "gsep_zernovo": {
			wcmaptopright 	= [4100, 4100];
			wcmapbottomleft = [0, 0];
		};

		case "mbg_celle2": {
			wcmaptopright 	= [12800, 12800];
			wcmapbottomleft = [0, 0];
		};

		case "nogova2010": {
			wcmaptopright 	= [12800, 12800];
			wcmapbottomleft = [0, 0];
		};

		case "tropica": {
			wcmaptopright 	= [20500, 20500];
			wcmapbottomleft = [0, 0];
		};

		case "clafghan": {
			wcmaptopright 	= [20500, 20500];
			wcmapbottomleft = [0, 0];
		};

		case "hellskitchen": {
			wcmaptopright 	= [5050, 5050];
			wcmapbottomleft = [0, 0];
		};

		case "isoladicapraia" : {
			wcmaptopright 	= [10000,10000];
			wcmapbottomleft = [0,0];
		};

		case "torabora" : {
			wcmaptopright 	= [10250,10250];
			wcmapbottomleft = [0,0];
		};

		case "tavi" : {
			wcmaptopright 	= [25600,25600];
			wcmapbottomleft = [0,0];
		};

		case "malden2010" : {
			wcmaptopright 	= [12800,12800];
			wcmapbottomleft = [0,0];
		};

		case "everon2010" : {
			wcmaptopright 	= [12800,12800];
			wcmapbottomleft = [0,0];
		};

		case "fallujah" : {
			wcmaptopright 	= [10250,10250];
			wcmapbottomleft = [0,0];
		};

		case "mcn_hazarkot" : {
			wcmaptopright 	= [4800,4800];
			wcmapbottomleft = [0,0];
		};

		case "mcn_aliabad" : {
			wcmaptopright 	= [4800,4800];
			wcmapbottomleft = [0,0];
		};

		case "chernarus" : {
			wcmaptopright 	= [14800,15000];
			wcmapbottomleft = [0,0];
		};

		case "zargabad" : {
			wcmaptopright 	= [5500,8200];
			wcmapbottomleft = [0,0];
		};

		case "panthera2" : {
			wcmaptopright 	= [10200,10200];
			wcmapbottomleft = [0,0];
		};


		case "dingor" : {
			wcmaptopright 	= [10240,10240];
			wcmapbottomleft = [0,0];
		};

		case "lingor" : {
			wcmaptopright 	= [10240,10240];
			wcmapbottomleft = [0,0];
		};

		case "fayshkhabur" : {
			wcmaptopright 	= [20400,20400];
			wcmapbottomleft = [0,0];
		};

		case "esbekistan": {
			wcmaptopright 	= [20500, 20500];
			wcmapbottomleft = [0, 0];
		};

		case "tigeria": {
			wcmaptopright 	= [20500, 20500];
			wcmapbottomleft = [0, 0];
		};

		default {
			// retrieve map ressource
			_x = getNumber (configfile >> "cfgWorlds" >> worldname >> "Grid" >> "offsetX");
			_y = getNumber (configfile >> "cfgWorlds" >> worldname >> "Grid" >> "offsetY");

			if((_x == 0) or (_y ==0)) then {
				wcmaptopright 	= [12800, 12800];
			} else {
				wcmaptopright = [_x, _y];
			};
			wcmapbottomleft = [0, 0];
		};
	};
	
	// Position of map center
	wcmapcenter = [((wcmaptopright select 0) / 2), ((wcmaptopright select 0) / 2)];

	// safe Position where ai, or body can be teleport for wc purpose
	wcinitpos = getmarkerpos "initpos";

	// position where pop enemy sea patrol (left bottom corner)
	wcseainitpos = [400,400,0];

	// Rain max rate of the country - 0  (low) 1 (full)
	wcrainrate = 0.65;

	// mortar spawn percent probability at begin of mission (defaut 20%)
	wcmortarprobability = 0.2;

	// civilian terrorist percent - depending of lobby parameter (by default 20% hostile)
	wcterroristprobability = (wccivilianfame / 100);

	// civilian driver percent (defaut 20%)
	wcciviliandriverprobability = 0.2;

	// player can see marker of others player when they are at max x meters
	wcplayermarkerdist = 2000;

	// weapons list of ammobox, you can add weapons in this array to add then to main ammobox
	wclistofweapons = ["M9","M9SD","Makarov","MakarovSD","M16A2","M16A2GL","M4A1","PK","SVD","M136","Javelin","Stinger","RPG7V","Strela","Igla","MetisLauncher","Binocular","Laserdesignator","NVGoggles","Colt1911","ksvk","m107","RPG18","AK_47_M","AK_47_S","AK_74","AK_74_GL","AKS_74_kobra","AKS_74_pso","AKS_74_U","RPK_74","m8_carbine","m8_carbineGL","m8_compact","m8_sharpshooter","m8_SAW","Kostey_photos","Kostey_map_case","Moscow_Bombing_File","Cobalt_File","ItemWatch","ItemCompass","ItemGPS","ItemRadio","ItemMap","EvPhoto","EvMap","EvMoscow","EvKobalt","EvMoney","BAF_AS50_scoped","BAF_AS50_TWS","BAF_LRR_scoped","BAF_LRR_scoped_W","BAF_NLAW_Launcher","BAF_L85A2_RIS_Holo","BAF_L85A2_UGL_Holo","BAF_L85A2_RIS_SUSAT","BAF_L85A2_UGL_SUSAT","BAF_L85A2_RIS_ACOG","BAF_L85A2_UGL_ACOG","BAF_L85A2_RIS_CWS","BAF_L86A2_ACOG","BAF_L110A1_Aim","BAF_L7A2_GPMG","Sa61_EP1","UZI_EP1","UZI_SD_EP1","revolver_EP1","revolver_gold_EP1","glock17_EP1","M60A4_EP1","Mk_48_DES_EP1","M249_EP1","M249_TWS_EP1","M249_m145_EP1","M24_des_EP1","SVD_des_EP1","SVD_NSPU_EP1","Sa58P_EP1","Sa58V_EP1","Sa58V_RCO_EP1","Sa58V_CCO_EP1","M4A3_CCO_EP1","M4A3_RCO_GL_EP1","Binocular_Vector","AK_74_GL_kobra","AKS_74","AKS_74_NSPU","AKS_74_GOSHAWK","FN_FAL","FN_FAL_ANPVS4","G36C_camo","G36_C_SD_camo","G36A_camo","G36K_camo","MG36_camo","M32_EP1","M79_EP1","Mk13_EP1","LeeEnfield","m107_TWS_EP1","M110_TWS_EP1","M110_NVG_EP1","M14_EP1","m240_scoped_EP1","M47Launcher_EP1","MAAWS","SCAR_L_CQC","SCAR_L_CQC_Holo","SCAR_L_STD_Mk4CQT","SCAR_L_STD_EGLM_RCO","SCAR_L_CQC_EGLM_Holo","SCAR_L_STD_EGLM_TWS","SCAR_L_STD_HOLO","SCAR_L_CQC_CCO_SD","SCAR_H_CQC_CCO","SCAR_H_CQC_CCO_SD","SCAR_H_STD_EGLM_Spect","SCAR_H_LNG_Sniper","SCAR_H_LNG_Sniper_SD","SCAR_H_STD_TWS_SD","AA12_PMC","m8_carbine_pmc","m8_compact_pmc","m8_holo_sd","m8_tws_sd","m8_tws"];
	
	// Kind of engineer
	wcengineerclass = ["AFR_Soldier_Engineer", "ACE_USMC_SoldierS_Engineer_D", "HEXA_Soldier_ISAf", "US_Soldier_Engineer_EP1", "BWMod_EngineerG", "BWMod_EngineerG_Desert", "BWMod_EngineerG_ISAF", "US_Soldier_Engineer_EP1_retex_ger_des", "US_Soldier_Engineer_EP1_retex_ger_wdl", "FR_Sykes", "US_Delta_Force_Night_EP1"];

	// Kind of medics
	wcmedicclass = ["AFR_Soldier_Medic", "ACE_USMC_Soldier_Medic_D", "HEXA_Soldier_ISAF_Medic", "FR_OHara", "USMC_Soldier_Medic", "GER_Soldier_Medic_EP1", "US_Delta_Force_Medic_EP1", "US_Soldier_Medic_EP1", "BWMod_MedicG", "BWMod_MedicG_Desert", "BWMod_MedicG_ISAF", "US_Delta_Force_Medic_EP1_retex_ger_des", "US_Soldier_Medic_EP1_retex_ger_des", "US_Delta_Force_Medic_EP1_retex_ger_wdl", "US_Soldier_Medic_EP1_retex_ger_wdl", "GER_Soldier_Medic_EP1_des", "GER_Soldier_Medic_EP1_wdl", "RU_Soldier_Medic", "Dr_Hladik_EP1"];

	// Kind of civils
	wccivilclass = ["TK_CIV_Takistani01_EP1","TK_CIV_Takistani02_EP1","TK_CIV_Takistani03_EP1","TK_CIV_Takistani04_EP1","TK_CIV_Takistani05_EP1","TK_CIV_Takistani06_EP1","TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1","TK_CIV_Woman01_EP1","TK_CIV_Woman02_EP1","TK_CIV_Woman03_EP1"];

	// civils without weapons
	wccivilwithoutweapons = ["TK_CIV_Woman01_EP1", "TK_CIV_Woman02_EP1", "TK_CIV_Woman03_EP1"];

	// blacklist of units that can pop dynamicly (exclude mission)
	wcblacklistenemyclass = ["TK_Soldier_Crew_EP1", "TK_Aziz_EP1", "TK_Special_Forces_EP1", "TK_Special_Forces_MG_EP1", "TK_Special_Forces_TL_EP1", "TK_Soldier_Pilot_EP1"];

	// blacklist of vehicles that can pop dynamicly (exclude mission)
	wcblacklistenemyvehicleclass = ["BRDM2_ATGM_TK_EP1","GRAD_TK_EP1", "BMP2_HQ_TK_EP1"];
	
	// kind of houses - computed village
	wcvillagehouses = ["Land_House_C_5_V3_EP1", "Land_House_C_5_EP1", "Land_House_L_8_EP1", "Land_House_K_3_EP1", "Land_House_C_5_V1_EP1", "Land_A_Mosque_small_2_EP1", "Land_Wall_L_Mosque_1_EP1", "Land_A_Mosque_small_1_EP1", "Land_House_L_7_EP1", "Land_House_K_5_EP1", "Land_House_K_1_EP1", "Land_House_L_6_EP1", "Land_House_L_9_EP1", "Land_House_L_4_EP1", "Land_House_L_3_EP1", "Land_Wall_L3_5m_EP1"];

	// special forces
	wcspecialforces = ["TK_Special_Forces_EP1"];

	// kind of civil for rescue missions
	wcrescuecivils = ["TK_CIV_Takistani01_EP1", "TK_CIV_Takistani02_EP1", "TK_CIV_Takistani03_EP1", "TK_CIV_Takistani04_EP1", "TK_CIV_Takistani05_EP1", "TK_CIV_Takistani06_EP1", "TK_CIV_Worker01_EP1", "TK_CIV_Worker02_EP1"];

	// kind of units crew of enemies vehicles
	wccrewforces = ["TK_Soldier_Crew_EP1"];

	// kind of dogs
	wcdogclass = ["Fin", "Pastor"];

	// kind of sheep
	wcsheeps = ["Sheep01_EP1", "Sheep02_EP1"];
	
	// kind of ied objects
	wciedobjects = ["Land_transport_crates_EP1", "Land_Misc_Garb_Heap_EP1", "Land_tires_EP1", "Misc_TyreHeapEP1", "Land_Bag_EP1", "Land_Canister_EP1", "Land_Reservoir_EP1", "Land_Wicker_basket_EP1", "Land_Vase_loam_EP1", "Land_bags_stack_EP1", "Land_bags_EP1"];

	// kind of barackment
	wckindofbarracks = ["Land_Mil_Barracks_i_EP1", "Land_Mil_Barracks_i"];

	// kind of airport hangar
	wckindofhangars = ["Land_Mil_hangar_EP1"];

	// kind of control tower
	wckindofcontroltowers = ["Land_Mil_ControlTower_EP1", "Land_Mil_ControlTower"];
	
	// kind of oil pump
	wckindofoilpumps = ["Land_Ind_Oil_Pump_EP1"];

	// kind of fuel station
	wckindoffuelstations = ["Land_Ind_FuelStation_Feed_EP1"];
	
	// anti air vehicles
	wcaavehicles = ["ZU23_TK_GUE_EP1", "Ural_ZU23_TK_GUE_EP1"];

	// vehicles escorted in convoy
	wcconvoyvehicles = ["UralReammo_TK_EP1", "UralRefuel_TK_EP1", "UralRepair_TK_EP1", "UralSalvage_TK_EP1", "UralSupply_TK_EP1"];

	// sea patrol
	wcseapatrol = ["PBX"];

	// kind of enemies backpack
	wcenemybackpack = ["TK_ALICE_Pack_EP1", "TK_RPG_Backpack_EP1", "TK_ALICE_Pack_Explosives_EP1", "TK_ALICE_Pack_AmmoMG_EP1", "TKG_ALICE_Pack_AmmoAK47_EP1", "TKG_ALICE_Pack_AmmoAK74_EP1"];

	// change clothes - player can be civil
	wcchangeclothescivil = ["TK_CIV_Takistani01_EP1", "TK_CIV_Takistani02_EP1", "TK_CIV_Takistani03_EP1", "TK_CIV_Takistani04_EP1", "TK_CIV_Takistani05_EP1", "TK_CIV_Takistani06_EP1", "Dr_Hladik_EP1", "Pilot_EP1", "Haris_Press_EP1"];

	// change clothes - player can be west
	wcchangeclotheswest = ["US_Pilot_Light_EP1"];

	// change clothes - player can be east - add clothes if you want in array
	wcchangeclotheseast = [];

	wcchangeclothes = wcchangeclothescivil + wcchangeclotheswest + wcchangeclotheseast;

	// type of plane
	wcairpatroltype = ["Su39","Su25_TK_EP1", "Mi17_TK_EP1", "Mi24_D_TK_EP1"];

	// kind of radio tower
	wcradiotype = ["TK_WarfareBUAVterminal_EP1"];

	// kind of repair point
	wcrepairpointtype = ["US_WarfareBVehicleServicePoint_Base_EP1", "US_WarfareBVehicleServicePoint_Base"];

	// kind of grave
	wcgravetype = ["gravecross2_EP1", "GraveCrossHelmet_EP1"];

	// terrain ground details 0(full) - 50(low)
	wcterraingrid = 50;

	// default player view distance
	wcviewdist = 1500;

	// alert threshold begin to increase
	// when something happens at ... meters of the mission position
	wcalertzonesize = 3000;

	// Radio appear at x meter distance of goal (min & max)
	wcradiodistminofgoal = 150;
	wcradiodistmaxofgoal = 300;

	// Civils appear at x meter distance of player
	wccivildistancepop = 1000;

	// kind of generator
	wcgeneratortype = ["PowerGenerator_EP1"];

	// Generator appear at distance of goal (min & max)
	wcgeneratordistminofgoal = 150;
	wcgeneratordistmaxofgoal = 300;

	// time in seconds before to garbage dead body
	wctimetogarbagedeadbody = 360;

	// time in seconds before to respawn vehicle
	wctimetorespawnvehicle = 360;

	// probability of nuclear attack at begining of a mission - default 25%
	wcnuclearprobability = 0.85;

	// probability there is a static weapon in bunker - default 30%
	wcstaticinbunkerprobability = 0.3;

	// size of area to detect friendly units leave the zone at end of mission
	wcleaveareasizeatendofmission = 1000;

	// percent of players that must leave the zone at end of mission (by defaut 20%)
	wcleaversatendofmission = 0.2;

	// Simulation mode has a harder scoring system
	if(wckindofgame == 1) then {
		wcscorelimitmin = -80; 
		wcscorelimitmax = 99;
	} else {
		wcscorelimitmin = -20; 
		wcscorelimitmax = 25;
	};

	// threshold of dammage to do, for enemy vehicle been damaged
	// this variable can affect ACE damaged threshold
	if(wcwithACE == 1) then {
		wcdammagethreshold = 0.5;
	} else {
		wcdammagethreshold = 0.45;
	};

	// patrols use  dogs
	wcpatrolwithdogs = true;

	// Goal cam uses color
	wccamgoalwithcolor = true;

	// Goal cam turn around goal
	wccamgoalanimate = false;

	// Ied false positive are off by default
	wciedfalsepositive = false;

	// contain all nuclear zone
	wcnuclearzone = [];

	// counter of day start at ..
	wcday = 1;

	// position of goal zone
	wcselectedzone = [0,0,0];

	// radio is alive or not  
	wcradioalive = true;

	// level start at .. 
	wclevel = 1;

	// IA skill
	if(wckindofgame == 1) then {
		wccivilianskill = 0.1;
		wcskill = 0.38;
		wcskill = wcskill + (wclevel * 0.02);
	} else {
		wccivilianskill = 0.1;
		wcskill = 0.68;
		wcskill = wcskill + (wclevel * 0.02);
	};

	// maximun number of groups in town (depending of wcopposingforce lobby parameter)
	switch (wcopposingforce) do {
		case 1: {
			wclevelmaxincity = 2;
		};

		case 2: {
			wclevelmaxincity = 4;
		};
		
		case 3: {
			wclevelmaxincity = 6;
		};

		case 4: {
			wclevelmaxincity = 8;
		};

		case 5: {
			wclevelmaxincity = 10;
		};
	};

	// number of enemy killed
	wcenemykilled = 0;
	wccivilkilled = 0;

	// count number of mission
	wcmissioncount = 1;

	// array of all players in team
	wcinteam = [];

	// objective informations - don't edit
	wcobjectiveindex = 0;
	wcobjective = [-1, objnull, 0, "", ""];	

	// vehicles avalaible at hq
	wcvehicleslistathq = ["ATV_US_EP1"];

	wccfgpatches = [];

	// autoload troops
	if(wcautoloadtroops == 1) then {
		wceastside = [east] call WC_fnc_enumfaction;
		wcresistanceside = [resistance] call WC_fnc_enumfaction;
		wcwestside = [west] call WC_fnc_enumfaction;
	} else {
		// by default only arrowhead content is supported
		wceastside = [["BIS_TK_INS","BIS_TK"],[["BIS_TK_INS","TK_INS_Soldier_EP1"],["BIS_TK_INS","TK_INS_Soldier_AAT_EP1"],["BIS_TK_INS","TK_INS_Soldier_2_EP1"],["BIS_TK_INS","TK_INS_Soldier_3_EP1"],["BIS_TK_INS","TK_INS_Soldier_4_EP1"],["BIS_TK_INS","TK_INS_Soldier_AA_EP1"],["BIS_TK_INS","TK_INS_Soldier_AT_EP1"],["BIS_TK_INS","TK_INS_Soldier_TL_EP1"],["BIS_TK_INS","TK_INS_Soldier_Sniper_EP1"],["BIS_TK_INS","TK_INS_Soldier_AR_EP1"],["BIS_TK_INS","TK_INS_Soldier_MG_EP1"],["BIS_TK_INS","TK_INS_Bonesetter_EP1"],["BIS_TK_INS","TK_INS_Warlord_EP1"],["BIS_TK","TK_Soldier_EP1"],["BIS_TK","TK_Soldier_GL_EP1"],["BIS_TK","TK_Soldier_B_EP1"],["BIS_TK","TK_Soldier_AAT_EP1"],["BIS_TK","TK_Soldier_AMG_EP1"],["BIS_TK","TK_Soldier_LAT_EP1"],["BIS_TK","TK_Soldier_AT_EP1"],["BIS_TK","TK_Soldier_HAT_EP1"],["BIS_TK","TK_Soldier_AA_EP1"],["BIS_TK","TK_Soldier_Engineer_EP1"],["BIS_TK","TK_Soldier_MG_EP1"],["BIS_TK","TK_Soldier_AR_EP1"],["BIS_TK","TK_Soldier_Medic_EP1"],["BIS_TK","TK_Soldier_SL_EP1"],["BIS_TK","TK_Soldier_Officer_EP1"],["BIS_TK","TK_Soldier_Spotter_EP1"],["BIS_TK","TK_Soldier_Sniper_EP1"],["BIS_TK","TK_Soldier_SniperH_EP1"],["BIS_TK","TK_Soldier_Sniper_Night_EP1"],["BIS_TK","TK_Soldier_Night_1_EP1"],["BIS_TK","TK_Soldier_Night_2_EP1"],["BIS_TK","TK_Soldier_TWS_EP1"],["BIS_TK","TK_Soldier_Crew_EP1"],["BIS_TK","TK_Soldier_Pilot_EP1"],["BIS_TK","TK_Special_Forces_EP1"],["BIS_TK","TK_Special_Forces_TL_EP1"],["BIS_TK","TK_Special_Forces_MG_EP1"],["BIS_TK","TK_Aziz_EP1"],["BIS_TK","TK_Commander_EP1"]]];
		wcresistanceside = [["BIS_TK_GUE","BIS_UN","PMC_BAF"],[["BIS_TK_GUE","TK_GUE_Soldier_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_AAT_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_2_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_3_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_4_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_5_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_AA_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_AT_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_HAT_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_TL_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_Sniper_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_AR_EP1"],["BIS_TK_GUE","TK_GUE_Soldier_MG_EP1"],["BIS_TK_GUE","TK_GUE_Bonesetter_EP1"],["BIS_TK_GUE","TK_GUE_Warlord_EP1"],["BIS_UN","UN_CDF_Soldier_EP1"],["BIS_UN","UN_CDF_Soldier_B_EP1"],["BIS_UN","UN_CDF_Soldier_AAT_EP1"],["BIS_UN","UN_CDF_Soldier_AMG_EP1"],["BIS_UN","UN_CDF_Soldier_AT_EP1"],["BIS_UN","UN_CDF_Soldier_MG_EP1"],["BIS_UN","UN_CDF_Soldier_SL_EP1"],["BIS_UN","UN_CDF_Soldier_Officer_EP1"],["BIS_UN","UN_CDF_Soldier_Guard_EP1"],["BIS_UN","UN_CDF_Soldier_Pilot_EP1"],["BIS_UN","UN_CDF_Soldier_Crew_EP1"],["BIS_UN","UN_CDF_Soldier_Light_EP1"],["PMC_BAF","CIV_Contractor1_BAF"],["PMC_BAF","CIV_Contractor2_BAF"],["PMC_BAF","Soldier_PMC"],["PMC_BAF","Soldier_M4A3_PMC"],["PMC_BAF","Soldier_Engineer_PMC"],["PMC_BAF","Soldier_Crew_PMC"],["PMC_BAF","Soldier_Medic_PMC"],["PMC_BAF","Soldier_TL_PMC"],["PMC_BAF","Soldier_Pilot_PMC"],["PMC_BAF","Soldier_MG_PMC"],["PMC_BAF","Soldier_MG_PKM_PMC"],["PMC_BAF","Soldier_Sniper_PMC"],["PMC_BAF","Soldier_Sniper_KSVK_PMC"],["PMC_BAF","Soldier_GL_PMC"],["PMC_BAF","Soldier_GL_M16A2_PMC"],["PMC_BAF","Soldier_Bodyguard_M4_PMC"],["PMC_BAF","Soldier_Bodyguard_AA12_PMC"],["PMC_BAF","Soldier_AA_PMC"],["PMC_BAF","Soldier_AT_PMC"],["PMC_BAF","Poet_PMC"],["PMC_BAF","Ry_PMC"],["PMC_BAF","Reynolds_PMC"],["PMC_BAF","Tanny_PMC"],["PMC_BAF","Dixon_PMC"]]];
		wcwestside = [["BIS_TK_GUE","BIS_CZ","BIS_US","BIS_GER","BIS_BAF"],[["BIS_TK_GUE","US_Delta_Force_Undercover_Takistani06_EP1"],["BIS_CZ","CZ_Soldier_SL_DES_EP1"],["BIS_CZ","CZ_Soldier_DES_EP1"],["BIS_CZ","CZ_Soldier_B_DES_EP1"],["BIS_CZ","CZ_Soldier_AMG_DES_EP1"],["BIS_CZ","CZ_Soldier_AT_DES_EP1"],["BIS_CZ","CZ_Soldier_MG_DES_EP1"],["BIS_CZ","CZ_Soldier_Office_DES_EP1"],["BIS_CZ","CZ_Soldier_Light_DES_EP1"],["BIS_CZ","CZ_Soldier_Pilot_EP1"],["BIS_CZ","CZ_Soldier_Sniper_EP1"],["BIS_CZ","CZ_Special_Forces_Scout_DES_EP1"],["BIS_CZ","CZ_Special_Forces_MG_DES_EP1"],["BIS_CZ","CZ_Special_Forces_DES_EP1"],["BIS_CZ","CZ_Special_Forces_TL_DES_EP1"],["BIS_CZ","CZ_Special_Forces_GL_DES_EP1"],["BIS_US","US_Soldier_EP1"],["BIS_US","US_Soldier_B_EP1"],["BIS_US","US_Soldier_AMG_EP1"],["BIS_US","US_Soldier_AAR_EP1"],["BIS_US","US_Soldier_AHAT_EP1"],["BIS_US","US_Soldier_AAT_EP1"],["BIS_US","US_Soldier_Light_EP1"],["BIS_US","US_Soldier_GL_EP1"],["BIS_US","US_Soldier_Officer_EP1"],["BIS_US","US_Soldier_SL_EP1"],["BIS_US","US_Soldier_TL_EP1"],["BIS_US","US_Soldier_LAT_EP1"],["BIS_US","US_Soldier_AT_EP1"],["BIS_US","US_Soldier_HAT_EP1"],["BIS_US","US_Soldier_AA_EP1"],["BIS_US","US_Soldier_Medic_EP1"],["BIS_US","US_Soldier_AR_EP1"],["BIS_US","US_Soldier_MG_EP1"],["BIS_US","US_Soldier_Spotter_EP1"],["BIS_US","US_Soldier_Sniper_EP1"],["BIS_US","US_Soldier_Sniper_NV_EP1"],["BIS_US","US_Soldier_SniperH_EP1"],["BIS_US","US_Soldier_Marksman_EP1"],["BIS_US","US_Soldier_Engineer_EP1"],["BIS_US","US_Soldier_Pilot_EP1"],["BIS_US","US_Soldier_Crew_EP1"],["BIS_US","US_Delta_Force_EP1"],["BIS_US","US_Delta_Force_TL_EP1"],["BIS_US","US_Delta_Force_Medic_EP1"],["BIS_US","US_Delta_Force_Assault_EP1"],["BIS_US","US_Delta_Force_SD_EP1"],["BIS_US","US_Delta_Force_MG_EP1"],["BIS_US","US_Delta_Force_AR_EP1"],["BIS_US","US_Delta_Force_Night_EP1"],["BIS_US","US_Delta_Force_Marksman_EP1"],["BIS_US","US_Delta_Force_M14_EP1"],["BIS_US","US_Delta_Force_Air_Controller_EP1"],["BIS_US","US_Pilot_Light_EP1"],["BIS_US","Drake"],["BIS_US","Herrera"],["BIS_US","Pierce"],["BIS_US","Graves"],["BIS_US","Drake_Light"],["BIS_US","Herrera_Light"],["BIS_US","Pierce_Light"],["BIS_US","Graves_Light"],["BIS_GER","GER_Soldier_EP1"],["BIS_GER","GER_Soldier_Medic_EP1"],["BIS_GER","GER_Soldier_TL_EP1"],["BIS_GER","GER_Soldier_Scout_EP1"],["BIS_GER","GER_Soldier_MG_EP1"],["BIS_BAF","BAF_Soldier_MTP"],["BIS_BAF","BAF_Soldier_DDPM"],["BIS_BAF","BAF_Soldier_GL_MTP"],["BIS_BAF","BAF_Soldier_GL_DDPM"],["BIS_BAF","BAF_Soldier_N_MTP"],["BIS_BAF","BAF_Soldier_N_DDPM"],["BIS_BAF","BAF_Soldier_L_MTP"],["BIS_BAF","BAF_Soldier_L_DDPM"],["BIS_BAF","BAF_ASoldier_MTP"],["BIS_BAF","BAF_ASoldier_DDPM"],["BIS_BAF","BAF_Soldier_AAR_MTP"],["BIS_BAF","BAF_Soldier_AAR_DDPM"],["BIS_BAF","BAF_Soldier_AMG_MTP"],["BIS_BAF","BAF_Soldier_AMG_DDPM"],["BIS_BAF","BAF_Soldier_AAT_MTP"],["BIS_BAF","BAF_Soldier_AAT_DDPM"],["BIS_BAF","BAF_Soldier_AHAT_MTP"],["BIS_BAF","BAF_Soldier_AHAT_DDPM"],["BIS_BAF","BAF_Soldier_AAA_MTP"],["BIS_BAF","BAF_Soldier_AAA_DDPM"],["BIS_BAF","BAF_Soldier_Officer_MTP"],["BIS_BAF","BAF_Soldier_Officer_DDPM"],["BIS_BAF","BAF_Soldier_SL_MTP"],["BIS_BAF","BAF_Soldier_SL_DDPM"],["BIS_BAF","BAF_Soldier_TL_MTP"],["BIS_BAF","BAF_Soldier_TL_DDPM"],["BIS_BAF","BAF_Soldier_AR_MTP"],["BIS_BAF","BAF_Soldier_AR_DDPM"],["BIS_BAF","BAF_Soldier_MG_MTP"],["BIS_BAF","BAF_Soldier_MG_DDPM"],["BIS_BAF","BAF_Soldier_AT_MTP"],["BIS_BAF","BAF_Soldier_AT_DDPM"],["BIS_BAF","BAF_Soldier_HAT_MTP"],["BIS_BAF","BAF_Soldier_HAT_DDPM"],["BIS_BAF","BAF_Soldier_AA_MTP"],["BIS_BAF","BAF_Soldier_AA_DDPM"],["BIS_BAF","BAF_Soldier_Marksman_MTP"],["BIS_BAF","BAF_Soldier_Marksman_DDPM"],["BIS_BAF","BAF_Soldier_scout_MTP"],["BIS_BAF","BAF_Soldier_scout_DDPM"],["BIS_BAF","BAF_Soldier_Sniper_MTP"],["BIS_BAF","BAF_Soldier_SniperH_MTP"],["BIS_BAF","BAF_Soldier_SniperN_MTP"],["BIS_BAF","BAF_Soldier_spotter_MTP"],["BIS_BAF","BAF_Soldier_spotterN_MTP"],["BIS_BAF","BAF_Pilot_MTP"],["BIS_BAF","BAF_Pilot_DDPM"],["BIS_BAF","BAF_crewman_MTP"],["BIS_BAF","BAF_crewman_DDPM"],["BIS_BAF","BAF_Soldier_Medic_MTP"],["BIS_BAF","BAF_Soldier_Medic_DDPM"],["BIS_BAF","BAF_Soldier_FAC_MTP"],["BIS_BAF","BAF_Soldier_FAC_DDPM"],["BIS_BAF","BAF_Soldier_EN_MTP"],["BIS_BAF","BAF_Soldier_EN_DDPM"],["BIS_BAF","BAF_Soldier_W"],["BIS_BAF","BAF_Soldier_GL_W"],["BIS_BAF","BAF_Soldier_N_W"],["BIS_BAF","BAF_Soldier_L_W"],["BIS_BAF","BAF_ASoldier_W"],["BIS_BAF","BAF_Soldier_AAR_W"],["BIS_BAF","BAF_Soldier_AMG_W"],["BIS_BAF","BAF_Soldier_AAT_W"],["BIS_BAF","BAF_Soldier_AHAT_W"],["BIS_BAF","BAF_Soldier_AAA_W"],["BIS_BAF","BAF_Soldier_Officer_W"],["BIS_BAF","BAF_Soldier_SL_W"],["BIS_BAF","BAF_Soldier_TL_W"],["BIS_BAF","BAF_Soldier_AR_W"],["BIS_BAF","BAF_Soldier_MG_W"],["BIS_BAF","BAF_Soldier_AT_W"],["BIS_BAF","BAF_Soldier_HAT_W"],["BIS_BAF","BAF_Soldier_AA_W"],["BIS_BAF","BAF_Soldier_Marksman_W"],["BIS_BAF","BAF_Soldier_scout_W"],["BIS_BAF","BAF_Soldier_Sniper_W"],["BIS_BAF","BAF_Soldier_SniperH_W"],["BIS_BAF","BAF_Soldier_SniperN_W"],["BIS_BAF","BAF_Soldier_spotter_W"],["BIS_BAF","BAF_Soldier_spotterN_W"],["BIS_BAF","BAF_Pilot_W"],["BIS_BAF","BAF_creWman_W"],["BIS_BAF","BAF_Soldier_Medic_W"],["BIS_BAF","BAF_Soldier_FAC_W"],["BIS_BAF","BAF_Soldier_EN_W"]]];
	};

	// autoload vehicles
	if(wcautoloadvehicles == 1) then {
		wcvehicleslistE = [east] call WC_fnc_enumvehicle;
		wcvehicleslistC = [civilian] call WC_fnc_enumvehicle;
		wcvehicleslistW = [west] call WC_fnc_enumvehicle;
		wccompositions = [east] call WC_fnc_enumcompositions;
	} else {
		wcvehicleslistE = ["UAZ_MG_TK_EP1","UAZ_AGS30_TK_EP1","UAZ_Unarmed_TK_EP1","UralRepair_TK_EP1","UralReammo_TK_EP1","UralRefuel_TK_EP1","Ural_ZU23_TK_EP1","UralSupply_TK_EP1","UralSalvage_TK_EP1","TT650_TK_EP1","GRAD_TK_EP1","BRDM2_TK_EP1","BRDM2_ATGM_TK_EP1","BTR40_MG_TK_INS_EP1","BTR40_TK_INS_EP1","BTR60_TK_EP1","LandRover_MG_TK_INS_EP1","LandRover_MG_TK_EP1","LandRover_SPG9_TK_INS_EP1","LandRover_SPG9_TK_EP1","Old_bike_TK_INS_EP1","MAZ_543_SCUD_TK_EP1","SUV_TK_EP1","V3S_TK_EP1","V3S_Open_TK_EP1","BMP2_TK_EP1","BMP2_HQ_TK_EP1","T34_TK_EP1","ZSU_TK_EP1","T72_TK_EP1","M113Ambul_TK_EP1","M113_TK_EP1","T55_TK_EP1"];
		wcvehicleslistC = ["UAZ_Unarmed_TK_CIV_EP1","Ural_TK_CIV_EP1","TT650_TK_CIV_EP1","Lada1_TK_CIV_EP1","Lada2_TK_CIV_EP1","Ikarus_TK_CIV_EP1","hilux1_civil_3_open_EP1","LandRover_TK_CIV_EP1","Old_bike_TK_CIV_EP1","Old_moto_TK_Civ_EP1","S1203_TK_CIV_EP1","S1203_ambulance_EP1","SUV_TK_CIV_EP1","Volha_1_TK_CIV_EP1","Volha_2_TK_CIV_EP1","VolhaLimo_TK_CIV_EP1","V3S_Open_TK_CIV_EP1"];
		wcvehicleslistW = ["HMMWV_DES_EP1","HMMWV_MK19_DES_EP1","HMMWV_Ambulance_DES_EP1","HMMWV_Ambulance_CZ_DES_EP1","HMMWV_Avenger_DES_EP1","M1030_US_DES_EP1","MTVR_DES_EP1","MtvrReammo_DES_EP1","MtvrRefuel_DES_EP1","MtvrRepair_DES_EP1","MtvrSupply_DES_EP1","MtvrSalvage_DES_EP1","ATV_US_EP1","ATV_CZ_EP1","HMMWV_M1035_DES_EP1","HMMWV_M1151_M2_CZ_DES_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M998_crows_M2_DES_EP1","HMMWV_M998_crows_MK19_DES_EP1","HMMWV_M998A2_SOV_DES_EP1","HMMWV_TOW_DES_EP1","HMMWV_Terminal_EP1","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","M1130_CV_EP1","M1129_MC_EP1","M1135_ATGMV_EP1","M1128_MGS_EP1","M1133_MEV_EP1","M1A1_US_DES_EP1","M1A2_US_TUSK_MG_EP1","MLRS_DES_EP1","M2A2_EP1","M2A3_EP1","M6_EP1","BAF_ATV_D","BAF_Offroad_D","BAF_Jackal2_L2A1_D","BAF_Jackal2_GMG_D","BAF_ATV_W","BAF_Offroad_W","BAF_Jackal2_L2A1_W","BAF_Jackal2_GMG_W","BAF_FV510_D","BAF_FV510_W"];
		wccompositions = ["MediumTentCamp_TK_EP1","MediumTentCamp2_TK_EP1","MediumTentCamp3_TK_EP1","AntiAir1_TK_EP1","Firebase1_TK_EP1","FuelDump1_TK_EP1","RadarSite1_TK_EP1","VehicleParking1_TK_EP1","HeliParking1_TK_EP1","AirplaneParking1_TK_EP1","WeaponsStore1_TK_EP1","Camp1_TK_EP1","Camp2_TK_EP1","Camp1_TKM_EP1","Camp2_TKM_EP1","FiringRange_Wreck4","FiringRange_Wreck5"];
	};

	wcvehicleslistE = wcvehicleslistE - wcblacklistenemyvehicleclass;
	true;