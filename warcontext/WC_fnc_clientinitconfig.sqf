	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: init configuration file
	// -----------------------------------------------
	#include "common.hpp"

	if (!local player) exitWith{};

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

	ace_sys_tracking_markers_enabled = false;

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

	wcplayjumpmove = 0;

	// flag to go through fast time
	wcadvancetodate = nil;

	// personnal vehicle
	wcmyatv = objnull;

	// if autoload we load player weapons
	if(wcautoload == 1) then {
		wclistofweapons = [] call WC_fnc_enumweapons;
	} else {
		wclistofweapons = ["SmokeLauncher","FlareLauncher","M134","TwinVickers","2A72","YakB","GSh23L","GSh302","GSh301","SPG9","GRAD","MLRS","Kostey_photos","Kostey_map_case","Kostey_notebook","CDF_dogtags","Moscow_Bombing_File","Cobalt_File","ItemWatch","ItemCompass","ItemGPS","ItemRadio","ItemMap","EvPhoto","EvMap","EvMoscow","EvKobalt","EvMoney","EvDogTags","BAF_AS50_scoped","BAF_AS50_TWS","BAF_LRR_scoped","BAF_LRR_scoped_W","BAF_NLAW_Launcher","BAF_L85A2_RIS_Holo","BAF_L85A2_UGL_Holo","BAF_L85A2_RIS_SUSAT","BAF_L85A2_UGL_SUSAT","BAF_L85A2_RIS_ACOG","BAF_L85A2_UGL_ACOG","BAF_L85A2_RIS_CWS","BAF_L86A2_ACOG","BAF_L110A1_Aim","BAF_L7A2_GPMG","Sa61_EP1","UZI_EP1","UZI_SD_EP1","revolver_EP1","revolver_gold_EP1","glock17_EP1","M60A4_EP1","Mk_48_DES_EP1","M249_EP1","M249_TWS_EP1","M249_m145_EP1","M24_des_EP1","SVD_des_EP1","SVD_NSPU_EP1","Sa58P_EP1","Sa58V_EP1","Sa58V_RCO_EP1","Sa58V_CCO_EP1","M4A3_CCO_EP1","M4A3_RCO_GL_EP1","Binocular_Vector","AK_74_GL_kobra","AKS_74","AKS_74_NSPU","AKS_74_GOSHAWK","FN_FAL","FN_FAL_ANPVS4","G36C_camo","G36_C_SD_camo","G36A_camo","G36K_camo","MG36_camo","M32_EP1","M79_EP1","Mk13_EP1","LeeEnfield","m107_TWS_EP1","M110_TWS_EP1","M110_NVG_EP1","M14_EP1","m240_scoped_EP1","M47Launcher_EP1","MAAWS","SCAR_L_CQC","SCAR_L_CQC_Holo","SCAR_L_STD_Mk4CQT","SCAR_L_STD_EGLM_RCO","SCAR_L_CQC_EGLM_Holo","SCAR_L_STD_EGLM_TWS","SCAR_L_STD_HOLO","SCAR_L_CQC_CCO_SD","SCAR_H_CQC_CCO","SCAR_H_CQC_CCO_SD","SCAR_H_STD_EGLM_Spect","SCAR_H_LNG_Sniper","SCAR_H_LNG_Sniper_SD","SCAR_H_STD_TWS_SD","AA12_PMC","m8_carbine_pmc","m8_compact_pmc","m8_holo_sd","m8_tws_sd","m8_tws"];
	};

	// if arrowhead
	if(wccombined == 0) then {
		//wcarma2weapons = ["M9","M9SD","Makarov","MakarovSD","M16A2","M16A2GL","m16a4","m16a4_acg","M16A4_GL","M16A4_ACG_GL","M24","M40A3","M240","Mk_48","M249","M4A1","M4A1_Aim","M4A1_Aim_camo","M4SPR","M4A1_RCO_GL","M4A1_AIM_SD_camo","M4A1_HWS_GL_SD_Camo","M4A1_HWS_GL","M4A1_HWS_GL_camo","MP5SD","MP5A5","PK","Pecheneg","SVD","SVD_CAMO","G36C","G36_C_SD_eotech","G36a","G36K","MG36","M136","Javelin","Stinger","RPG7V","Strela","Igla","MetisLauncher","Binocular","Laserdesignator","NVGoggles","WeaponExplosive","AK_47_M","AK_47_S","AKS_GOLD","AK_74","AK_74_GL","AK_107_kobra","AK_107_GL_kobra","AK_107_GL_pso","AK_107_pso","AKS_74_kobra","AKS_74_pso","AKS_74_U","AKS_74_UN_kobra","RPK_74","bizon","bizon_silenced","Colt1911","DMR","ksvk","M1014","m107","Saiga12K","VSS_vintorez","m8_carbine","m8_carbineGL","m8_compact","m8_sharpshooter","m8_SAW","huntingrifle","RPG18","SMAW"];
		//wclistofweapons = [] call WC_fnc_enumweapons;
		//wclistofweapons = wclistofweapons - wcarma2weapons;
	};

	if(wcautoload == 1) then {
		waituntil {format["%1", wccfgpatches] != "any"; };
		waituntil {format["%1", wcvehicleslistW] != "any"; };
		waituntil {format["%1", wcwestside] != "any"; };
	} else {
		wccfgpatches = [];
		wcvehicleslistW = [west] call WC_fnc_enumvehicle;
		wcvehicleslistWarma2 =  ["M1A1","M1A2_TUSK_MG","BMP2_CDF","BMP2_Ambul_CDF","BMP2_HQ_CDF","T72_CDF","ZSU_CDF","HMMWV_M2","HMMWV_TOW","HMMWV_MK19","HMMWV","UAZ_MG_CDF","UAZ_AGS30_CDF","UAZ_CDF","Ural_CDF","UralOpen_CDF","UralRepair_CDF","UralReammo_CDF","UralRefuel_CDF","Ural_ZU23_CDF","BRDM2_CDF","BRDM2_ATGM_CDF","GRAD_CDF","AAV","MLRS","HMMWV_Armored","HMMWV_Ambulance","HMMWV_Avenger","LAV25","LAV25_HQ","MMT_USMC","MTVR","MtvrReammo","MtvrRefuel","MtvrRepair","TowingTractor","M1030","WarfareSalvageTruck_USMC","WarfareSupplyTruck_USMC","WarfareReammoTruck_USMC","WarfareSalvageTruck_CDF","WarfareSupplyTruck_CDF","WarfareReammoTruck_CDF"];
		wcvehicleslistW = wcvehicleslistW - wcvehicleslistWarma2;
		wcwestside = [["USMC","CDF","BIS_TK_GUE","BIS_CZ","BIS_US","BIS_GER","BIS_BAF"],[["USMC","USMC_Soldier"],["USMC","USMC_Soldier_Light"],["USMC","USMC_Soldier2"],["USMC","USMC_Soldier_GL"],["USMC","USMC_Soldier_Officer"],["USMC","USMC_Soldier_SL"],["USMC","USMC_Soldier_TL"],["USMC","USMC_Soldier_LAT"],["USMC","USMC_Soldier_AT"],["USMC","USMC_Soldier_HAT"],["USMC","USMC_Soldier_AA"],["USMC","USMC_Soldier_Medic"],["USMC","USMC_Soldier_AR"],["USMC","USMC_Soldier_MG"],["USMC","USMC_SoldierS_Spotter"],["USMC","USMC_SoldierS_Sniper"],["USMC","USMC_SoldierS_SniperH"],["USMC","USMC_SoldierM_Marksman"],["USMC","USMC_SoldierS"],["USMC","USMC_SoldierS_Engineer"],["USMC","USMC_Soldier_Pilot"],["USMC","USMC_Soldier_Crew"],["USMC","USMC_LHD_Crew_White"],["USMC","USMC_LHD_Crew_Blue"],["USMC","USMC_LHD_Crew_Brown"],["USMC","USMC_LHD_Crew_Green"],["USMC","USMC_LHD_Crew_Red"],["USMC","USMC_LHD_Crew_Purple"],["USMC","USMC_LHD_Crew_Yellow"],["USMC","FR_TL"],["USMC","FR_Commander"],["USMC","FR_R"],["USMC","FR_Marksman"],["USMC","FR_Light"],["USMC","FR_Corpsman"],["USMC","FR_AR"],["USMC","FR_GL"],["USMC","FR_Sapper"],["USMC","FR_AC"],["USMC","FR_Miles"],["USMC","FR_Cooper"],["USMC","FR_Cooper"],["USMC","FR_Sykes"],["USMC","FR_OHara"],["USMC","FR_Rodriguez"],["USMC","FR_Assault_R"],["USMC","FR_Assault_GL"],["CDF","CDF_Soldier"],["CDF","CDF_Soldier_Light"],["CDF","CDF_Soldier_GL"],["CDF","CDF_Soldier_Militia"],["CDF","CDF_Soldier_Medic"],["CDF","CDF_Soldier_Sniper"],["CDF","CDF_Soldier_Spotter"],["CDF","CDF_Soldier_Marksman"],["CDF","CDF_Soldier_RPG"],["CDF","CDF_Soldier_Strela"],["CDF","CDF_Soldier_AR"],["CDF","CDF_Soldier_MG"],["CDF","CDF_Soldier_TL"],["CDF","CDF_Soldier_Officer"],["CDF","CDF_Commander"],["CDF","CDF_Commander"],["CDF","CDF_Soldier_Pilot"],["CDF","CDF_Soldier_Crew"],["CDF","CDF_Soldier_Engineer"],["BIS_TK_GUE","US_Delta_Force_Undercover_Takistani06_EP1"],["BIS_CZ","CZ_Soldier_SL_DES_EP1"],["BIS_CZ","CZ_Soldier_DES_EP1"],["BIS_CZ","CZ_Soldier_B_DES_EP1"],["BIS_CZ","CZ_Soldier_AMG_DES_EP1"],["BIS_CZ","CZ_Soldier_AT_DES_EP1"],["BIS_CZ","CZ_Soldier_MG_DES_EP1"],["BIS_CZ","CZ_Soldier_Office_DES_EP1"],["BIS_CZ","CZ_Soldier_Light_DES_EP1"],["BIS_CZ","CZ_Soldier_Pilot_EP1"],["BIS_CZ","CZ_Soldier_Sniper_EP1"],["BIS_CZ","CZ_Special_Forces_Scout_DES_EP1"],["BIS_CZ","CZ_Special_Forces_MG_DES_EP1"],["BIS_CZ","CZ_Special_Forces_DES_EP1"],["BIS_CZ","CZ_Special_Forces_TL_DES_EP1"],["BIS_CZ","CZ_Special_Forces_GL_DES_EP1"],["BIS_US","US_Soldier_EP1"],["BIS_US","US_Soldier_B_EP1"],["BIS_US","US_Soldier_AMG_EP1"],["BIS_US","US_Soldier_AAR_EP1"],["BIS_US","US_Soldier_AHAT_EP1"],["BIS_US","US_Soldier_AAT_EP1"],["BIS_US","US_Soldier_Light_EP1"],["BIS_US","US_Soldier_GL_EP1"],["BIS_US","US_Soldier_Officer_EP1"],["BIS_US","US_Soldier_SL_EP1"],["BIS_US","US_Soldier_TL_EP1"],["BIS_US","US_Soldier_LAT_EP1"],["BIS_US","US_Soldier_AT_EP1"],["BIS_US","US_Soldier_HAT_EP1"],["BIS_US","US_Soldier_AA_EP1"],["BIS_US","US_Soldier_Medic_EP1"],["BIS_US","US_Soldier_AR_EP1"],["BIS_US","US_Soldier_MG_EP1"],["BIS_US","US_Soldier_Spotter_EP1"],["BIS_US","US_Soldier_Sniper_EP1"],["BIS_US","US_Soldier_Sniper_NV_EP1"],["BIS_US","US_Soldier_SniperH_EP1"],["BIS_US","US_Soldier_Marksman_EP1"],["BIS_US","US_Soldier_Engineer_EP1"],["BIS_US","US_Soldier_Pilot_EP1"],["BIS_US","US_Soldier_Crew_EP1"],["BIS_US","US_Delta_Force_EP1"],["BIS_US","US_Delta_Force_TL_EP1"],["BIS_US","US_Delta_Force_Medic_EP1"],["BIS_US","US_Delta_Force_Assault_EP1"],["BIS_US","US_Delta_Force_SD_EP1"],["BIS_US","US_Delta_Force_MG_EP1"],["BIS_US","US_Delta_Force_AR_EP1"],["BIS_US","US_Delta_Force_Night_EP1"],["BIS_US","US_Delta_Force_Marksman_EP1"],["BIS_US","US_Delta_Force_M14_EP1"],["BIS_US","US_Delta_Force_Air_Controller_EP1"],["BIS_US","US_Pilot_Light_EP1"],["BIS_US","Drake"],["BIS_US","Herrera"],["BIS_US","Pierce"],["BIS_US","Graves"],["BIS_US","Drake_Light"],["BIS_US","Herrera_Light"],["BIS_US","Pierce_Light"],["BIS_US","Graves_Light"],["BIS_GER","GER_Soldier_EP1"],["BIS_GER","GER_Soldier_Medic_EP1"],["BIS_GER","GER_Soldier_TL_EP1"],["BIS_GER","GER_Soldier_Scout_EP1"],["BIS_GER","GER_Soldier_MG_EP1"],["BIS_BAF","BAF_Soldier_MTP"],["BIS_BAF","BAF_Soldier_DDPM"],["BIS_BAF","BAF_Soldier_GL_MTP"],["BIS_BAF","BAF_Soldier_GL_DDPM"],["BIS_BAF","BAF_Soldier_N_MTP"],["BIS_BAF","BAF_Soldier_N_DDPM"],["BIS_BAF","BAF_Soldier_L_MTP"],["BIS_BAF","BAF_Soldier_L_DDPM"],["BIS_BAF","BAF_ASoldier_MTP"],["BIS_BAF","BAF_ASoldier_DDPM"],["BIS_BAF","BAF_Soldier_AAR_MTP"],["BIS_BAF","BAF_Soldier_AAR_DDPM"],["BIS_BAF","BAF_Soldier_AMG_MTP"],["BIS_BAF","BAF_Soldier_AMG_DDPM"],["BIS_BAF","BAF_Soldier_AAT_MTP"],["BIS_BAF","BAF_Soldier_AAT_DDPM"],["BIS_BAF","BAF_Soldier_AHAT_MTP"],["BIS_BAF","BAF_Soldier_AHAT_DDPM"],["BIS_BAF","BAF_Soldier_AAA_MTP"],["BIS_BAF","BAF_Soldier_AAA_DDPM"],["BIS_BAF","BAF_Soldier_Officer_MTP"],["BIS_BAF","BAF_Soldier_Officer_DDPM"],["BIS_BAF","BAF_Soldier_SL_MTP"],["BIS_BAF","BAF_Soldier_SL_DDPM"],["BIS_BAF","BAF_Soldier_TL_MTP"],["BIS_BAF","BAF_Soldier_TL_DDPM"],["BIS_BAF","BAF_Soldier_AR_MTP"],["BIS_BAF","BAF_Soldier_AR_DDPM"],["BIS_BAF","BAF_Soldier_MG_MTP"],["BIS_BAF","BAF_Soldier_MG_DDPM"],["BIS_BAF","BAF_Soldier_AT_MTP"],["BIS_BAF","BAF_Soldier_AT_DDPM"],["BIS_BAF","BAF_Soldier_HAT_MTP"],["BIS_BAF","BAF_Soldier_HAT_DDPM"],["BIS_BAF","BAF_Soldier_AA_MTP"],["BIS_BAF","BAF_Soldier_AA_DDPM"],["BIS_BAF","BAF_Soldier_Marksman_MTP"],["BIS_BAF","BAF_Soldier_Marksman_DDPM"],["BIS_BAF","BAF_Soldier_scout_MTP"],["BIS_BAF","BAF_Soldier_scout_DDPM"],["BIS_BAF","BAF_Soldier_Sniper_MTP"],["BIS_BAF","BAF_Soldier_SniperH_MTP"],["BIS_BAF","BAF_Soldier_SniperN_MTP"],["BIS_BAF","BAF_Soldier_spotter_MTP"],["BIS_BAF","BAF_Soldier_spotterN_MTP"],["BIS_BAF","BAF_Pilot_MTP"],["BIS_BAF","BAF_Pilot_DDPM"],["BIS_BAF","BAF_crewman_MTP"],["BIS_BAF","BAF_crewman_DDPM"],["BIS_BAF","BAF_Soldier_Medic_MTP"],["BIS_BAF","BAF_Soldier_Medic_DDPM"],["BIS_BAF","BAF_Soldier_FAC_MTP"],["BIS_BAF","BAF_Soldier_FAC_DDPM"],["BIS_BAF","BAF_Soldier_EN_MTP"],["BIS_BAF","BAF_Soldier_EN_DDPM"],["BIS_BAF","BAF_Soldier_W"],["BIS_BAF","BAF_Soldier_GL_W"],["BIS_BAF","BAF_Soldier_N_W"],["BIS_BAF","BAF_Soldier_L_W"],["BIS_BAF","BAF_ASoldier_W"],["BIS_BAF","BAF_Soldier_AAR_W"],["BIS_BAF","BAF_Soldier_AMG_W"],["BIS_BAF","BAF_Soldier_AAT_W"],["BIS_BAF","BAF_Soldier_AHAT_W"],["BIS_BAF","BAF_Soldier_AAA_W"],["BIS_BAF","BAF_Soldier_Officer_W"],["BIS_BAF","BAF_Soldier_SL_W"],["BIS_BAF","BAF_Soldier_TL_W"],["BIS_BAF","BAF_Soldier_AR_W"],["BIS_BAF","BAF_Soldier_MG_W"],["BIS_BAF","BAF_Soldier_AT_W"],["BIS_BAF","BAF_Soldier_HAT_W"],["BIS_BAF","BAF_Soldier_AA_W"],["BIS_BAF","BAF_Soldier_Marksman_W"],["BIS_BAF","BAF_Soldier_scout_W"],["BIS_BAF","BAF_Soldier_Sniper_W"],["BIS_BAF","BAF_Soldier_SniperH_W"],["BIS_BAF","BAF_Soldier_SniperN_W"],["BIS_BAF","BAF_Soldier_spotter_W"],["BIS_BAF","BAF_Soldier_spotterN_W"],["BIS_BAF","BAF_Pilot_W"],["BIS_BAF","BAF_creWman_W"],["BIS_BAF","BAF_Soldier_Medic_W"],["BIS_BAF","BAF_Soldier_FAC_W"],["BIS_BAF","BAF_Soldier_EN_W"]]];
	};

	true;