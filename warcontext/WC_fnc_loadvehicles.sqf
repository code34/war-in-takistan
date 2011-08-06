	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a mission dialog box
	// locality : client side

	private [
		"_missionnumber", 
		"_name", 
		"_textbox", 
		"_index", 
		"_rank",
		"_type",
		"_maxsize",
		"_unit",
		"_vehicles"
	];

	if!(name player in wcinteam) exitwith {
		[localize "STR_WC_MENURECRUITMENT", "Only members of team can build", "Wait to be recruit as team member", 10] spawn WC_fnc_playerhint;
		closedialog 0;
	};

	disableSerialization;
	_textbox = (uiNamespace getVariable 'wcdisplay') displayCtrl 7001;

	switch(wcwithvehicles) do {
		case 1: {
			_vehicles = [];
		};

		case 2: {
			_vehicles = ["ATV_US_EP1"];
		};

		case 3: {
			_vehicles = ["M1A1","M1A2_TUSK_MG","HMMWV_M2","HMMWV_TOW","HMMWV_MK19","HMMWV","HMMWV_Armored","HMMWV_Ambulance","HMMWV_Avenger","LAV25","LAV25_HQ","MMT_USMC","MTVR","MtvrReammo","MtvrRefuel","MtvrRepair","M1030","HMMWV_DES_EP1","HMMWV_MK19_DES_EP1","HMMWV_Avenger_DES_EP1","M1030_US_DES_EP1","MTVR_DES_EP1","MtvrReammo_DES_EP1","MtvrRefuel_DES_EP1","MtvrRepair_DES_EP1","MtvrSupply_DES_EP1","MtvrSalvage_DES_EP1","ATV_US_EP1","ATV_CZ_EP1","HMMWV_M1035_DES_EP1","HMMWV_M1151_M2_CZ_DES_EP1","HMMWV_M1151_M2_DES_EP1","HMMWV_M998_crows_M2_DES_EP1","HMMWV_M998_crows_MK19_DES_EP1","HMMWV_M998A2_SOV_DES_EP1","HMMWV_TOW_DES_EP1","HMMWV_Terminal_EP1","LandRover_CZ_EP1","LandRover_Special_CZ_EP1","M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","M1130_CV_EP1","M1129_MC_EP1","M1135_ATGMV_EP1","M1128_MGS_EP1","M1133_MEV_EP1","M1A1_US_DES_EP1","M1A2_US_TUSK_MG_EP1","MLRS_DES_EP1","M2A2_EP1","M2A3_EP1","M6_EP1","BAF_ATV_D","BAF_Offroad_D","BAF_Jackal2_L2A1_D","BAF_Jackal2_GMG_D","BAF_ATV_W","BAF_Offroad_W","BAF_Jackal2_L2A1_W","BAF_Jackal2_GMG_W","BAF_FV510_D","BAF_FV510_W"] - ["M1A1","M1A2_TUSK_MG","BMP2_CDF","BMP2_Ambul_CDF","BMP2_HQ_CDF","T72_CDF","ZSU_CDF","HMMWV_M2","HMMWV_TOW","HMMWV_MK19","HMMWV","UAZ_MG_CDF","UAZ_AGS30_CDF","UAZ_CDF","Ural_CDF","UralOpen_CDF","UralRepair_CDF","UralReammo_CDF","UralRefuel_CDF","Ural_ZU23_CDF","BRDM2_CDF","BRDM2_ATGM_CDF","GRAD_CDF","AAV","MLRS","HMMWV_Armored","HMMWV_Ambulance","HMMWV_Avenger","LAV25","LAV25_HQ","MMT_USMC","MTVR","MtvrReammo","MtvrRefuel","MtvrRepair","TowingTractor","M1030","WarfareSalvageTruck_USMC","WarfareSupplyTruck_USMC","WarfareReammoTruck_USMC","WarfareSalvageTruck_CDF","WarfareSupplyTruck_CDF","WarfareReammoTruck_CDF"];
		};
	};

	{
		lbAdd [7002, _x];
	}foreach _vehicles;
	lbSetCurSel [7002, 0];

	while {alive player && dialog} do {
		_index = lbCurSel 7002;
		_type = lbText [7002, _index];

		if(menuaction == 1) then {
			["Build a vehicle", "Wait while the building of your vehicle", "The vehicle will appear near you in few seconds. Older one will be delete.", 3] spawn WC_fnc_playerhint;
			_position = (position player) findemptyposition [5, 30];
			deletevehicle wcmyatv;
			wcmyatv = _type createVehicle _position;
			closedialog 0;
			menuaction = -1;
		};
		if(menuaction == 2) then {
			closedialog 0;
			menuaction = -1;
		};
		sleep 0.5;
	};