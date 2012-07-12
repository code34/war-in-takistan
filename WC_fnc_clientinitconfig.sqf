	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: client init configuration file

	if (!local player) exitWith{};

	// terrain ground details 0(low) - 50(full)
	wcterraingrid = 1;
	setTerrainGrid wcterraingrid;

	// view distance is set by lobby parameter
	wcviewdist = wcviewdistance;
	setViewDistance wcviewdist;

	// turn off ao marker
	setGroupIconsVisible [false, false];

	// set environment sound with lobby parameter
	if(wcwithenvironment == 0) then { enableEnvironment false;};

	// weapons list of ammobox, you can add weapons in this array to add then to main ammobox
	wclistofweapons = ["M9","M9SD","Makarov","MakarovSD","M16A2","M16A2GL","M4A1","PK","SVD","M136","Javelin","Stinger","RPG7V","Strela","Igla","MetisLauncher","Binocular","Laserdesignator","NVGoggles","Colt1911","ksvk","m107","RPG18","AK_47_M","AK_47_S","AK_74","AK_74_GL","AKS_74_kobra","AKS_74_pso","AKS_74_U","RPK_74","m8_carbine","m8_carbineGL","m8_compact","m8_sharpshooter","m8_SAW","Kostey_photos","Kostey_map_case","Moscow_Bombing_File","Cobalt_File","ItemWatch","ItemCompass","ItemGPS","ItemRadio","ItemMap","EvPhoto","EvMap","EvMoscow","EvKobalt","EvMoney","BAF_AS50_scoped","BAF_AS50_TWS","BAF_LRR_scoped","BAF_LRR_scoped_W","BAF_NLAW_Launcher","BAF_L85A2_RIS_Holo","BAF_L85A2_UGL_Holo","BAF_L85A2_RIS_SUSAT","BAF_L85A2_UGL_SUSAT","BAF_L85A2_RIS_ACOG","BAF_L85A2_UGL_ACOG","BAF_L85A2_RIS_CWS","BAF_L86A2_ACOG","BAF_L110A1_Aim","BAF_L7A2_GPMG","Sa61_EP1","UZI_EP1","UZI_SD_EP1","revolver_EP1","revolver_gold_EP1","glock17_EP1","M60A4_EP1","Mk_48_DES_EP1","M249_EP1","M249_TWS_EP1","M249_m145_EP1","M24_des_EP1","SVD_des_EP1","SVD_NSPU_EP1","Sa58P_EP1","Sa58V_EP1","Sa58V_RCO_EP1","Sa58V_CCO_EP1","M4A3_CCO_EP1","M4A3_RCO_GL_EP1","Binocular_Vector","AK_74_GL_kobra","AKS_74","AKS_74_NSPU","AKS_74_GOSHAWK","FN_FAL","FN_FAL_ANPVS4","G36C_camo","G36_C_SD_camo","G36A_camo","G36K_camo","MG36_camo","M32_EP1","M79_EP1","Mk13_EP1","LeeEnfield","m107_TWS_EP1","M110_TWS_EP1","M110_NVG_EP1","M14_EP1","m240_scoped_EP1","M47Launcher_EP1","MAAWS","SCAR_L_CQC","SCAR_L_CQC_Holo","SCAR_L_STD_Mk4CQT","SCAR_L_STD_EGLM_RCO","SCAR_L_CQC_EGLM_Holo","SCAR_L_STD_EGLM_TWS","SCAR_L_STD_HOLO","SCAR_L_CQC_CCO_SD","SCAR_H_CQC_CCO","SCAR_H_CQC_CCO_SD","SCAR_H_STD_EGLM_Spect","SCAR_H_LNG_Sniper","SCAR_H_LNG_Sniper_SD","SCAR_H_STD_TWS_SD","AA12_PMC","m8_carbine_pmc","m8_compact_pmc","m8_holo_sd","m8_tws_sd","m8_tws"];

	// turn off ace marker system
	ace_sys_tracking_markers_enabled = false;

	// -------------------------------------------
	// don't edit below init of working variables
	// -------------------------------------------

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