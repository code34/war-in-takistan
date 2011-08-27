	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description: init
	// -----------------------------------------------

	titleText [localize "STR_WC_MESSAGEINITIALIZING", "BLACK FADED"];

	// initialize lobby parameters
	for "_i" from 0 to (count paramsArray - 1) do {
		call compile format["%1=%2;", configName ((missionConfigFile >> "Params") select _i), paramsArray select _i];
		sleep 0.01;
	};

	execVM "R3F_ARTY_AND_LOG\init.sqf";
	presetDialogUpdate = compile preprocessFile "bon_loadoutpresets\bon_func_presetdlgUpdate.sqf";

	wcterraingrid = 50;
	wcviewDist = 1500;
	setViewDistance wcviewDist;
	setTerrainGrid wcterraingrid;

	setGroupIconsVisible [false, false];
	if(wcwithenvironment == 0) then { enableEnvironment false;};

	WC_fnc_commoninitconfig 	= compile preprocessFile "warcontext\WC_fnc_commoninitconfig.sqf";
	WC_fnc_clientinitconfig 	= compile preprocessFile "warcontext\WC_fnc_clientinitconfig.sqf";
	WC_fnc_serverinitconfig 	= compile preprocessFile "warcontext\WC_fnc_serverinitconfig.sqf";

	wcgarbage = [] call WC_fnc_commoninitconfig;

	waituntil {!isnil "bis_fnc_init"};

	//
	//	CLIENT SIDE
	//
	if(local player) then { wcgarbage = [] execVM "warcontext\WC_fnc_clientsideW.sqf"; };


	//
	//	SERVER SIDE
	//
	if (!isServer) exitWith{};

	diag_log "WARCONTEXT: INITIALIZING MISSION";

	call compile preprocessFileLineNumbers "extern\Init_UPSMON.sqf";

	// external scripts
	EXT_fnc_atot 			= compile preprocessFile "extern\EXT_fnc_atot.sqf";
	EXT_fnc_createcomposition	= compile preprocessFile "extern\EXT_fnc_createcomposition.sqf";
	SortByDistance			= Compile preprocessFile "extern\Common_SortByDistance.sqf";
		
	// warcontext scripts
	WC_fnc_airpatrol 		= compile preprocessFile "warcontext\WC_fnc_airpatrol.sqf";
	WC_fnc_ambiantlife 		= compile preprocessFile "warcontext\WC_fnc_ambiantlife.sqf";
	WC_fnc_altercation 		= compile preprocessFile "warcontext\WC_fnc_altercation.sqf";
	WC_fnc_attachmarker 		= compile preprocessFile "warcontext\WC_fnc_attachmarker.sqf";
	WC_fnc_attachmarkerinzone	= compile preprocessFile "warcontext\WC_fnc_attachmarkerinzone.sqf";
	WC_fnc_backupbuilding		= compile preprocessFile "warcontext\WC_fnc_backupbuilding.sqf";
	WC_fnc_build			= compile preprocessFile "warcontext\WC_fnc_build.sqf";
	WC_fnc_bomb			= compile preprocessFile "warcontext\WC_fnc_bomb.sqf";
	WC_fnc_bringvehicle		= compile preprocessFile "warcontext\WC_fnc_bringvehicle.sqf";
	WC_fnc_civilianinit 		= compile preprocessFile "warcontext\WC_fnc_civilianinit.sqf";
	WC_fnc_clockformat 		= compile preprocessFile "warcontext\WC_fnc_clockformat.sqf";
	WC_fnc_computeavillage 		= compile preprocessFile "warcontext\WC_fnc_computeavillage.sqf";
	WC_fnc_copymarker 		= compile preprocessFile "warcontext\WC_fnc_copymarker.sqf";
	WC_fnc_copymarkerlocal 		= compile preprocessFile "warcontext\WC_fnc_copymarkerlocal.sqf";
	WC_fnc_createairpatrol		= compile preprocessFile "warcontext\WC_fnc_createairpatrol.sqf";
	WC_fnc_createairpatrol2		= compile preprocessFile "warcontext\WC_fnc_createairpatrol2.sqf";
	WC_fnc_createseapatrol		= compile preprocessFile "warcontext\WC_fnc_createseapatrol.sqf";
	WC_fnc_createsheep		= compile preprocessFile "warcontext\WC_fnc_createsheep.sqf";
	WC_fnc_createammobox 		= compile preprocessFile "warcontext\WC_fnc_createammobox.sqf";
	WC_fnc_createbunker 		= compile preprocessFile "warcontext\WC_fnc_createbunker.sqf";
	WC_fnc_createcivilcar 		= compile preprocessFile "warcontext\WC_fnc_createcivilcar.sqf";
	WC_fnc_creategroup 		= compile preprocessFile "warcontext\WC_fnc_creategroup.sqf";
	WC_fnc_creategroupdefend	= compile preprocessFile "warcontext\WC_fnc_creategroupdefend.sqf";
	WC_fnc_creategroupsupport	= compile preprocessFile "warcontext\WC_fnc_creategroupsupport.sqf";
	WC_fnc_createied 		= compile preprocessFile "warcontext\WC_fnc_createied.sqf";
	WC_fnc_createiedintown 		= compile preprocessFile "warcontext\WC_fnc_createiedintown.sqf";
	WC_fnc_creategridofposition	= compile preprocessFile "warcontext\WC_fnc_creategridofposition.sqf";
	WC_fnc_createlistofmissions	= compile preprocessFile "warcontext\WC_fnc_createlistofmissions.sqf";
	WC_fnc_createmarker 		= compile preprocessFile "warcontext\WC_fnc_createmarker.sqf";
	WC_fnc_createmarkerlocal	= compile preprocessFile "warcontext\WC_fnc_createmarkerlocal.sqf";
	WC_fnc_createmedic 		= compile preprocessFile "warcontext\WC_fnc_createmedic.sqf";
	WC_fnc_createmortuary		= compile preprocessFile "warcontext\WC_fnc_createmortuary.sqf";
	WC_fnc_createnuclearfire 	= compile preprocessFile "warcontext\WC_fnc_createnuclearfire.sqf";
	WC_fnc_createnuclearzone 	= compile preprocessFile "warcontext\WC_fnc_createnuclearzone.sqf";
	WC_fnc_createposition 		= compile preprocessFile "warcontext\WC_fnc_createposition.sqf";
	WC_fnc_createpositioninmarker 	= compile preprocessFile "warcontext\WC_fnc_createpositioninmarker.sqf";
	WC_fnc_createsidemission 	= compile preprocessFile "warcontext\WC_fnc_createsidemission.sqf";
	WC_fnc_createstatic	 	= compile preprocessFile "warcontext\WC_fnc_createstatic.sqf";
	WC_fnc_createteleporthq	 	= compile preprocessFile "warcontext\WC_fnc_createteleporthq.sqf";
	WC_fnc_debug			= compile preprocessFile "warcontext\WC_fnc_debug.sqf";
	WC_fnc_dosillything		= compile preprocessFile "warcontext\WC_fnc_dosillything.sqf";
	WC_fnc_defend			= compile preprocessFile "warcontext\WC_fnc_defend.sqf";
	WC_fnc_deletemarker		= compile preprocessFile "warcontext\WC_fnc_deletemarker.sqf";
	WC_fnc_destroygroup		= compile preprocessFile "warcontext\WC_fnc_destroygroup.sqf";
	WC_fnc_docircle			= compile preprocessFile "warcontext\WC_fnc_docircle.sqf";
	WC_fnc_dodrive			= compile preprocessFile "warcontext\WC_fnc_dodrive.sqf";
	WC_fnc_enumcompositions		= compile preprocessFile "warcontext\WC_fnc_enumcompositions.sqf";
	WC_fnc_enumfaction 		= compile preprocessFile "warcontext\WC_fnc_enumfaction.sqf";
	WC_fnc_enumcfgpatches 		= compile preprocessFile "warcontext\WC_fnc_enumcfgpatches.sqf";
	WC_fnc_enumvehicle 		= compile preprocessFile "warcontext\WC_fnc_enumvehicle.sqf";
	WC_fnc_enumweapons 		= compile preprocessFile "warcontext\WC_fnc_enumweapons.sqf";
	WC_fnc_eventhandler 		= compile preprocessFile "warcontext\WC_fnc_eventhandler.sqf";
	WC_fnc_fireflare 		= compile preprocessFile "warcontext\WC_fnc_fireflare.sqf";
	WC_fnc_flare	 		= compile preprocessFile "warcontext\WC_fnc_flare.sqf";
	WC_fnc_getterraformvariance	= compile preprocessFile "warcontext\WC_fnc_getterraformvariance.sqf";
	WC_fnc_grouphandler		= compile preprocessFile "warcontext\WC_fnc_grouphandler.sqf";
	WC_fnc_getobject		= compile preprocessFile "warcontext\WC_fnc_getobject.sqf";
	WC_fnc_heal			= compile preprocessFile "warcontext\WC_fnc_heal.sqf";
	WC_fnc_jail			= compile preprocessFile "warcontext\WC_fnc_jail.sqf";
	WC_fnc_mainloop 		= compile preprocessFile "warcontext\WC_fnc_mainloop.sqf";
	WC_fnc_liberatehotage 		= compile preprocessFile "warcontext\WC_fnc_liberatehotage.sqf";
	WC_fnc_loadweapons 		= compile preprocessFile "warcontext\WC_fnc_loadweapons.sqf";
	WC_fnc_markerhint		= compile preprocessFile "warcontext\WC_fnc_markerhint.sqf";
	WC_fnc_mortar		 	= compile preprocessFile "warcontext\WC_fnc_mortar.sqf";
	WC_fnc_missionname	 	= compile preprocessFile "warcontext\WC_fnc_missionname.sqf";
	WC_fnc_nastyvehicleevent	= compile preprocessFile "warcontext\WC_fnc_nastyvehicleevent.sqf";
	WC_fnc_patrol			= compile preprocessFile "warcontext\WC_fnc_patrol.sqf";
	WC_fnc_protectobject		= compile preprocessFile "warcontext\WC_fnc_protectobject.sqf";
	WC_fnc_propagand		= compile preprocessFile "warcontext\WC_fnc_propagand.sqf";
	WC_fnc_publishmission		= compile preprocessFile "warcontext\WC_fnc_publishmission.sqf";
	WC_fnc_rescuecivil		= compile preprocessFile "warcontext\WC_fnc_rescuecivil.sqf";
	WC_fnc_rob			= compile preprocessFile "warcontext\WC_fnc_rob.sqf";
	WC_fnc_relocatelocation		= compile preprocessFile "warcontext\WC_fnc_relocatelocation.sqf";
	WC_fnc_relocateposition		= compile preprocessFile "warcontext\WC_fnc_relocateposition.sqf";
	WC_fnc_restorebuilding 		= compile preprocessFile "warcontext\WC_fnc_restorebuilding.sqf";
	WC_fnc_garbagecollector		= compile preprocessFile "warcontext\WC_fnc_garbagecollector.sqf";
	WC_fnc_respawnvehicle		= compile preprocessFile "warcontext\WC_fnc_respawnvehicle.sqf";
	WC_fnc_sabotagecivilian 	= compile preprocessFile "warcontext\WC_fnc_sabotagecivilian.sqf";
	WC_fnc_setskill 		= compile preprocessFile "warcontext\WC_fnc_setskill.sqf";
	WC_fnc_serverside 		= compile preprocessFile "warcontext\WC_fnc_serverside.sqf";
	WC_fnc_sentinelle	 	= compile preprocessFile "warcontext\WC_fnc_sentinelle.sqf";
	WC_fnc_seed	 		= compile preprocessFile "warcontext\WC_fnc_seed.sqf";
	WC_fnc_sortlocationbydistance	= compile preprocessFile "warcontext\WC_fnc_sortlocationbydistance.sqf";
	WC_fnc_support	 		= compile preprocessFile "warcontext\WC_fnc_support.sqf";
	WC_fnc_steal	 		= compile preprocessFile "warcontext\WC_fnc_steal.sqf";
	WC_fnc_sabotage	 		= compile preprocessFile "warcontext\WC_fnc_sabotage.sqf";
	WC_fnc_securezone 		= compile preprocessFile "warcontext\WC_fnc_securezone.sqf";
	WC_fnc_vehiclehandler 		= compile preprocessFile "warcontext\WC_fnc_vehiclehandler.sqf";
	WC_fnc_weather		 	= compile preprocessFile "warcontext\WC_fnc_weather.sqf";
	
	// Init global variables
	wcgarbage = [] call WC_fnc_serverinitconfig;

	// Init Debugger
	wcgarbage = [] spawn WC_fnc_debug;

	// Init Mission - Main loop
	wcgarbage = [] spawn WC_fnc_mainloop;

	// Init Weather
	wcgarbage = [] spawn WC_fnc_weather;

	// Init Server SIDE
	wcgarbage = [] spawn WC_fnc_serverside;