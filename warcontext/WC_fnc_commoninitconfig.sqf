	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: init configuration file
	// -----------------------------------------------
	#include "common.hpp"

	wcversion	= 1.34;

	wcside 		=  [west];
	
	// enemy side
	wcenemyside	= [east, resistance];

	// Limit min of fps on server under no more units will be create for support
	wcminfpsonserver = 15;

	// Adress of teamspeak server
	wcteamspeak = "[FR] join us: \n ts3.air-commando.org:9987 \n pass: ackillaz";

	// limit of playable map
	switch (tolower(worldname)) do {
		case "hellskitchen": {
			wcmaptopright 	= [4795, 5050];
			wcmapbottomleft = [129, 455];
		};

		case "isoladicapraia" : {
			wcmaptopright 	= [7695.45,9788.42];
			wcmapbottomleft = [2264.97,544.557];
		};

		default {
			wcmaptopright 	= [12700, 12700];
			wcmapbottomleft = [0, 0];
		};
	};

	// Kind of engineer
	wcengineerclass = ["ACE_USMC_SoldierS_Engineer_D", "HEXA_Soldier_ISAf", "US_Soldier_Engineer_EP1", "BWMod_EngineerG", "BWMod_EngineerG_Desert", "BWMod_EngineerG_ISAF", "US_Soldier_Engineer_EP1_retex_ger_des", "US_Soldier_Engineer_EP1_retex_ger_wdl", "FR_Sykes", "US_Delta_Force_Night_EP1"];

	// Kind of medics
	wcmedicclass = ["ACE_USMC_Soldier_Medic_D", "HEXA_Soldier_ISAF_Medic", "FR_OHara", "USMC_Soldier_Medic", "GER_Soldier_Medic_EP1", "US_Delta_Force_Medic_EP1", "US_Soldier_Medic_EP1", "BWMod_MedicG", "BWMod_MedicG_Desert", "BWMod_MedicG_ISAF", "US_Delta_Force_Medic_EP1_retex_ger_des", "US_Soldier_Medic_EP1_retex_ger_des", "US_Delta_Force_Medic_EP1_retex_ger_wdl", "US_Soldier_Medic_EP1_retex_ger_wdl", "GER_Soldier_Medic_EP1_des", "GER_Soldier_Medic_EP1_wdl", "RU_Soldier_Medic"];

	// Simulation mode has a harder scoring system
	if(wckindofgame == 1) then {
		wcscorelimitmin = -80; 
		wcscorelimitmax = 99;
	} else {
		wcscorelimitmin = -20; 
		wcscorelimitmax = 25;
	};

	// contain all nuclear zone
	wcnuclearzone = [];

	// count number of day
	wcday = 1;

	// position of goal zone
	wcselectedzone = [0,0,0];

	// radio is alive or not
	wcradioalive = true;

	// level start at ..
	wclevel = 1;

	// IA skill
	if(wckindofgame == 1) then {
		wcskill = 0.38;
		wcskill = wcskill + (wclevel * 0.02);
	} else {
		wcskill = 0.68;
		wcskill = wcskill + (wclevel * 0.02);
	};


	// number of enemy killed
	wcenemykilled = 0;
	wccivilkilled = 0;

	// count number of mission
	wcmissioncount = 1;

	// array of all players in team
	wcinteam = [];

	true;