	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// create an US ammobox on local client side
	// -----------------------------------------------

	#include "common.hpp"

	 private [
		"_base",
		"_crate",
		"_position",
		"_amountWeapon",
		"_amountAmmo",
		"_listofweapons",
		"_refreshTime",
		"_magazines",
		"_weapons",
		"_autoload"
	];

	_position = _this select 0;
	_autoload = _this select 1;

	_crate = "TKVehicleBox_EP1" createVehiclelocal _position;

	clearweaponcargo 	_crate;
	clearmagazinecargo 	_crate;
	_crate setpos _position;
	wcammoboxindex = wcammoboxindex  + 1;
	wcgarbage = [format['wcammobox%1', wcammoboxindex], 0.5, _position, 'ColorYellow', 'ICON', 'FDIAGONAL', 'Select', 0, 'Ammobox', true] call WC_fnc_createmarkerlocal;

	_weapons = [];
	_magazines = [];

	_base = ["M9","M9SD","Makarov","MakarovSD","M16A2","M16A2GL","m16a4","m16a4_acg","M16A4_GL","M16A4_ACG_GL","M24","M40A3","M240","Mk_48","M249","M4A1","M4A1_Aim","M4A1_Aim_camo","M4SPR","M4A1_RCO_GL","M4A1_AIM_SD_camo","M4A1_HWS_GL_SD_Camo","M4A1_HWS_GL","M4A1_HWS_GL_camo","MP5SD","MP5A5","PK","Pecheneg","SVD","SVD_CAMO","G36C","G36_C_SD_eotech","G36a","G36K","MG36","M136","Javelin","Stinger","RPG7V","Strela","Igla","MetisLauncher","Binocular","Laserdesignator","NVGoggles","AK_47_M","AK_47_S","AKS_GOLD","AK_74","AK_74_GL","AK_107_kobra","AK_107_GL_kobra","AK_107_GL_pso","AK_107_pso","AKS_74_kobra","AKS_74_pso","AKS_74_U","AKS_74_UN_kobra","RPK_74","bizon","bizon_silenced","Colt1911","DMR","ksvk","M1014","m107","Saiga12K","VSS_vintorez","m8_carbine","m8_carbineGL","m8_compact","m8_sharpshooter","m8_SAW","huntingrifle","RPG18","SMAW","BAF_AS50_scoped","BAF_AS50_TWS","BAF_LRR_scoped","BAF_LRR_scoped_W","BAF_NLAW_Launcher","BAF_L85A2_RIS_Holo","BAF_L85A2_UGL_Holo","BAF_L85A2_RIS_SUSAT","BAF_L85A2_UGL_SUSAT","BAF_L85A2_RIS_ACOG","BAF_L85A2_UGL_ACOG","BAF_L85A2_RIS_CWS","BAF_L86A2_ACOG","BAF_L110A1_Aim","BAF_L7A2_GPMG","Sa61_EP1","UZI_EP1","UZI_SD_EP1","revolver_EP1","revolver_gold_EP1","glock17_EP1","M60A4_EP1","Mk_48_DES_EP1","M249_EP1","M249_TWS_EP1","M249_m145_EP1","M24_des_EP1","SVD_des_EP1","SVD_NSPU_EP1","Sa58P_EP1","Sa58V_EP1","Sa58V_RCO_EP1","Sa58V_CCO_EP1","M4A3_CCO_EP1","M4A3_RCO_GL_EP1","Binocular_Vector","AK_74_GL_kobra","AKS_74","AKS_74_NSPU","AKS_74_GOSHAWK","FN_FAL","FN_FAL_ANPVS4","G36C_camo","G36_C_SD_camo","G36A_camo","G36K_camo","MG36_camo","M32_EP1","M79_EP1","Mk13_EP1","LeeEnfield","m107_TWS_EP1","M110_TWS_EP1","M110_NVG_EP1","M14_EP1","m240_scoped_EP1","M47Launcher_EP1","MAAWS","SCAR_L_CQC","SCAR_L_CQC_Holo","SCAR_L_STD_Mk4CQT","SCAR_L_STD_EGLM_RCO","SCAR_L_CQC_EGLM_Holo","SCAR_L_STD_EGLM_TWS","SCAR_L_STD_HOLO","SCAR_L_CQC_CCO_SD","SCAR_H_CQC_CCO","SCAR_H_CQC_CCO_SD","SCAR_H_STD_EGLM_Spect","SCAR_H_LNG_Sniper","SCAR_H_LNG_Sniper_SD","SCAR_H_STD_TWS_SD","AA12_PMC","PMC_AS50_scoped","PMC_AS50_TWS","m8_carbine_pmc","m8_compact_pmc","m8_holo_sd","m8_tws_sd","m8_tws"];

	_amountweapon = 2;
	_amountammo = 20;

	_refreshtime = 1800; 
	_crate allowDamage false;

	while {true} do {
		clearweaponcargo 	_crate;
		clearmagazinecargo 	_crate;	

		switch (_autoload) do {
			//case "base": {
			//	_listofweapons = _base - wclistofweapons;
			//};

			case "addons": {
				_listofweapons = wclistofweapons - _base;
			};

			default {
				_listofweapons = wclistofweapons;
			};
		};

		{_crate addWeaponCargo [_x, _amountweapon];} forEach _listofweapons;

		switch (_autoload) do {
			case "addons": {
				_magazines = [_listofweapons] call WC_fnc_enummagazines;
			};

			default {
				_magazines = [_listofweapons + ["Throw", "Put"]] call WC_fnc_enummagazines;
			};
		};

		{ _crate addMagazineCargo [_x, _amountammo];} foreach _magazines;
		
		sleep _refreshtime;
	};